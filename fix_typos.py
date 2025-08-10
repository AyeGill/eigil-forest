#!/usr/bin/env python3
"""
Script to fix common typos identified by spellcheck in .tree files
"""

import os
import re
from pathlib import Path

# Common typos and their corrections
TYPO_FIXES = {
    r'\baren\b': "aren't",
    r'\bhencee\b': 'hence',
    r'\bhopefull\b': 'hopefully', 
    r'\bhierarchial\b': 'hierarchical',
    r'\binvoved\b': 'involved',
    r'\bisn\b': "isn't",
    r'\bshouldn\b': "shouldn't", 
    r'\bmorphims\b': 'morphisms',
    r'\bmorover\b': 'moreover',
    r'\bfunctorialty\b': 'functoriality',
    r'\bfinitions\b': 'definitions',
    r'\bfferentiation\b': 'differentiation',
    r'\binherets\b': 'inherits',
    r'\bincluson\b': 'inclusion',
    r'\bindepdendent\b': 'independent',
    r'\bindictator\b': 'indicator', 
    r'\bindpendence\b': 'independence',
    r'\bintepret\b': 'interpret',
    r'\binternall\b': 'internal',
    r'\bisomorhism\b': 'isomorphism',
    r'\biven\b': 'given',
    r'\bmodifi\b': 'modify',
    r'\bpredice\b': 'predicate',
    r'\bprefibratio\b': 'prefibration',
    r'\bproesses\b': 'processes',
    r'\bproove\b': 'prove',
    r'\bproprty\b': 'property',
    r'\bpseduonaturality\b': 'pseudonaturality',
    r'\bpseudofuncot\b': 'pseudofunctor',
    r'\bpushfoward\b': 'pushforward',
    r'\brepresentative\b': 'representative',
    r'\brestric\b': 'restrict',
    r'\bsasisfy\b': 'satisfy',
    r'\bsimplical\b': 'simplicial',
    r'\bsitutation\b': 'situation',
    r'\bspecifiying\b': 'specifying',
    r'\bstochastich\b': 'stochastic',
    r'\bstraighforward\b': 'straightforward', 
    r'\bstrategiess\b': 'strategies',
    r'\btexbook\b': 'textbook',
    r'\btheorie\b': 'theory',
    r'\btherfore\b': 'therefore',
    r'\btoplogical\b': 'topological',
    r'\btrivival\b': 'trivial',
    r'\btthe\b': 'the',
    r'\bunform\b': 'uniform',
    r'\bunitalilty\b': 'unitality',
    r'\bparamterizing\b': 'parameterizing',
    r'\borganised\b': 'organized',
    r'\bexcesively\b': 'excessively',
    r'\bexpressable\b': 'expressible',
    r'\bextesion\b': 'extension',
    r'\bequivalene\b': 'equivalence',
    r'\bequvalently\b': 'equivalently',
    r'\bsliding equivalene\b': 'sliding equivalence',
    r'\brepresentability\b': 'representability',
    r'\brepresentative\b': 'representative'
}

def fix_file(file_path):
    """Fix typos in a single file."""
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    original_content = content
    
    # Apply fixes
    for typo_pattern, correction in TYPO_FIXES.items():
        content = re.sub(typo_pattern, correction, content)
    
    # Only write if changes were made
    if content != original_content:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(content)
        return True
    return False

def main():
    """Fix typos in all .tree files."""
    trees_dir = Path('trees')
    if not trees_dir.exists():
        print("trees/ directory not found")
        return
    
    fixed_files = []
    
    for tree_file in trees_dir.glob('**/*.tree'):
        if fix_file(tree_file):
            fixed_files.append(tree_file)
    
    print(f"Fixed typos in {len(fixed_files)} files:")
    for file_path in fixed_files[:10]:  # Show first 10
        print(f"  {file_path}")
    if len(fixed_files) > 10:
        print(f"  ... and {len(fixed_files) - 10} more")

if __name__ == '__main__':
    main()