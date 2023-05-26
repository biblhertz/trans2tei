# Document workflow
## Document preparation
### Prerequisites
In order to extract text and structure from a printed book you need a digitized scan of the pages of the book, possibly with 300dpi+ resolution and little to no compression. 
Transkribus server prefer jpg to hires tiff: same computation-wise quality with less filesize. If you have tiff, convert them to jpg with no change in dimensions and 9-10 (90%-100%) quality (i.e. little compression).
### Visual analysis
In order to decode the structure it could be lovely to have some kind of standard references for book page structures. @liladude should create some basic structure standards for P2PLa.
### Creating the project on Transkribus
Create a new document in Transkribus by uploading the images and filing the needed metadata.
## Document processing
1. Run a printed block detection on text pages
  - paragraphs are detected and inserted in separated regions
  - paragraphs are not in separated regions 
    - manually create the paragraph regions
    - train a model with the new layout @me check with team if this is possible
2. Run line detection
3. Recognize text (some pages) in order get some basic text for creating the new training
### Text and character styles 
- normal text
- italics
- bold
- superscript
- superscript for footnote reference
- superscript as footnote number
- underlined
- gesperrt (expanded)
- antiqua in Fraktur
- small caps
### Paragraph styles
- body text -> paragraph
- running header
- headings (levels?)
- page number
- quote
- footnote
- abstract
- centered text
- poetry
- commentary
- continued elements
4. Manually correct a set of pages (minumun to be set, depends on complexity of document)
## Document export and conversion
- Export document as Transkribus page (save it locally)
- Process it with a transformation cascade from this project, taking care of
  - Transformation with Page2Tei
  - Substitute tag symbols in text with corresponding xml tags
  - Fix notes, page numbers etc. (xslt)
### Publish final document
- create final tei document for teipublisher (manual fixes, re-combination of parts, etc.)
- export to word docx for editorial/commmentary workflow
- word processing for tei export -> see Reto
END
