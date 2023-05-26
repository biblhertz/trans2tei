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
            <xsl:value-of select="replace($previousFacs, '^(#facs_\d+_).*', '$1')"/>
        </xsl:variable>
        <xsl:variable name="fnindex">
            <xsl:value-of select="normalize-space(.)"/>
        </xsl:variable>
        <xsl:for-each select="//tei:note[@place='foot'][./tei:hi[@rendition='#sup']/string() = $fnindex]">
        <!--<xsl:for-each select="//tei:note[@place='foot'][starts-with(@facs, $pagePrefix)][./tei:hi[@rendition='sup']/string() = $fnindex]">-->
            <note>
                <xsl:attribute name="n">
                    <xsl:value-of select="tei:hi[@rendition='#sup'][1]"/>
                </xsl:attribute>
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="substring-after($pagePrefix, '#')"/>
                    <xsl:text>note_</xsl:text>
                    <xsl:value-of select="tei:hi[@rendition='#sup'][1]"/>
                </xsl:attribute>
                <xsl:apply-templates select="@* except (@n, @xml:id)"/>
                <xsl:apply-templates select="node()"/>
            </note>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="tei:note[@place='foot']"/>

    <xsl:template match="tei:note[@place='foot']/tei:hi[@rendition='#sup']"/>

    <xsl:template match="@* | node()">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
