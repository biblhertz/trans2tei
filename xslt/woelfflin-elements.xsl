<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns="http://www.tei-c.org/ns/1.0"
                exclude-result-prefixes="#all">
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

    <xsl:variable name="volume" select="document('temp/params.xml')/params/@volume"/>
    <xsl:variable name="texttype" select="document('temp/params.xml')/params/@texttype"/>
    <xsl:variable name="docprefix">
        <xsl:text>v</xsl:text>
        <xsl:value-of select="$volume"/>
        <xsl:text>-</xsl:text>
        <xsl:value-of select="$texttype"/>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

    <xsl:template name="pagemark">
        <xsl:variable name="number">
            <xsl:value-of select="'0'"/>
        </xsl:variable>
        <milestone unit="page" ed="original">
            <xsl:attribute name="n">
                <xsl:value-of select="$number"/>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="$docprefix"/>
                <xsl:text>-pg</xsl:text>
                <xsl:value-of select="translate($number, '[]', '')"/>
            </xsl:attribute>
        </milestone>
    </xsl:template>

    <xsl:template match="tei:p[@rend='HW_Quote_right']/tei:hi[@rend='HW_Page_mark']" priority="4"/>
    <xsl:template match="tei:head/tei:hi[@rend='HW_Page_mark']" priority="4"/>

    <xsl:template match="tei:hi[@rend='HW_Page_mark']" priority="1">
        <xsl:call-template name="pagemark"/>
    </xsl:template>

    <xsl:template match="tei:p[@rend='HW_Signature_left']">
        <signed rendition="#left" xml:id="{../@xml:id}-p-{position()}">
            <xsl:apply-templates select="@* except @rend"/>
            <xsl:apply-templates/>
        </signed>
    </xsl:template>

    <xsl:template match="tei:p[@rend='HW_Signature_right']">
        <signed rendition="#right" xml:id="{../@xml:id}-p-{position()}">
            <xsl:apply-templates select="@* except @rend"/>
            <xsl:apply-templates/>
        </signed>
    </xsl:template>

    <xsl:template match="tei:p[@rend='HW_Date_left']">
        <dateline rendition="#left" xml:id="{../@xml:id}-p-{position()}">
            <xsl:apply-templates select="@* except @rend"/>
            <xsl:apply-templates/>
        </dateline>
    </xsl:template>

    <xsl:template match="tei:p[@rend='HW_Date_right']">
        <dateline rendition="#right" xml:id="{../@xml:id}-p-{position()}">
            <xsl:apply-templates select="@* except @rend"/>
            <xsl:apply-templates/>
        </dateline>
    </xsl:template>

    <xsl:template match="tei:p[@rend='HW_Quote_right']">
        <xsl:for-each select=".//tei:hi[@rend='HW_Page_mark']">
            <xsl:call-template name="pagemark"/>
        </xsl:for-each>
        <epigraph rendition="#right" xml:id="{../@xml:id}-p-{position()}">
            <xsl:apply-templates select="@* except @rend"/>
            <xsl:apply-templates/>
        </epigraph>
    </xsl:template>

    <xsl:template match="tei:head">
        <xsl:for-each select=".//tei:hi[@rend='HW_Page_mark']">
            <xsl:call-template name="pagemark"/>
        </xsl:for-each>
        <head rendition="{@rendition}">
            <xsl:apply-templates select="@* except @rend"/>
            <xsl:apply-templates/>
        </head>
    </xsl:template>

    <xsl:template match="tei:p[@rend='HW_Quote']">
        <quote rendition="#block" xml:id="{../@xml:id}-p-{position()}">
            <xsl:apply-templates select="@* except @rend"/>
            <xsl:apply-templates/>
        </quote>
    </xsl:template>

    <xsl:template match="tei:p[@rend='HW_Bildlegende']">
        <figure xml:id="v{$volume}-img-{position()}">
            <head>
                <xsl:apply-templates select="@* except @rend"/>
                <xsl:apply-templates/>
            </head>
        </figure>
    </xsl:template>

    <xsl:template match="tei:hi[@rend='HW_inline_Bildlegende']">
        <figure place="inline"  xml:id="v{$volume}-img-{position()}">
            <head>
                <xsl:apply-templates select="@* except @rend"/>
                <xsl:apply-templates/>
            </head>
        </figure>
    </xsl:template>

    <xsl:template match="tei:note[@place='foot']//tei:p[@rend='HW_Body_text']" priority="2">
        <p xml:id="{../@xml:id}-p-{position()}">
            <xsl:apply-templates select="@* except @rend"/>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:p[@rend='HW_Body_text']" priority="1">
        <p xml:id="{../@xml:id}-p-{position()}">
            <xsl:apply-templates select="@* except @rend"/>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:p[@rend='HW_Endnote']">
        <p xml:id="{../@xml:id}-p-{position()}">
            <xsl:apply-templates select="@* except @rend"/>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:hi[@rend='HW_Gesperrt']">
        <hi rendition="#HW_Gesperrt">
            <xsl:apply-templates select="@* except @rend"/>
            <xsl:apply-templates/>
        </hi>
    </xsl:template>

    <xsl:template match="tei:hi[@rend='HW_Greek']">
        <foreign xml:lang="gr">
            <xsl:apply-templates select="@* except @rend"/>
            <xsl:apply-templates/>
        </foreign>
    </xsl:template>

    <xsl:template match="tei:note[@type='comment']//tei:hi[@rend='HW_emphasis']" priority="1">
        <emph>
            <xsl:apply-templates select="@* except @rend"/>
            <xsl:apply-templates/>
        </emph>
    </xsl:template>

    <xsl:template match="tei:hi[@rend='HW_emphasis']" priority="2">
        <hi rendition="#italic">
            <xsl:apply-templates select="@* except @rend"/>
            <xsl:apply-templates/>
        </hi>
    </xsl:template>

    <xsl:template match="tei:hi[@rend='HW_Hoch']">
        <add>
            <xsl:apply-templates select="@* except @rend"/>
            <xsl:apply-templates/>
        </add>
    </xsl:template>

    <xsl:template match="tei:hi[@rend='HW_Unterstrichen']">
        <hi rendition="#underlined">
            <xsl:apply-templates select="@* except @rend"/>
            <xsl:apply-templates/>
        </hi>
    </xsl:template>

    <xsl:template match="tei:hi[@rend='HW_Durchgestrichen']">
        <del>
            <xsl:apply-templates select="@* except @rend"/>
            <xsl:apply-templates/>
        </del>
    </xsl:template>

    <xsl:template match="tei:p[@rend='HW_orignal_colophon']">
        <div rendition="#HW_orignal_colophon">
            <p>
                <xsl:apply-templates select="@* except @rend"/>
                <xsl:apply-templates/>
            </p>
        </div>
    </xsl:template>

    <xsl:template match="tei:p[@rend='HW_opener']">
        <opener xml:id="{../@xml:id}-p-{position()}">
            <xsl:apply-templates select="@* except @rend"/>
            <xsl:apply-templates/>
        </opener>
    </xsl:template>

    <xsl:template match="tei:p[@rend='HW_closer']">
        <closer xml:id="{../@xml:id}-p-{position()}">
            <xsl:apply-templates select="@* except @rend"/>
            <xsl:apply-templates/>
        </closer>
    </xsl:template>

    <xsl:template match="tei:p[@rend='HW_Salute']">
        <salute xml:id="{../@xml:id}-p-{position()}">
           <xsl:apply-templates select="@* except @rend"/>
            <xsl:apply-templates/>
        </salute>
    </xsl:template>

    <xsl:template match="tei:hi[@rend='HW_Salute']">
        <salute rend="inline">
            <xsl:apply-templates select="@* except @rend"/>
            <xsl:apply-templates/>
        </salute>
    </xsl:template>

    <xsl:template match="tei:p[@rend='HW_Signed']">
        <salute>
            <xsl:apply-templates select="@* except @rend"/>
            <xsl:apply-templates/>
        </salute>
    </xsl:template>

    <xsl:template match="tei:hi[@rend='HW_Signed']">
        <salute rend="inline">
            <xsl:apply-templates select="@* except @rend"/>
            <xsl:apply-templates/>
        </salute>
    </xsl:template>

    <xsl:template match="tei:lb">
        <xsl:copy>
            <xsl:apply-templates select="@break | @n"/>
        </xsl:copy>
    </xsl:template>

    <!-- Delete elements: -->

    <xsl:template match="tei:p/@facs"/>
    <xsl:template match="tei:head/@facs"/>
    <xsl:template match="tei:ab/@facs"/>


    <!-- Default: keep as it is -->

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>


</xsl:stylesheet>
