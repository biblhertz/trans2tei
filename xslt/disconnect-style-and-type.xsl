<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns="http://www.tei-c.org/ns/1.0"
                exclude-result-prefixes="#all">
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:p[@type='abstract']">
        <pAbstract>
            <xsl:apply-templates select="@facs"/>
            <xsl:apply-templates/>
        </pAbstract>
    </xsl:template>

    <xsl:template match="tei:p[not(@type)]">
        <pOrig>
            <xsl:apply-templates select="@facs"/>
            <xsl:apply-templates/>
        </pOrig>
    </xsl:template>

    <xsl:template match="tei:p[@type='paragraph']">
        <pOrig>
            <xsl:apply-templates select="@facs"/>
            <xsl:apply-templates/>
        </pOrig>
    </xsl:template>

    <xsl:template match="tei:p[@type='first']">
        <pOrig rend="noindent">
            <xsl:apply-templates select="@facs"/>
            <xsl:apply-templates/>
        </pOrig>
    </xsl:template>

    <xsl:template match="tei:p[@type='paragraph-first']">
        <pOrig rend="noindent">
            <xsl:apply-templates select="@facs"/>
            <xsl:apply-templates/>
        </pOrig>
    </xsl:template>

    <xsl:template match="tei:p[@type='paragraph-noindent']">
        <pOrig rend="noindent">
            <xsl:apply-templates select="@facs"/>
            <xsl:apply-templates/>
        </pOrig>
    </xsl:template>

    <xsl:template match="tei:p[@type='paragraph-center']">
        <pOrig rend="center">
            <xsl:apply-templates select="@facs"/>
            <xsl:apply-templates/>
        </pOrig>
    </xsl:template>

    <xsl:template match="tei:p[@type='paragraph-right']">
        <pOrig rend="right">
            <xsl:apply-templates select="@facs"/>
            <xsl:apply-templates/>
        </pOrig>
    </xsl:template>

    <xsl:template match="tei:p[@type='poetry']">
        <pOrig type="poetry">
            <xsl:apply-templates select="@facs"/>
            <xsl:apply-templates/>
        </pOrig>
    </xsl:template>

    <xsl:template match="tei:p[@type='archival-notice']">
        <pArchival rend="noindent">
            <xsl:apply-templates select="@facs"/>
            <xsl:apply-templates/>
        </pArchival>
    </xsl:template>

    <xsl:template match="tei:p[@type='commentary']">
        <pCommentary>
            <xsl:apply-templates select="@facs"/>
            <xsl:apply-templates/>
        </pCommentary>
    </xsl:template>

    <xsl:template match="tei:p[@type='commentary-first']">
        <pCommentary rend="noindent">
            <xsl:apply-templates select="@facs"/>
            <xsl:apply-templates/>
        </pCommentary>
    </xsl:template>

    <xsl:template match="tei:p[@type='commentary-noindent']">
        <pCommentary rend="noindent">
            <xsl:apply-templates select="@facs"/>
            <xsl:apply-templates/>
        </pCommentary>
    </xsl:template>

    <xsl:template match="tei:p[@type='bibliography']">
        <pBibl>
            <xsl:apply-templates select="@facs"/>
            <xsl:apply-templates/>
        </pBibl>
    </xsl:template>

    <!-- Default: keep as it is -->

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>


</xsl:stylesheet>
