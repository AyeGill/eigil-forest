#!/usr/bin/env python3
"""
Spellcheck script for Forester .tree files.

This script extracts English prose from .tree files while ignoring:
- Math expressions wrapped in #{}
- Figures written with \\quiver{}
- Commands and metadata (\\title{}, \\date{}, etc.)
- References like \\ref{}

It focuses on checking text inside \\p{}, titles, and other content blocks.
"""

import re
import os
import sys
import argparse
from pathlib import Path
from typing import List, Set, Tuple
from spellchecker import SpellChecker


class ForesterParser:
    """Parser for extracting English text from Forester .tree files."""
    
    def __init__(self):
        self.spell = SpellChecker()
        # Add domain-specific terms that should be ignored
        self.custom_words = {
            'fibration', 'fibrations', 'optics', 'lenses', 'forester', 'markov', 'categorical',
            'bicategory', 'bicategories', 'monoidal', 'functorial', 'grothendieck',
            'eigil', 'rischel', 'efr', 'hedges', 'myers', 'fritz', 'spivak', 'riley',
            'cybernetics', 'gametheory', 'compositionality', 'compositional',
            'fiberwise', 'coend', 'profunctor', 'profunctors', 'topos', 'topoi',
            'presheaf', 'presheaves', 'pullback', 'pullbacks', 'pushout', 'pushouts',
            'colimit', 'colimits', 'kan', 'yoneda', 'adjunction', 'adjunctions',
            'cartesian', 'cocartesian', 'kleisli', 'eilenberg', 'mac', 'lane',
            'coalgebra', 'coalgebras', 'homomorphism', 'homomorphisms',
            'isomorphism', 'isomorphisms', 'endomorphism', 'endomorphisms',
            'automorphism', 'automorphisms', 'covariant', 'contravariant', 'etc', 'monoids', 'homotopy', 'pseudofunctor', 'pseudofunctors', 'levelwise',
            'stochastic', 'probabilistic', 'bayesian', 'reinforcement',
            'cybernetic', 'dynamical', 'parametrized', 'equilibrium',
            'minimax', 'von', 'neumann', 'morgenstern', 'nash', 'pareto',
            'arxiv', 'doi', 'isbn', 'issn', 'endofunctor', 'abelian', 'accessors', 'ackermann', 'actegorical',
            'actegories', 'adagrad', 'adjoints', 'agda', 'adjoint', 'amfr', 'amthematician', 'app', 'actegory',
            'aren', 'associator', 'axiomatisation', 'axiomatise', 'biactegories', 'biadjoint', 'biaffine', 'bialgebras', 'bicat', 'biequivalent', 'bifibration', 'bifibrations'
            'backprop', 'backpropagation', 'badings', 'baire', 'basechange', 'basepoint', 'basepoint', 'basu', 'beckers', 'behaviour', 'behavioural', 'behaviourally',
            'behaviours', 'benabou', 'bidirectionality', 'functor', 'functors', 'morphism', 'scm', 'tikzcd', 'tensoring',
            'braithwaite', 'capucci', 'davidad', 'fong', 'tuyeras', 'gonda', 'ghani', 'mardare', 'radu', 'jaz', 'kessler', 'lavore', 'matteo', 'nakamura', 'nester', 'paolo', 'pawel', 'perrone', 'riu', 'smithe', 'sobocinski', 'videla',
            'iid', 'priori', 'mdp', 'mdps', 'precomposition', 'subobject','tuple', 'bisystem', 'bisystems', 'reparametrization', 'reparametrizations', 'isoparametrization', 'isoparametrizations',
            'functoriality', 'morphisms', 'pseudoassociative', 'pseudocategory', 'pseudomonoid', 'pseudomonoids', 'cospan', 'pseudolimits', 'iwss', 'isomorphically', 'lurie', 'preadditive',
            'pointwise', 'coproduct', 'coproducts', 'kolmogorov', 'tuples', 'supremum', 'timestep', 'resamples', 'cst', 'doesn', 'resampling', 'cofiltered', 'coinductive',
            'coalgebraic', 'cofree', 'resample', 'fixpoint', 'timesteps', 'endo', 'codomain', 'hom', 'fibre', 'drr', 'drrr', 'drrrr', 'shouldn',
            'subpresheaf', 'subterminal', 'copresheaf', 'copresheaves', 'borel', 'drr', 'ddr', 'rrd', 'corepresentable', 'comonoid', 'monoid',
            'simplicial', 'prefibration', 'moeller', 'vasilakopoulou', 'injective', 'surjective', 'prefibrations','shulman', 'fibred',
            'bijective', 'naturality', 'pseudocategories', 'isofibrations', 'segal', 'composable', 'fibrant', 'coskeletal', 'coskeletality',
            'isofibrant', 'isofibration', 'booleans', 'dualizing', 'sdes', 'lipschitz', 'covector', 'covectors', 'microlinear', 'bisimilar',
            'finitary', 'hennessy', 'milner', 'postcomposition', 'clopen', 'unitor', 'riesz', 'staton', 'reindexing', 'bimachines',
            'rightarrow', 'sep', 'bifunctor', 'tri', 'postcomposing', 'unintuitive', 'unparametrized', 'libkind', 'operadic',
            'bicategorical', 'hermida', 'tennent', 'delooping', 'bidual', 'bisimulation', 'pseudometric', 'subdiagram', 'bisimilarity',
            'nondeterministic', 'isofibrancy', 'opfibration', 'trisimplicial', 'coyoneda', 'simplices',
            'nondegenerate', 'surjections', 'cofibrant', 'cofibrations', 'cofibration', 'cosegal', 'cosimplicial',
            'equifibration', 'equifibrations', 'biequivalence', 'biequivalences', 'fibrancy', 'paoli', 'https', 'pos', 'uiver',
            'underspecified', 'fibres', 'relatedly', 'oplax', 'bisimplicial', 'promonoidal', 'misc', 'sota', 'paperswithcode', 'pseudonatural',
            'representability', 'monomorphism', 'premarkov', 'frechet', 'semicartesian', 'zag', 'nonidentity', 'functionals', 'dcst',
            'monomorphisms', 'precomposing', 'preequipped', 'cadlag', 'dataset', 'bihomomorphisms', 'bimodules',
            'bochner', 'bogdanovi', 'bottcher', 'bourke', 'bousfield', 'chalupka', 'cisinski', 'cayley', 'cospans', 'convexopt', 'cooptic', 'cooptics',
            'cokleisli', 'duskin', 'interventional', 'inequation', 'giry', 'haugseng', 'halpern', 'hausdorffness', 'generalises', 'jagadeesan', 'jcgm', 'joyal',
            'kakutani', 'kantorovich', 'kmts', 'intercategories', 'groupoids', 'groupoid', 'goodhart', 'hille', 'yosida', 'intro',
            'backprop', 'bifibrations', 'bijections', 'bilimits', 'bimorphic', 'bimorphisms', 'bisimulations',
            'bisys', 'blogpost', 'braidings', 'brycecklarke', 'cantelli', 'caratheodory', 'catcolab', 'categorified', 'cdf', 'cetera',
            'chartwise', 'chevalley', 'cho', 'chu', 'coutility', 'circ', 'ciri', 'cirsea', 'comodality', 
        }
        self.spell.word_frequency.load_words(self.custom_words)
    
    def extract_text_from_braces(self, text: str, start_pos: int) -> Tuple[str, int]:
        """Extract text from balanced braces starting at start_pos."""
        if start_pos >= len(text) or text[start_pos] != '{':
            return "", start_pos
        
        brace_count = 0
        i = start_pos
        while i < len(text):
            if text[i] == '{':
                brace_count += 1
            elif text[i] == '}':
                brace_count -= 1
                if brace_count == 0:
                    return text[start_pos + 1:i], i + 1
            i += 1
        
        # Unmatched braces - return what we have
        return text[start_pos + 1:], len(text)
    
    def clean_math_and_commands(self, text: str) -> str:
        """Remove math expressions and commands from text."""
        # Remove math expressions #{...}
        text = re.sub(r'#\{[^{}]*(?:\{[^{}]*\}[^{}]*)*\}', '', text)
        
        # Remove references and citations
        text = re.sub(r'\\ref\{[^}]+\}', '', text)
        text = re.sub(r'\\cite\{[^}]+\}', '', text)
        
        # Remove common formatting commands but keep their content
        text = re.sub(r'\\em\{([^}]+)\}', r'\1', text)
        text = re.sub(r'\\strong\{([^}]+)\}', r'\1', text)
        text = re.sub(r'\\textbf\{([^}]+)\}', r'\1', text)
        text = re.sub(r'\\emph\{([^}]+)\}', r'\1', text)
        
        # Remove remaining backslash commands
        text = re.sub(r'\\[a-zA-Z]+\*?', '', text)
        
        # Clean up extra whitespace
        text = re.sub(r'\s+', ' ', text).strip()
        
        return text
    
    def extract_english_text(self, content: str) -> List[str]:
        """Extract English text from forester content."""
        text_blocks = []
        
        # Find text in \p{...} blocks
        p_pattern = r'\\p\{'
        pos = 0
        while True:
            match = re.search(p_pattern, content[pos:])
            if not match:
                break
            
            match_start = pos + match.start() + len(match.group())
            brace_content, next_pos = self.extract_text_from_braces(
                content, match_start - 1
            )
            
            if brace_content:
                cleaned = self.clean_math_and_commands(brace_content)
                if cleaned.strip():
                    text_blocks.append(cleaned)
            
            pos = next_pos
        
        # Find text in \title{...} blocks  
        title_pattern = r'\\title\{'
        pos = 0
        while True:
            match = re.search(title_pattern, content[pos:])
            if not match:
                break
            
            match_start = pos + match.start() + len(match.group())
            brace_content, next_pos = self.extract_text_from_braces(
                content, match_start - 1
            )
            
            if brace_content:
                cleaned = self.clean_math_and_commands(brace_content)
                if cleaned.strip():
                    text_blocks.append(cleaned)
            
            pos = next_pos
        
        # Find text in other content blocks (remark, definition, etc.)
        content_commands = [
            'remark', 'definition', 'proposition', 'theorem', 'lemma', 
            'corollary', 'example', 'proof', 'abstract', 'idea', 'notes'
        ]
        
        for cmd in content_commands:
            pattern = f'\\\\{cmd}\\{{'
            pos = 0
            while True:
                match = re.search(pattern, content[pos:])
                if not match:
                    break
                
                match_start = pos + match.start() + len(match.group())
                brace_content, next_pos = self.extract_text_from_braces(
                    content, match_start - 1
                )
                
                if brace_content:
                    cleaned = self.clean_math_and_commands(brace_content)
                    if cleaned.strip():
                        text_blocks.append(cleaned)
                
                pos = next_pos
        
        return text_blocks
    
    def extract_words(self, text: str) -> List[str]:
        """Extract individual words from text for spellchecking."""
        # Remove punctuation and split into words
        words = re.findall(r'\b[a-zA-Z]+\b', text.lower())
        
        # Filter out very short words and common abbreviations
        filtered_words = []
        for word in words:
            if len(word) >= 3 and not word.isupper():
                filtered_words.append(word)
        
        return filtered_words
    
    def check_file(self, filepath: Path) -> List[Tuple[str, Set[str]]]:
        """Check spelling in a single .tree file."""
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
        except UnicodeDecodeError:
            print(f"Warning: Could not read {filepath} (encoding issue)")
            return []
        
        text_blocks = self.extract_english_text(content)
        results = []
        
        for block in text_blocks:
            words = self.extract_words(block)
            if words:
                misspelled = self.spell.unknown(words)
                if misspelled:
                    results.append((block, misspelled))
        
        return results
    
    def check_directory(self, tree_dir: Path) -> dict:
        """Check all .tree files in directory."""
        all_results = {}
        
        tree_files = list(tree_dir.glob('**/*.tree'))
        if not tree_files:
            print(f"No .tree files found in {tree_dir}")
            return all_results
        
        print(f"Found {len(tree_files)} .tree files")
        
        for filepath in sorted(tree_files):
            results = self.check_file(filepath)
            if results:
                all_results[str(filepath.relative_to(tree_dir))] = results
        
        return all_results


def main():
    parser = argparse.ArgumentParser(
        description='Spellcheck Forester .tree files'
    )
    parser.add_argument(
        'path',
        nargs='?',
        default='trees',
        help='Path to .tree file or directory (default: trees)'
    )
    parser.add_argument(
        '--summary-only',
        action='store_true',
        help='Show only summary statistics'
    )
    
    args = parser.parse_args()
    
    path = Path(args.path)
    if not path.exists():
        print(f"Error: Path {path} does not exist")
        sys.exit(1)
    
    forester_parser = ForesterParser()
    
    if path.is_file():
        if not path.suffix == '.tree':
            print("Error: File must have .tree extension")
            sys.exit(1)
        results = forester_parser.check_file(path)
        all_results = {str(path.name): results} if results else {}
    else:
        all_results = forester_parser.check_directory(path)
    
    # Display results
    total_files_with_errors = len(all_results)
    total_errors = sum(len(blocks) for blocks in all_results.values())
    total_unique_misspellings = set()
    
    if not args.summary_only:
        for filepath, file_results in all_results.items():
            print(f"\n=== {filepath} ===")
            for block, misspelled in file_results:
                print(f"\nText block: {block[:80]}...")
                print(f"Misspelled words: {', '.join(sorted(misspelled))}")
                total_unique_misspellings.update(misspelled)
    
    # Summary
    if all_results:
        for blocks in all_results.values():
            for _, misspelled in blocks:
                total_unique_misspellings.update(misspelled)
        
        print(f"\n=== SUMMARY ===")
        print(f"Files with spelling errors: {total_files_with_errors}")
        print(f"Total text blocks with errors: {total_errors}")
        print(f"Unique misspelled words: {len(total_unique_misspellings)}")
        
        if total_unique_misspellings:
            print(f"All misspelled words: {', '.join(sorted(total_unique_misspellings))}")
    else:
        print("No spelling errors found!")


if __name__ == '__main__':
    main()