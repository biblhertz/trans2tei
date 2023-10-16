<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                exclude-result-prefixes="#all"
                version="3.0">

    <xsl:template match="tei:note[@type='refnum']">
        <!-- match footnote references in text -->

        <xsl:variable name="previousFacs">
            <xsl:value-of select="preceding::tei:lb[1]/@facs"/>
        </xsl:variable>
        <xsl:variable name="pagePrefix">
            <xsl:value-of select="replace($previousFacs, '^#(facs_\d+_).*', '$1')"/>
        </xsl:variable>
        <xsl:variable name="fnindex">
            <xsl:value-of select="normalize-space(.)"/>
        </xsl:variable>

        <!-- find footnote with corresponding indicator on the same page -->
        <xsl:for-each select="//tei:note[@place='foot'][contains(@facs, $pagePrefix)][./tei:hi[@rendition='#sup']/string() = $fnindex]">

            <!-- facs identifier of the next footnote, used as limitation for footnote fragments -->
            <xsl:variable name="nextNoteFacs">
                <xsl:value-of select="following::tei:note[@place='foot'][@n='[footnote reference]'][1]/@facs"/>
            </xsl:variable>

            <note>
                <xsl:attribute name="n">
                    <xsl:value-of select="tei:hi[@rendition='#sup'][1]"/>
                </xsl:attribute>
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="$pagePrefix"/>
                    <xsl:text>note_</xsl:text>
                    <xsl:value-of select="tei:hi[@rendition='#sup'][1]"/>
                </xsl:attribute>
                <xsl:apply-templates select="@* except (@n, @xml:id)"/>
                <xsl:apply-templates/>

                <xsl:choose>
                    <xsl:when test="$nextNoteFacs">
                        <!-- if there are footnote fragments between this footnote and the next one then copy them here -->
                        <xsl:for-each select="following::tei:note[@place='foot'][@n='[footnote-continued reference]'][following::tei:note/@facs=$nextNoteFacs]">
                            <!-- milestone for manually postprocessing the reason of the split regions -->
                            <milestone unit="page|column|paragraph"/>
                            <xsl:apply-templates/>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- if last footnote is continued then copy all following fragments here -->
                        <xsl:for-each select="following::tei:note[@place='foot'][@n='[footnote-continued reference]']">
                            <milestone unit="page|column|paragraph"/>
                            <xsl:apply-templates/>
                        </xsl:for-each>
                    </xsl:otherwise>
                </xsl:choose>
            </note>
        </xsl:for-each>
    </xsl:template>

    <!-- delete the footnote in the original place -->
    <xsl:template match="tei:note[@place='foot']"/>

    <!-- delete the footnote indicator from the footnote text -->
    <xsl:template match="tei:note[@place='foot']/tei:hi[@rendition='#sup']"/>

    <xsl:template match="@* | node()">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
