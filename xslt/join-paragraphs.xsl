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

<!--    <xsl:template match="tei:div">
        <div>
            <xsl:apply-templates select="tei:fw[not(preceding-sibling::tei:p)] | tei:pb[not(preceding-sibling::tei:p)] | tei:head[not(preceding-sibling::tei:p)]"/>
            <xsl:for-each-group
                    select="./node()"
                    group-starting-with="tei:p[not(contains(@type, 'continued'))]">
                <xsl:copy> &lt;!&ndash; tag of the group &ndash;&gt;
                    <xsl:attribute name="type">
                        <xsl:call-template name="paragraphType"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="@* except @type"/>
                    <xsl:apply-templates select="node()"/>
                    <xsl:apply-templates select="current-group() except ."/>
                </xsl:copy>
            </xsl:for-each-group>
        </div>
    </xsl:template>-->

<!--    <xsl:template match="tei:div">
        <div>
            &lt;!&ndash; Keep everything before the first tei:p as it is &ndash;&gt;
            <xsl:apply-templates select="./node()[not(preceding-sibling::tei:p)] except tei:p"/>

            &lt;!&ndash; Everything from the first tei:p has to be grouped. Groups are started with tei:p.
                 tei:p with 'continued' are joined to the previous paragraph &ndash;&gt;
            &lt;!&ndash; Continued paragraphs without a paragraph to attach to are dropped with this configuration.
                 Such a problem should be fixed in earlier steps. &ndash;&gt;
            <what-is-going/>
            <xsl:for-each-group
                    select="./node()[preceding::tei:p] | tei:p"
                    group-starting-with="tei:p[not(contains(@type, 'continued'))]">
                <xsl:copy> &lt;!&ndash; tag of the group. this is the tei:p &ndash;&gt;

                    &lt;!&ndash; set attribute @type &ndash;&gt;
                    <xsl:attribute name="type">
                        <xsl:call-template name="paragraphType"/>
                    </xsl:attribute>

                    &lt;!&ndash; keep all other attributes &ndash;&gt;
                    <xsl:apply-templates select="@* except @type"/>

                    <this-my-problem/>
                    &lt;!&ndash; keep all the content (text and elements) of the starting paragraph &ndash;&gt;
                    <xsl:apply-templates select="node()"/>

                    &lt;!&ndash; apply all the following siblings of the same group &ndash;&gt;
                    <xsl:apply-templates select="current-group() except ."/>
                </xsl:copy>
            </xsl:for-each-group>
        </div>
    </xsl:template>-->

    <xsl:template match="tei:div">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:for-each-group select="*"
                    group-starting-with="tei:p[not(contains(@type, 'continued'))]">
                <xsl:apply-templates select="." mode="group"/>
            </xsl:for-each-group>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:p[not(contains(@type, 'continued'))]" mode="group">
         <xsl:copy> <!-- tag of the group. this is the tei:p -->

            <!-- set attribute @type -->
            <xsl:attribute name="type">
                <xsl:call-template name="paragraphType"/>
            </xsl:attribute>

            <!-- keep all other attributes -->
            <xsl:apply-templates select="@* except @type"/>

            <!-- keep all the content (text and elements) of the starting paragraph -->
            <xsl:apply-templates select="node()"/>

            <!-- apply all the following siblings of the same group -->
            <xsl:apply-templates select="current-group() except ."/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="*" mode="group">
        <!-- match all other groups, i.e. not starting with paragraph -->
        <xsl:apply-templates select="current-group()"/>
    </xsl:template>

    <xsl:template match="tei:p[contains(@type, 'continued')]">
        <!-- Omit the surrounding element for continued paragraphs. This way they appear directly in their group.
             To be checked: Does this rule unwrap any paragraphs that are not in a tei:div? -->
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
