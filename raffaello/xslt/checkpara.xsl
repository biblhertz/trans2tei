<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns="http://www.tei-c.org/ns/1.0"
                exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

    <xsl:template match="/">
        <errors>
            <xsl:apply-templates select=".//tei:div"/>
        </errors>
    </xsl:template>

    <xsl:template match="//tei:div">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:head">
        <xsl:if test="preceding-sibling::tei:p">
            <error>
                <xsl:text>paragraph before heading around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
    </xsl:template>

    <xsl:template match="tei:p[@type='abstract']">
        <xsl:if test="preceding-sibling::tei:p[@type='paragraph']">
            <error>
                <xsl:text>abstract after paragraph around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        <xsl:if test="preceding-sibling::tei:p[@type='first']">
            <error>
                <xsl:text>abstract after paragraph around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        <xsl:if test="preceding-sibling::tei:p[@type='paragraph-first']">
            <error>
                <xsl:text>abstract after paragraph around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        <xsl:if test="preceding-sibling::tei:p[@type='paragraph-noindent']">
            <error>
                <xsl:text>abstract after paragraph around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        <xsl:if test="preceding-sibling::tei:p[@type='paragraph-center']">
            <error>
                <xsl:text>abstract after paragraph around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        <xsl:if test="preceding-sibling::tei:p[@type='paragraph-right']">
            <error>
                <xsl:text>abstract after paragraph around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        
        <xsl:if test="preceding-sibling::tei:p[not(@type)]">
            <error>
                <xsl:text>abstract typeless paragraph around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        
        <xsl:if test="preceding-sibling::tei:p[@type='archival-notice']">
            <error>
                <xsl:text>abstract after archival around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        
        <xsl:if test="preceding-sibling::tei:p[@type='commentary']">
            <error>
                <xsl:text>abstract after commentary around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        
        <xsl:if test="preceding-sibling::tei:p[@type='commentary-first']">
            <error>
                <xsl:text>abstract after commentary around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        
        <xsl:if test="preceding-sibling::tei:p[@type='commentary-noindent']">
            <error>
                <xsl:text>abstract after commentary around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        
        <xsl:if test="preceding-sibling::tei:p[@type='bibliography']">
            <error>
                <xsl:text>abstract after bib around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        
    </xsl:template>
    
    
    <xsl:template match="tei:p[@type='first'] | tei:p[@type='paragraph-first']">
        
        <xsl:if test="preceding-sibling::tei:p[@type='paragraph']">
            <error>
                <xsl:text>first after other paragraph around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        <xsl:if test="preceding-sibling::tei:p[@type='first']">
            <error>
                <xsl:text>first after other first paragraph around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        <xsl:if test="preceding-sibling::tei:p[@type='paragraph-first']">
            <error>
                <xsl:text>first after other first paragraph around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        <xsl:if test="preceding-sibling::tei:p[@type='paragraph-noindent']">
            <error>
                <xsl:text>first after other paragraph around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        <xsl:if test="preceding-sibling::tei:p[@type='paragraph-center']">
            <error>
                <xsl:text>first after other paragraph around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        <xsl:if test="preceding-sibling::tei:p[@type='paragraph-right']">
            <error>
                <xsl:text>first after other paragraph around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        
        <xsl:if test="preceding-sibling::tei:p[not(@type)]">
            <error>
                <xsl:text>first after typeless paragraph around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        
        <xsl:if test="preceding-sibling::tei:p[@type='archival-notice']">
            <error>
                <xsl:text>first after archival around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        
        <xsl:if test="preceding-sibling::tei:p[@type='commentary']">
            <error>
                <xsl:text>first after commentary around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        
        <xsl:if test="preceding-sibling::tei:p[@type='commentary-first']">
            <error>
                <xsl:text>first after commentary around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        
        <xsl:if test="preceding-sibling::tei:p[@type='commentary-noindent']">
            <error>
                <xsl:text>first after commentary around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        
        <xsl:if test="preceding-sibling::tei:p[@type='bibliography']">
            <error>
                <xsl:text>first after bib around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        
    </xsl:template>
    
    <xsl:template match="tei:p[@type='paragraph'] | tei:p[@type='paragraph-noindent'] | tei:p[@type='paragraph-center'] | tei:p[@type='paragraph-right'] | tei:p[not(@type)]">
        
        <xsl:if test="preceding-sibling::tei:p[@type='archival-notice']">
            <error>
                <xsl:text>paragraph after archival around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        
        <xsl:if test="preceding-sibling::tei:p[@type='commentary']">
            <error>
                <xsl:text>paragraph after commentary around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        
        <xsl:if test="preceding-sibling::tei:p[@type='commentary-first']">
            <error>
                <xsl:text>paragraph after commentary around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        
        <xsl:if test="preceding-sibling::tei:p[@type='commentary-noindent']">
            <error>
                <xsl:text>paragraph after commentary around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        
        <xsl:if test="preceding-sibling::tei:p[@type='bibliography']">
            <error>
                <xsl:text>paragraph after bib around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        
    </xsl:template>
    
    <xsl:template match="tei:p[@type='archival-notice']">

        <xsl:if test="preceding-sibling::tei:p[@type='commentary']">
            <error>
                <xsl:text>archival after commentary around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        
        <xsl:if test="preceding-sibling::tei:p[@type='commentary-first']">
            <error>
                <xsl:text>archival after commentary around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        
        <xsl:if test="preceding-sibling::tei:p[@type='commentary-noindent']">
            <error>
                <xsl:text>archival after commentary around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        
        <xsl:if test="preceding-sibling::tei:p[@type='bibliography']">
            <error>
                <xsl:text>archival after bib around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>
        
    </xsl:template>

    <xsl:template match="tei:p[@type='commentary-first']">


        <xsl:if test="preceding-sibling::tei:p[@type='commentary-first']">
            <error>
                <xsl:text>first commentary after other first commentary around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>

        <xsl:if test="preceding-sibling::tei:p[@type='commentary-noindent']">
            <error>
                <xsl:text>first commentary after other commentary around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>

        <xsl:if test="preceding-sibling::tei:p[@type='bibliography']">
            <error>
                <xsl:text>first commentary after bib around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>

    </xsl:template>

    <xsl:template match="tei:p[@type='commentary'] | tei:p[@type='commentary-noindent']">

        <xsl:if test="preceding-sibling::tei:p[@type='bibliography']">
            <error>
                <xsl:text>commentary after bib around: </xsl:text>
                <xsl:value-of select="@facs"/>
            </error>
        </xsl:if>

    </xsl:template>

    <xsl:template match="tei:p[@type='bibliography']"/>

    <xsl:template match="tei:p">
        <error>
            <xsl:text>unexpected type: </xsl:text>
            <xsl:value-of select="@type"/>
            <xsl:text> around </xsl:text>
            <xsl:value-of select="@facs"/>
        </error>
    </xsl:template>

    <xsl:template match="tei:pb"/>

    <!-- Default: keep as it is -->

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>


</xsl:stylesheet>
