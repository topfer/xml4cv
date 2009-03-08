<?xml version="1.0" encoding="iso-8859-2"?>
<xsl:stylesheet version="1.0"
		        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		        xmlns:date="http://exslt.org/dates-and-times"
		        extension-element-prefixes="date">
  
  <!-- <xsl:import href="http://www.exslt.org/date/functions/format-date/date.format-date.function.xsl"/> -->
  
  <xsl:output method="xml" encoding="iso-8859-2" omit-xml-declaration="no" indent="yes"/>

  <xsl:template match="*">
    <xsl:copy>
	  <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="data">
    <xsl:copy-of select="."/>
    <section>
      <title>Personal information</title>
      <xsl:apply-templates/>
    </section>
  </xsl:template>

  <xsl:template match="data/name">
    <item>
      <title>Name:</title>
      <desc>
	    <xsl:if test="title">
	      <xsl:apply-templates select="title"/>
	      <xsl:text> </xsl:text>
	    </xsl:if>
	    <xsl:apply-templates select="lastname"/>,
	    <xsl:text> </xsl:text>
	    <xsl:apply-templates select="firstname"/>
      </desc>
    </item>
  </xsl:template>

  <xsl:template match="data/address">
    <item>
      <title>Address:</title>
      <desc>
	    <xsl:apply-templates select="street"/>,
	    <xsl:apply-templates select="city"/>,
	    <xsl:apply-templates select="zip"/>
	    <xsl:text> </xsl:text>
	    <xsl:apply-templates select="country"/>
      </desc>
    </item>
  </xsl:template>
  
  <xsl:template match="data/telephone">
    <item>
      <title>Telephone:</title>
      <desc><xsl:apply-templates/></desc>
    </item>
  </xsl:template>
  
  <xsl:template match="data/email[@smtp]">
    <item>
      <title>E-mail:</title>
      <desc><a href="mailto:{@smtp}"><xsl:value-of select="@smtp"/></a></desc>
    </item>
  </xsl:template>

  <xsl:template match="data/email[not (@smtp)]">
    <item>
      <title>E-mail:</title>
      <desc><xsl:apply-templates/></desc>
    </item>
  </xsl:template>
  
  <xsl:template match="data/homepage[@uri]">
    <item>
      <title>Home page:</title>
      <desc><a href="{@uri}"><xsl:value-of select="@uri"/></a></desc>
    </item>
  </xsl:template>

  <xsl:template match="data/homepage[not (@uri)]">
    <item>
      <title>Home page:</title>
      <desc><xsl:apply-templates/></desc>
    </item>
  </xsl:template>

  <xsl:template match="data/birthday">
    <item>
      <title>Date of birth:</title>
      <desc>
        <xsl:apply-templates/>
      </desc>
    </item>
  </xsl:template>  

</xsl:stylesheet>
