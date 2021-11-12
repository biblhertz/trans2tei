import re


def replace_hyphens(xml_data):

    # Use normal hyphen before capitals and numbers
    return re.sub(r'¬(\s*)(<pb[^<>]/>)?(<lb[^<>]/>)([A-Z0-9])',
                  r'-\1\2\3\4',
                  xml_data)

    return xml_data


def unite_doc_nubmer_and_title(xml_data):
    """
    Per unire numero di documento e titolo
    :param xml_data:
    :return:
    """

    # group 1: attribute @facs from document number
    # group 2: document number from document title
    # group 3: attribute @facs from head
    # group 4: date from document title
    replacement = r'</div>\n<div>\n<head \1 name="\2">\2\n<lb \3 /><hi rendition="#g">\4</hi></head>'

    # without lb
    pattern = r'<p (facs="#facs_.*?") type="document_number"> (.*?)</p>\s*</div>\s*<div>\s*<head (facs.*?")>(.*?)</head>'
    xml_data = re.sub(pattern, replacement, xml_data)

    # with lb
    pattern = r'<p (facs="#facs_.*?") type="document_number">\s*<lb.*?/>(.*?)</p>\s*</div>\s*<div>\s*<head (facs.*?")>\s*<lb.*?/>(.*?)</head>'
    xml_data = re.sub(pattern, replacement, xml_data)

    return xml_data


def cursive_text(xml_data):
    return re.sub(r'⌠(.*?)⌡',
                  r'<hi rendition="#i">\1</hi>',
                  xml_data)


def footnote_numbers(xml_data):
    """
    cerca numero nota nella riga
    TODO cercare come aggiungere anche la pagina!
    :param xml_data:
    :return:
    """
    return re.sub(r'⊂([0-9]+)⊃',
                  r'<note type="refnum">\1</note>',
                  xml_data)


def footnotes(xml_data):
    """
    note a pié di pagina
    TODO ci sono apici senza text-region corretto?
    :param xml_data:
    :return:
    """

    xml_data = re.sub(r'⊤([0-9]+)⊥',
                      r'<hi rendition="sup">\1</hi>',
                      xml_data)

    return xml_data


def small_caps(xml_data):
    """
    Maiuscoletti
    cerca (maiuscole/minuscole, non mantieni casi)
    
    :param xml_data: 
    :return: 
    """""

    return re.sub(r'₍([A-Z\-]+)₎', lambda m: '<hi rendition="#k">' + m.group(1).lower() + '</hi>', xml_data)


def first_paragraph(xml_data):
    """
    First-paragraph

    :param xml_data:
    :return:
    """
    return re.sub(r'type="first-paragraph"', r'type="first" rendition="#aq"', xml_data)


def document_links(xml_data):
    """
    Note di riferimenti a documenti
    :param xml_data:
    :return:
    """
    # a =  re.sub(r'\[↾([F0-9/\-]+)⇃\]', r'[<ref target="#\1">\1</ref>]', xml_data)
    return re.sub(r'\[↾([F0-9/\-]+)⇃\]',
                  lambda m: '[<ref target="#doc_' + re.sub(r'/', '_', m.group(1)) + '">' + m.group(1) + '</ref>]',
                  xml_data)


def move_pb_into_div1(xml_data):
    """
    Spostare l'inizio pagina prima dei capitoli
    :param xml_data:
    :return:
    """

    # group 1: complete pb element
    # group 2: page number
    # group 3: spaces
    # group 4: closing element of div before and opening of new one
    return re.sub(r'(<pb facs="#facs_([0-9]+)".*? />\n)(\s+)(</div>\n\s+<div>\n)', r'\4\3\1', xml_data)


def move_pb_into_div2(xml_data):
    """
    Spostare prima dei documenti inizio pagina se iniziano
    :param xml_data:
    :return:
    """
    return re.sub(r'(<pb facs="#facs_[0-9]+".*? />\s*<fw.*?>\s*.*?</fw>\s*)(</div>\s*<div>\s*)', r'\2\1', xml_data)


def unite_footnotes(xml_data):
    """
    Uniamo le footnotes continued!!!
    Trovare le intestazioni ed inserire anche un xml:id

    :param xml_data:
    :return:
    """

    return re.sub(r'(<head facs="#(.*?)" name=.*?)>', r'\1 xml:id="\2">', xml_data)


def tabs(xml_data):
    """

    :param xml_data:
    :return:
    """
    return xml_data