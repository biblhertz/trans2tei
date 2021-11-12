<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                exclude-result-prefixes="#all"
                version="3.0">

    <xsl:template match="tei:pb">
        <xsl:variable name="pageprefix">
            <xsl:value-of select="@facs"/>
            <xsl:text>_</xsl:text>
        </xsl:variable>
        <xsl:variable name="fwpage">
            <xsl:value-of select="//tei:fw[@type='page'][starts-with(@facs, $pageprefix)]"/>
        </xsl:variable>
        <xsl:copy>
            <xsl:attribute name="n">
                <xsl:value-of select="normalize-space($fwpage)"/>
            </xsl:attribute>
            <xsl:apply-templates select="@* except @n"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:fw[@type='page']"/>
    <xsl:template match="tei:fw[@type='header']"/>

    <xsl:template match="@* | node()">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
