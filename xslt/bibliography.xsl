<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                exclude-result-prefixes="#all"
                version="3.0">

    <xsl:template match="tei:p[@type='bibref']">
        <bibl facs="{@facs}">
            <xsl:apply-templates/>
        </bibl>
    </xsl:template>

    <xsl:template match="tei:hi[@rendition='#i']">
        <title level="m" rendition="#i">
            <xsl:apply-templates/>
        </title>
    </xsl:template>

    <xsl:template match="@* | node()">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
