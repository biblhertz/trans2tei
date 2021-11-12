<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                exclude-result-prefixes="#all"
                version="3.0">

    <xsl:template match="tei:note[@type='refnum']">
        <xsl:variable name="previousFacs">
            <xsl:value-of select="preceding::tei:lb[1]/@facs"/>
        </xsl:variable>
        <xsl:variable name="pagePrefix">
            <xsl:value-of select="substring-before($previousFacs, 'tl_')"/>
        </xsl:variable>
        <xsl:variable name="fnindex">
            <xsl:value-of select="normalize-space(.)"/>
        </xsl:variable>
        <xsl:for-each select="//tei:note[@place='foot'][starts-with(@facs, $pagePrefix)][tei:hi[@rendition='sup']/string() = $fnindex]">
            <xsl:copy-of select="."/>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="tei:note[@place='foot']"/>

    <xsl:template match="@* | node()">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
