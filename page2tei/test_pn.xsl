<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:p="http://schema.primaresearch.org/PAGE/gts/pagecontent/2013-07-15"
  xmlns:mets="http://www.loc.gov/METS/"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:local="local"
  xmlns:xstring = "https://github.com/dariok/XStringUtils"
  exclude-result-prefixes="#all"
  version="3.0">
<xsl:template match="tei:pb">
  <xsl:variable name="pageprefix">
    <xsl:value-of select="@facs"/>
    <xsl:text>_</xsl:text>

  </xsl:variable>
  <xsl:copy>
    <xsl:attribute name="n">
      <xsl:value-of select="normalize-space(//tei:fw[@type='page'][starts-with(@facs, $pageprefix)])"/>
    </xsl:attribute>
    <xsl:apply-templates select="@* except @n"/>
  </xsl:copy>

</xsl:template>
<xsl:template match="@* | node()">
  <xsl:copy copy-namespaces="no">
    <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
</xsl:template>
</xsl:stylesheet>
