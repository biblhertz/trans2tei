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
        <xsl:copy>
            <!-- keep attributes -->
            <xsl:apply-templates select="@*"/>

            <xsl:for-each-group select="*" group-adjacent="name()">
                <xsl:choose>
                    <xsl:when test="name()='pAbstract'">
                        <argument>
                            <xsl:for-each select="current-group()">
                                <xsl:apply-templates select="."/>
                            </xsl:for-each>
                        </argument>
                    </xsl:when>
                    <xsl:when test="name()='pOrig'">
                        <quote type="original">
                            <xsl:for-each select="current-group()">
                                <xsl:apply-templates select="."/>
                            </xsl:for-each>
                        </quote>
                    </xsl:when>
                    <xsl:when test="name()='pArchival'">
                        <msDesc>
                            <xsl:for-each select="current-group()">
                                <xsl:apply-templates select="."/>
                            </xsl:for-each>
                        </msDesc>
                    </xsl:when>
                    <xsl:when test="name()='pCommentary'">
                        <note type="commentary">
                            <xsl:for-each select="current-group()">
                                <xsl:apply-templates select="."/>
                            </xsl:for-each>
                        </note>
                    </xsl:when>
                    <xsl:when test="name()='pBibl'">
                        <xsl:for-each select="current-group()">
                            <xsl:apply-templates select="."/>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="current-group()">
                            <xsl:apply-templates select="."/>
                        </xsl:for-each>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each-group>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:pAbstract">
        <p>
            <xsl:apply-templates select="@* | node()"/>
        </p>
    </xsl:template>

    <xsl:template match="tei:pOrig">
        <p>
            <xsl:apply-templates select="@* | node()"/>
        </p>
    </xsl:template>

    <xsl:template match="tei:pArchival">
        <p>
            <xsl:apply-templates select="@* | node()"/>
        </p>
    </xsl:template>

    <xsl:template match="tei:pCommentary">
        <p>
            <xsl:apply-templates select="@* | node()"/>
        </p>
    </xsl:template>

    <xsl:template match="tei:pBibl">
        <bibl>
            <xsl:apply-templates select="@* | node()"/>
        </bibl>
    </xsl:template>

    <!-- Default: keep as it is -->

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>


</xsl:stylesheet>
