<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all"
    version="3.0">


    <xsl:template match="tei:fileDesc">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" />
            <tagsDecl>
                <rendition scheme="css" xml:id="aq">font-family:sans-serif</rendition>
                <rendition scheme="css" xml:id="b">font-weight:bold</rendition>
                <rendition scheme="css" xml:id="blue">color:blue</rendition>
                <rendition scheme="css" xml:id="c">display:block; text-align:center</rendition>
                <rendition scheme="css" xml:id="indent">display:block; text-indent:2em</rendition>
                <rendition scheme="css" xml:id="et">display:block; margin-left:2em;
                    text-indent:0</rendition>
                <rendition scheme="css" xml:id="et2">display:block; margin-left:4em;
                    text-indent:0</rendition>
                <rendition scheme="css" xml:id="et3">display:block; margin-left:6em;
                    text-indent:0</rendition>
                <rendition scheme="css" xml:id="f">border:1px dotted silver</rendition>
                <rendition scheme="css" xml:id="fr">border:1px dotted silver</rendition>
                <rendition scheme="css" xml:id="g">letter-spacing:0.125em</rendition>
                <rendition scheme="css" xml:id="i">font-style:italic</rendition>
                <rendition scheme="css" xml:id="in">font-size:150%</rendition>
                <rendition scheme="css" xml:id="k">font-variant:small-caps; font-style:normal
    !important</rendition>
                <rendition scheme="css" xml:id="larger">font-size:larger</rendition>
                <rendition scheme="css" xml:id="red">color:red</rendition>
                <rendition scheme="css" xml:id="right">display:block; text-align:right</rendition>
                <rendition scheme="css" xml:id="s">text-decoration:line-through</rendition>
                <rendition scheme="css" xml:id="smaller">font-size:smaller</rendition>
                <rendition scheme="css" xml:id="sub">vertical-align:sub; font-size:.7em</rendition>
                <rendition scheme="css" xml:id="sup">vertical-align:super;
                    font-size:.7em</rendition>
                <rendition scheme="css" xml:id="u">text-decoration:underline</rendition>
                <rendition scheme="css" xml:id="uu">border-bottom:double 3px #000</rendition>
            </tagsDecl>
        </xsl:copy>
    </xsl:template>

    <xsl:template
        match="tei:ab[@type][@facs]">

        <xsl:choose>
            <xsl:when
                test="@type = ('quote')">
                <quote facs="{@facs}">
                    <xsl:apply-templates />
                </quote>
            </xsl:when>
            <xsl:when
                test="@type = ('commentary')">
                <p facs="{@facs}" type="commentary" rendition="#indent">
                    <xsl:apply-templates />
                </p>
            </xsl:when>
            <xsl:when
                test="@type = ('first-paragraph')">
                <p facs="{@facs}" type="first" rendition="#aq">
                    <xsl:apply-templates />
                </p>
            </xsl:when>
            <xsl:when
                test="@type = ('paragraph-center')">
                <p facs="{@facs}" type="center" rendition="#c">
                    <xsl:apply-templates />
                </p>
            </xsl:when>
            <xsl:when
                test="@type = ('bibliography', 'archival-notice')">
                <p facs="{@facs}" type="{@type}"
                    rendition="#smaller">
                    <xsl:apply-templates />
                </p>
            </xsl:when>
            <xsl:when
                test="@type = ('other', 'paragraph')">
                <p facs="{@facs}" rendition="#aq #indent">
                    <xsl:apply-templates />
                </p>
            </xsl:when>
            <!-- the fallback option should be a semantically open element such as <ab> -->
            <xsl:otherwise>
                <p facs="{@facs}" type="{@type}">
                    <xsl:apply-templates />
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template
        match="tei:fw[@type='page-number'][@facs]">
        <fw type="page" place="bottom" facs="{@facs}">
            <xsl:apply-templates />
        </fw>
    </xsl:template>

    <xsl:template
        match=" @* | node()">
        <xsl:copy>
            <xsl:apply-templates select=" @* | node()" />
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>