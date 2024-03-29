import re


def replace_hyphens(xml_data, language="any"):

    # Use normal hyphen before capitals and numbers
    xml_data = re.sub(r'¬(\s*)(<pb[^<>]/>)?<lb ([^<>]/>)([A-Z0-9])',
                  r'-\1\2<lb break="no" rend="nohyphen" \3\4',
                  xml_data)

    # Words with hyphens from a whitelist
    with open("language_data/hyphen-words.txt", "r") as f:
        words = f.read().splitlines()
    f.close()

    to_replace = []
    # Collect hyphened words
    # hyphened = re.findall(r"\w+¬\s*<lb [^<>]+>\w+", xml_data)
    hyphened = re.findall(r"\w+¬\s*(?:<pb [^<>]+>)?\s*<lb [^<>]+>\w+", xml_data)
    if hyphened:
        for h in hyphened:
            if "<pb" in hyphened:
                # Hyphens over pagebreaks
                simplified = re.sub(r"¬\s*(<pb [^<>]+>)\s*<lb [^<>]+>", "-", h)
                if simplified in words or simplified.lower() in words:
                    replacement = re.sub(r"¬\s*<pb ([^<>]+>)\s*<lb ([^<>]+)>",
                                         r'-<pb break="no" rend="nohyphen" \1><lb break="no" rend="nohyphen" \2>', h)
                    to_replace.append((h, replacement))
            else:
                # Hyphens over lines
                simplified = re.sub(r"¬\s*<lb [^<>]+>", "-", h)
                if simplified in words or simplified.lower() in words:
                    replacement = re.sub(r"¬\s*<lb ([^<>]+)>", r'-<lb break="no" rend="nohyphen" \1>', h)
                    to_replace.append((h, replacement))
    # Replace with normal hyphens
    for hyphen, replacement in to_replace:
        xml_data = xml_data.replace(hyphen, replacement)

    # Collect words
    if language == "de":
        with open("language_data/de.txt", "r") as f:
            words = f.read().splitlines()
        f.close()
    elif language == "en":
        with open("language_data/en.txt", "r") as f:
            words = f.read().splitlines()
        f.close()
    else:
        with open("language_data/de.txt", "r") as f:
            words = f.read().splitlines()
        f.close()
        with open("language_data/en.txt", "r") as f:
            words = f.read().splitlines() + words
        f.close()

    to_replace = []
    # Collect hyphened words
    # hyphened = re.findall(r"\w+¬\s*<lb [^<>]+>\w+", xml_data)
    hyphened = re.findall(r"\w+¬\s*(?:<pb [^<>]+>)?\s*<lb [^<>]+>\w+", xml_data)
    if hyphened:
        for h in hyphened:
            if "<pb" in hyphened:
                # Hyphens over pagebreaks
                unhyphened = re.sub(r"¬\s*(<pb [^<>]+>)\s*<lb [^<>]+>", "", h)
                if unhyphened in words or unhyphened.lower() in words:
                    replacement = re.sub(r"¬\s*<pb ([^<>]+>)\s*<lb ([^<>]+)>", r'<pb break="no" rend="hyphen" \1><lb break="no" rend="nohyphen" \2>', h)
                    to_replace.append((h, replacement))
            else:
                # Hypens over lines
                unhyphened = re.sub(r"¬\s*<lb [^<>]+>", "", h)
                if unhyphened in words or unhyphened.lower() in words:
                    replacement = re.sub(r"¬\s*<lb ([^<>]+)>", r'<lb break="no" rend="hyphen" \1>', h)
                    to_replace.append((h, replacement))
    # Replace hyphens
    for hyphen, replacement in to_replace:
        xml_data = xml_data.replace(hyphen, replacement)

    # wider¬
    #       <lb facs="#facs_10_r1l7" n="N006"/>sprechend
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
    replacement = r'</div>\n<div>\n<head \1 name="\2"><num>\2</num>\n<lb \3 /><hi rendition="#g">\4</hi></head>'

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


def join_cursive_text(xml_data):
    """
    Join i elements (replacements for hi[@rendition='#i'] that are interrupted by milestone breaks
    """
    return re.sub(r'</i>(¬?\s*(?:<pb [^<>]+/>)?\s*<lb [^<>]+/>\s*)<i>', r'\1', xml_data)


def bold_text(xml_data):
    return re.sub(r'↾([^<>]?)⇃',
                  r'<hi rendition="#b">\1</hi>',
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
                      r'<hi rendition="#sup">\1</hi>',
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


def join_small_caps(xml_data):
    """
    Join k elements (replacements for hi[@rendition='#k'] that are interrupted by milestone breaks
    """
    return re.sub(r'</k>(¬?\s*(?:<pb [^<>]+/>)?\s*<lb [^<>]+/>\s*)<k>', r'\1', xml_data)


def supplied(xml_data):
    """
    Supplied text marked up as italics between square brackets

    :param xml_data:
    :return:
    """
    return re.sub(r'\[⌠(.*?)⌡]',
                  r'<supplied>\1</supplied>',
                  xml_data)


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


def bibl_label(xml_data):
    """
    Encase the label for bibliographic entries

    :param xml_data:
    :return:
    """

    return re.sub(r'(<bibl [^<>]*>\s*<lb [^<>]*/>)((?:<lb [^<>]*/>|<pb [^<>]*/>|[^()<>:])+ \((?:<lb [^<>]*/>|<pb [^<>]*/>|[^()<>:])+\)):', r'\1<title type="short">\2</title>:', xml_data)


def bibl_author(xml_data):
    """
    Encase the label for bibliographic entries

    :param xml_data:
    :return:
    """
    xml_data = re.sub(r'(</title[^<>]*>:)' +  # end of short title
                      r'((?:<lb [^<>]*/>|<pb [^<>]*/>|\s)*)' +  # spaces
                      r'(\w(?:<lb [^<>]*/>|<pb [^<>]*/>|[^<>,:])+\w)' +  # name
                      r'((?:<lb [^<>]*/>|<pb [^<>]*/>|\s)+and(?:<lb [^<>]*/>|<pb [^<>]*/>|\s)+)'  # space, 'and', space
                      r'(\w(?:<lb [^<>]*/>|<pb [^<>]*/>|[^<>,:])+\w),' +  # name
                      r'((?:<lb [^<>]*/>|<pb [^<>]*/>|\s)*)' +  # spaces
                      r'(<title|‘)',  # start of monography title or article title
                      r'\1\2<author>\3</author>\4<author>\5</author>,\6\7', xml_data)

    xml_data = re.sub(r'(</title[^<>]*>:)' +  # end of short title
                      r'((?:<lb [^<>]*/>|<pb [^<>]*/>|\s)*)' +  # spaces
                      r'(\w(?:<lb [^<>]*/>|<pb [^<>]*/>|[^<>,:])+\w)' +   # name
                      r'((?:<lb [^<>]*/>|<pb [^<>]*/>|\s)+et(?:<lb [^<>]*/>|<pb [^<>]*/>|\s)+al\.,)'  # 'et al.' incl. spaces
                      r'((?:<lb [^<>]*/>|<pb [^<>]*/>|\s)*)' +  # spaces
                      r'(<title|‘)',  # start of monography title or article title
                      r'\1\2<author>\3</author>\4\5\6', xml_data)

    xml_data = re.sub(r'(</title[^<>]*>:)' +  # end of short title
                      r'((?:<lb [^<>]*/>|<pb [^<>]*/>|\s)*)' +  # spaces
                      r'(\w(?:<lb [^<>]*/>|<pb [^<>]*/>|[^<>,:])+\w),' +  # name
                      r'((?:<lb [^<>]*/>|<pb [^<>]*/>|\s)*)' +  # spaces
                      r'(<title|‘)',  # start of monography title or article title
                      r'\1\2<author>\3</author>,\4\5', xml_data)
    return xml_data


def bibl_pub(xml_data):
    """
    Encase the label for bibliographic entries

    :param xml_data:
    :return:
    """

    xml_data = re.sub(r'(\()' +  # opening bracket
                      r'((?:[A-Z](?:<lb [^<>]*/>|<pb [^<>]*/>|[^<>,:])+)?)' +  # place name
                      r'(,?)' +  # comma
                      r'((?:<lb [^<>]*/>|<pb [^<>]*/>|\s)*)' +  # spaces
                      r'([0-9\-]+)' +  # date
                      r'(\)[^<])',  # closing bracket that is not followed by a closing tag
                      r'\1<pubPlace>\2</pubPlace>\3\4<date>\5</date>\6', xml_data)
    xml_data = re.sub(r'<pubPlace></pubPlace>', r'', xml_data)
    return xml_data


def bibl_article(xml_data):
    """
    Encase the article name for bibliographic entries

    :param xml_data:
    :return:
    """

    xml_data = re.sub(r'</author>,' +  # opening bracket
                      r'((?:<lb [^<>]*/>|<pb [^<>]*/>|\s)*)' +  # spaces
                      r'‘' +  # opening quote
                      r'((?:[A-Z](?:<lb [^<>]*/>|<pb [^<>]*/>|[^<>,:])+)?)' +  # name
                      r'(?: ,|’,)' +  # comma
                      r'((?:<lb [^<>]*/>|<pb [^<>]*/>|\s)*)' +  # spaces
                      r'in',  # spaces
                      r'</author>,\1<title level="a" rendition="#singlequote">\2</title>,\3in', xml_data)
    return xml_data


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