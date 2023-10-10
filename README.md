# trans2tei

Workflow for creating structured tei documents from Transkribus layout+text recognition

This project is based on [page2tei](https://github.com/dariok/page2tei) bei Dario Kampkaspar and extended with several waves of
string replacements and XSLT transformations.

## Structure of this project

- `exports/`: Exports from Transkribus in the PAGE format  
  To process individual parts (as groups of pages), the `mets.xml` file can be duplicated and reduced
  to the relevant pages.
- `guidelines/`: Documentation for the TEI format of certain phenomenons
- `language_data/`: Plain wordlists in a number of languages. To enable more languages, add lists here and
  adapt `replace_hyphens(xml_data, language="any")` in `replacements.py`
- `out/`: Default output folder
- `page2tei/`: Project code from dariok/page2tei by Dario Kampkaspar
- `xsd/`: Validation for the documents in REMS
- `xslt/`: Stylesheets
  - `bibliography.xsl`: Turn list entries into bibliography entries and mark monograph titles
  - `checkpara.xsl`: Testing: Check for paragraph types in unexpected context
  - `collect-blocks.xsl`: Apply standardized blocks for REMS documents
  - `disconnect-style-and-type.xsl`: Merge tags that just differ by layout but keep layout information (REMS documents)
  - `expand-hi.xsl`: Use `hi` and types instead of different elements for markup
  - `id-to-div.xsl`: Add ID to REMS documents
  - `indent.xsl`: Pretty print
  - `join-paragraphs.xsl`: Join paragraphs across page breaks
  - `move-footnotes.xsl`: Move footnotes from page end to the footnote mark
  - `page-numbers.xsl`: Set page number as attribute in page breaks
  - `postprocess-page2tei.xsl`: Processing of additional styles in the same way as page2tei
  - `remove-position-data.xsl`: Remove the element `facsimile` from the xml
  - `simplify-hi.xsl`: Turn `hi` into elements without attributes to join the across line breaks
  - `string-pack.xsl`: See page2tei
  - `woelfflin-elements.xsl`: Replacement of TEI elements to match the flavour of the project
- `bibliography.py`: Cascade of operations for the bibliography in REMS
- `documents.py`: Cascade of operations for the main parts in REMS
- `gedanken.py`: Cascade of operations for Heinrich Wölfflins «Gedanken zur Kunstgeschichte» (1941)
- `introduction.py`: Cascade of operations for the introduction of REMS, and any text without special markup
- `replacements.py`: Replacements using regular expressions as catalog of functions
- `transform.py`: XSLT transformations as catalog of functions
- `workflow.md`: Step by step description of the workflows

## Setup

- Copy `saxon-he-10.5.jar` into the root of this repository
- Make sure, the following folders exist in the project root: `exports`, `out`, `temp`

## Usage

- Extract your export from Transkribus to `exports`
- Chose among the suggested cascades or add your own. `introduction.py` is the most generic one
- Run it like:

```bash
python3 introduction.py -i exports/your_export/mets.xml -o out/your_output.xml
```
