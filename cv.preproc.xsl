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
          <datasection>
      <sectiontitle><xsl:value-of select="@display"/></sectiontitle>
      <xsl:apply-templates/>
          </datasection>
  </xsl:template>

  <xsl:template match="data/name">
    <item>
      <datahead><xsl:value-of select="@display"/>:</datahead>
      <datadesc>
	    <xsl:if test="title">
	      <xsl:apply-templates select="title"/>
	      <xsl:text> </xsl:text>
	    </xsl:if>
	    <xsl:apply-templates select="lastname"/>,
	    <xsl:text> </xsl:text>
	    <xsl:apply-templates select="firstname"/>
      </datadesc>
    </item>
  </xsl:template>

  <xsl:template match="data/address">
    <item>
      <datahead><xsl:value-of select="@display"/>:</datahead>
      <datadesc>
	    <xsl:apply-templates select="street"/><xsl:text>,</xsl:text>
	    <xsl:apply-templates select="city"/><xsl:text>,</xsl:text>
	    <xsl:apply-templates select="zip"/><xsl:text> </xsl:text>
	    <xsl:apply-templates select="country"/>
      </datadesc>
    </item>
  </xsl:template>
  
  <xsl:template match="data/telephone">
    <item>
      <datahead><xsl:value-of select="@display"/>:</datahead>
      <datadesc><xsl:apply-templates/></datadesc>
    </item>
  </xsl:template>
  
  <xsl:template match="data/email[@smtp]">
    <item>
      <datahead><xsl:value-of select="@display"/>:</datahead>
      <datadesc><a href="mailto:{@smtp}"><xsl:value-of select="@smtp"/></a></datadesc>
    </item>
  </xsl:template>

  <xsl:template match="data/email[not (@smtp)]">
    <item>
      <datahead><xsl:value-of select="@display"/>:</datahead>
      <datadesc><xsl:apply-templates/></datadesc>
    </item>
  </xsl:template>
  
  <xsl:template match="data/homepage[@uri]">
    <item>
      <datahead>Home page:</datahead>
      <datadesc><a href="{@uri}"><xsl:value-of select="@uri"/></a></datadesc>
    </item>
  </xsl:template>

  <xsl:template match="data/homepage[not (@uri)]">
    <item>
      <datahead>Home page:</datahead>
      <datadesc><xsl:apply-templates/></datadesc>
    </item>
  </xsl:template>

  <!--
  <Xsl:template match="data/age">
    <item>
      <datahead><xsl:value-of select="@display"/>:</datahead>
      <datadesc>
        <xsl:apply-templates/>
      </datadesc>
    </item>
  </xsl:template>  
  -->
  
  <xsl:template match="data/birthday">
    <item>
      <datahead>Date of birth:</datahead>
      <datadesc>
        <xsl:apply-templates/>
      </datadesc>
    </item>
  </xsl:template>  

</xsl:stylesheet>
