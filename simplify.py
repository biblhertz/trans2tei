import sys
import argparse
import replacements
import transform

"""
All-in-one replacements for patterns and XML for simple TEI to be converted to Word files
"""


if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument('--input', '-i', dest="infile_name", help='Path to mets.xml for input', default="export_job_2216309/437109/Raphael_in_Early_Modern_Sources,_1483-1602_v__1/mets.xml")
    parser.add_argument('--output', '-o', dest="outfile_name", help='Path to output file', default="out/no-outfile-specified.xml")

    args = parser.parse_args()

    print(args.infile_name)

    # Transformation to TEI. This should already join footnotes from different pages.
    xml_data = transform.page2tei(args.infile_name)
    print(xml_data, file=open("temp/tei.xml", 'w'))

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

    xml_data = replacements.bold_text(xml_data)
    print(xml_data, file=open("temp/bold.xml", 'w'))

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

    xml_data = transform.join_paragraphs(xml_data)
    print(xml_data, file=open("temp/rep1.xml", "w"))

    # join hi #i and #k
    xml_data = transform.simplify_hi(xml_data)
    print(xml_data, file=open("temp/hi1.xml", "w"))

    xml_data = replacements.join_small_caps(xml_data)
    xml_data = replacements.join_cursive_text(xml_data)
    print(xml_data, file=open("temp/hi2.xml", "w"))

    xml_data = transform.expand_hi(xml_data)
    print(xml_data, file=open("temp/hi.xml", "w"))

    xml_data = replacements.replace_hyphens(xml_data)
    print(xml_data, file=open("temp/hyph.xml", 'w'))

    # TODO tabs
    xml_data = transform.remove_lb(xml_data)
    print(xml_data, file=open("temp/removed-lb.xml", 'w'))

    xml_data = transform.remove_pb(xml_data)
    print(xml_data, file=open("temp/removed-pb.xml", 'w'))

    xml_data = transform.indent(xml_data)
    print(xml_data, file=open("temp/ind.xml", 'w'))

    with open(args.outfile_name, "w") as outfile:
        outfile.write(xml_data)
    outfile.close()
