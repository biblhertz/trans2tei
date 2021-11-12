<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns="http://www.tei-c.org/ns/1.0"
                exclude-result-prefixes="#all">
    <xsl:output method="xml" encoding="UTF-8"/>

    <xsl:template match="/">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:div">
        <div>
            <xsl:apply-templates select="tei:fw[not(preceding-sibling::tei:p)] | tei:pb[not(preceding-sibling::tei:p)] | tei:head[not(preceding-sibling::tei:p)]"/>
            <xsl:for-each-group
                    select="./node()"
                    group-starting-with="tei:p[not(contains(@type, 'continued'))]">
                <xsl:copy> <!-- tag of the group -->
                    <xsl:attribute name="type">
                        <xsl:call-template name="paragraphType"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="@* except @type"/>
                    <xsl:apply-templates select="node()"/>
                    <xsl:apply-templates select="current-group() except ."/>
                </xsl:copy>
            </xsl:for-each-group>
        </div>
    </xsl:template>

    <xsl:template match="tei:p[contains(@type, 'continued')]">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template name="paragraphType">
        <xsl:choose>
            <xsl:when test="@type = 'abstract-truncated'">abstract</xsl:when>
            <xsl:when test="@type = 'bibliography-truncated'">bibliography</xsl:when>
            <xsl:when test="@type = 'commentary-truncated'">commentary</xsl:when>
            <xsl:when test="@type = 'commentary-first-truncated'">commentary-first</xsl:when>
            <xsl:when test="@type = 'commentary-noindent-truncated'">commentary-noindent</xsl:when>
            <xsl:when test="@type = 'noindent-truncated'">noindent</xsl:when>
            <xsl:when test="@type = 'paragraph-truncated'">paragraph</xsl:when>
            <xsl:when test="@type = 'paragraph-first-truncated'">first</xsl:when>
            <xsl:when test="@type = 'paragraph-noindent-truncated'">paragraph-noindent</xsl:when>
            <xsl:when test="not(@type)">paragraph</xsl:when>
            <xsl:otherwise><xsl:value-of select="@type"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <!-- Default: keep as it is -->

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>


</xsl:stylesheet>
