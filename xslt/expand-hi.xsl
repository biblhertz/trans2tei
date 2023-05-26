<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                exclude-result-prefixes="#all"
                version="3.0">

    <xsl:template match="tei:i">
        <hi rendition="#i">
            <xsl:apply-templates/>
        </hi>
    </xsl:template>

    <xsl:template match="tei:k">
        <hi rendition="#k">
            <xsl:apply-templates/>
        </hi>
    </xsl:template>

    <xsl:template match="@* | node()">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>