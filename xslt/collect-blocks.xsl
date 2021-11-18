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

    <xsl:template match="tei:div">
        <div>
            <!-- head and form work -->
            <xsl:apply-templates select="tei:fw[not(preceding-sibling::tei:p)] | tei:pb[not(preceding-sibling::tei:p)] | tei:head[not(preceding-sibling::tei:p)]"/>

            <!-- abstract -->
            <argument>
                <xsl:apply-templates select="tei:p[@type='abstract']"/>
            </argument>

            <!-- body -->
            <floatingText>
                <xsl:apply-templates select="tei:p[not(@type)] | tei:p[@type='paragraph'] | tei:p[@type='first'] | tei:p[@type='paragraph-first'] | tei:p[@type='paragraph-noindent'] | tei:p[@type='paragraph-center'] | tei:p[@type='paragraph-right']"/>
            </floatingText>

            <!-- archival notice -->
            <msDesc>
                <xsl:apply-templates select="tei:p[@type='archival-notice']"/>
            </msDesc>

            <!-- commentary -->
            <note type="commentary">
                <xsl:apply-templates select="tei:p[@type='commentary'] | tei:p[@type='commentary-first'] | tei:p[@type='commentary-noindent']"/>
            </note>

            <!-- bibliography -->
            <bibl>
                <xsl:apply-templates select="tei:p[@type='bibliography']"/>
            </bibl>


        </div>
    </xsl:template>


    <!-- Default: keep as it is -->

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>


</xsl:stylesheet>
