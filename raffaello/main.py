import sys
import argparse
import replacements
import transform




if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument('--input', '-i', dest="infile_name", help='Path to mets.xml for input', default="export_job_2216309/437109/Raphael_in_Early_Modern_Sources,_1483-1602_v__1/mets.xml")
    parser.add_argument('--output', '-o', dest="outfile_name", help='Path to output file', default="no-outfile-specified.xml")

    args = parser.parse_args()

    print(args.infile_name)

    # Transformation to TEI. This should already join footnotes from different pages.
    xml_data = transform.page2tei(args.infile_name)
    print(xml_data, file=open("temp/tei.xml", 'w'))
    # FIXME: circumwent an error. delete when solved
    with open("temp/tei-fix.xml", "r") as f: xml_data = f.read(); f.close()

    # After grouping by headings, the document number is at the end of the previous paragraph which we do not want.
    # Move it into the `head` elements:
    xml_data = replacements.unite_doc_nubmer_and_title(xml_data)
    print(xml_data, file=open("temp/num.xml", 'w'))

    xml_data = transform.id_to_div(xml_data)
    print(xml_data, file=open("temp/docid.xml", 'w'))

    # Text in italics is tagged in plain text with integrals. Replace with according tags.
    xml_data = replacements.cursive_text(xml_data)
    print(xml_data, file=open("temp/cur.xml", 'w'))

    xml_data = replacements.footnote_numbers(xml_data)
    print(xml_data, file=open("temp/fn1.xml", 'w'))

    xml_data = replacements.footnotes(xml_data)
    print(xml_data, file=open("temp/fn2.xml", 'w'))

    xml_data = transform.move_footnotes(xml_data)
    print(xml_data, file=open("temp/fn3.xml", 'w'))

    xml_data = replacements.small_caps(xml_data)
    print(xml_data, file=open("temp/scap.xml", 'w'))

    xml_data = replacements.first_paragraph(xml_data)
    print(xml_data, file=open("temp/para.xml", 'w'))

    xml_data = replacements.document_links(xml_data)
    print(xml_data, file=open("temp/link.xml", 'w'))

    xml_data = replacements.move_pb_into_div1(xml_data)
    print(xml_data, file=open("temp/pb1.xml", 'w'))

    xml_data = replacements.move_pb_into_div2(xml_data)
    print(xml_data, file=open("temp/pb2.xml", 'w'))

    xml_data = transform.page_numbers(xml_data)
    print(xml_data, file=open("temp/pb3.xml", 'w'))

    # xml_data = replacements.unite_footnotes(xml_data)
    # print(xml_data, file=open("temp/fn2.xml", 'w'))

    xml_data = replacements.tabs(xml_data)
    print(xml_data, file=open("temp/tab.xml", 'w'))

    xml_data = replacements.replace_hyphens(xml_data)
    print(xml_data, file=open("temp/hyph.xml", 'w'))

    print(xml_data, file=open("temp/rep1.xml", "w"))
    xml_data = transform.join_paragraphs(xml_data)
    print(xml_data, file=open("temp/rep2.xml", "w"))
    xml_data = transform.collect_blocks(xml_data)

    # TODO tabs

    with open(args.outfile_name, "w") as outfile:
        outfile.write(xml_data)
    outfile.close()
