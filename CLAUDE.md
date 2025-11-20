# Instructions for Claude Code

This repository contains personal math research notes written in **Forester**, a hypertext documentation system for mathematics.

## Important: File Management

This project contains a vast number of source files (.tree files) which are not easily indexable by file name.
**Don't load them all into context at once.** Instead, use terminal tools like `grep` and `find` to search for the ones you need.

---

## About Forester

**Forester** is a tool for creating mathematical "forests" - interconnected hypertext documentation with first-class support for mathematics and LaTeX. It was created by Jon Sterling and is particularly well-suited for Zettelkasten-style note-taking in mathematics.

- **Official repository**: https://git.sr.ht/~jonsterling/ocaml-forester
- **Installation**: `opam install forester`
- **Build this forest**: Run `./build.sh` (requires LaTeX and forester)
- **Output**: Browser-viewable HTML at `output/index.xml`

---

## Forester File Format

Forester uses **`.tree` files** with a custom markup language. Each tree has a unique identifier (e.g., `efr-0001`, `efr-HQ73`).

### Basic Structure

```
\title{Title of the Note}
\date{2024-05-25}
\author{eigil-rischel}
\import{macros}
\taxon{Definition}  % Optional: Definition, Theorem, Example, Reference, etc.

\p{
  Paragraph content goes here. Math is written in LaTeX: #{x \in \mathbb{R}}
}
```

### Common Commands

#### Metadata
- `\title{...}` - Title of the tree
- `\date{YYYY-MM-DD}` - Date
- `\author{...}` - Author
- `\taxon{...}` - Type of content (Definition, Theorem, Lemma, Example, Proposition, Reference, etc.)
- `\import{macros}` - Import custom macros from `trees/utils/macros.tree`

#### Content Structure
- `\p{...}` - Paragraph
- `\ul{\li{...} \li{...}}` - Unordered list with list items
- `\ol{\li{...} \li{...}}` - Ordered list
- `\subtree{...}` - Nested subtree (inline subdivision)
- `\transclude{tree-id}` - Include another tree by ID

#### Text Formatting
- `\em{...}` - Emphasis (italic)
- `\strong{...}` - Bold
- `\code{...}` - Inline code

#### Mathematics
- `#{...}` - Inline math (LaTeX)
- Math is written in standard LaTeX syntax within `#{...}` delimiters

#### References and Links
- `\ref{tree-id}` - Reference to another tree by ID
- `[[tree-id]]` - Alternative link syntax
- `\cite{bib-key}` - Citation (bibliographic references are in `trees/refs/`)

#### Diagrams
- `\quiver{...}` - Commutative diagrams using quiver/tikz-cd
- `\figure{...}` - Figures
- `\image[source]{path}` - Images

#### Special Blocks
- `\startverb ... \stopverb` - Verbatim text

### Custom Macros

This forest defines extensive custom macros in `trees/utils/macros.tree`:

#### Mathematical Symbols
- **Blackboard bold**: `\AA`, `\BB`, `\CC`, ..., `\ZZ` → #{\mathbb{A}}, #{\mathbb{B}}, etc.
- **Bold**: `\bA`, `\bB`, ..., `\bZ` → #{\mathbf{A}}, #{\mathbf{B}}, etc.
- **Calligraphic**: `\cA`, `\cB`, ..., `\cZ` → #{\mathcal{A}}, #{\mathcal{B}}, etc.
- **Fraktur**: `\fA`, `\fB`, ..., `\fZ` → #{\mathfrak{A}}, #{\mathfrak{B}}, etc.
- **Script**: `\sA`, `\sB`, ..., `\sZ` → #{\mathscr{A}}, #{\mathscr{B}}, etc.

#### Category Theory
- `\Cat`, `\Set`, `\Top`, `\Poly`, `\Lens`, `\Span`, `\Prof`, `\Rel`
- `\into` (hookrightarrow), `\onto` (twoheadrightarrow), `\from` (leftarrow)
- `\then` (composition), `\lensto` (lens arrow)
- `\Hom`, `\dom`, `\cod`, `\limit`, `\colimit`
- `\op` (opposite), `\id` (identity)

#### Probability & Markov Categories
- `\Stoch`, `\Meas`, `\BorelStoch`, `\Markov`
- `\det` (deterministic), `\copy`, `\del`
- `\expect` (#{\mathbb{E}}), `\indep` (independence)

#### Semantic Blocks (defined as macros)
- `\abstract[body]{...}` - Abstract section
- `\lemma[title][body]{...}` - Lemma
- `\definition[title][body]{...}` - Definition
- `\proposition[title][body]{...}` - Proposition
- `\example[title][body]{...}` - Example
- `\remark[body]{...}` - Remark
- `\proof[body]{...}` - Proof
- `\idea[body]{...}` - Idea section
- `\notes[body]{...}` - Notes section

#### External Links
- `\nlab[article]{...}` - Link to nLab
- `\wikipedia[article]{...}` - Link to Wikipedia

#### Utility
- `\todo[note]{...}` - TODO marker (red text)
- `\defcase[term]{...}` - Term being defined (bold)

---

## Repository Structure

```
trees/
  general/          # Main research notes (efr-XXXX.tree)
  refs/             # Bibliographic references
  people/           # People/authors
  utils/
    macros.tree     # Custom macro definitions
  old-blog-files/   # Migrated blog posts
  localcharts-files/
templates/
  efr-note.tree     # Template for new notes
output/             # Generated HTML (after build)
```

### Tree Naming Convention

Trees are identified by codes like:
- `efr-0001`, `efr-0002`, ... (base-36 numbering)
- `efr-HQ73`, `efr-ZRUZ` (more compact IDs for newer notes)

---

## Finding and Reading Notes

### Search by Content
```bash
# Find trees mentioning "Markov category"
grep -r "Markov category" trees/general/

# Find all definitions
grep -l "\\taxon{Definition}" trees/general/*.tree

# Find trees referencing a specific ID
grep -l "efr-0001" trees/general/*.tree
```

### Search by Title
```bash
# Trees with "fibration" in the title
grep "\\title.*[Ff]ibration" trees/general/*.tree
```

### Understanding Transclusion
Many trees are organizational and primarily consist of `\transclude` commands that include other trees. For example, `efr-0001.tree` is "Markov Fibrations" and transcludes several sub-topics.

---

## Key Topics in This Forest

Based on the tags in README.md:
- **old-blog**: Blog posts from previous website (may have formatting issues)
- **blog-post**: Trees intended as blog posts (syndicated in `efr-AE01`)

Main research areas include:
- Markov categories and probability theory
- Category theory (fibrations, 2-categories, double categories)
- Lenses and optics
- Compositional systems theory
- Causality and structural causal models
- Game theory

---

## Working with This Repository

### Building
```bash
./build.sh           # Build the forest
./watch.sh           # Watch and rebuild on changes (requires fswatch)
nix develop          # Enter nix shell with dependencies (optional)
```

### Creating New Notes
Use the template at `templates/efr-note.tree` which contains:
```
\author{eigil-rischel}
\import{macros}
```

### When Reading Trees
1. Check `\transclude` commands - they indicate the tree includes other trees
2. Look at `\taxon` to understand what type of content it is
3. Use `\ref{...}` commands to find related trees
4. Remember that math is in `#{...}` delimiters

---

## Tips for Claude

1. **Don't load many trees at once** - they're numerous and can fill context quickly
2. **Use grep/find** to locate relevant trees by content or title
3. **Follow transclusions** - organizational trees mainly point to other trees
4. **Check macros.tree** if you see unfamiliar commands
5. **References** are in `trees/refs/` with taxon "Reference"
6. **IDs are case-sensitive** - efr-0001 ≠ efr-0001