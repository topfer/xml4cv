<?xml version="1.0" encoding="iso-8859-2"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
  
  <xsl:output method="xml" encoding="utf-8" omit-xml-declaration="no" indent="yes"/>
  
  <xsl:param name="base-size" select="9"/><!-- in points -->
  <xsl:param name="headline-size" select="1.8 * $base-size"/>
  
  <xsl:param name="text-size" select="1.0 * $base-size"/>
  <xsl:param name="footer-size" select="0.9 * $base-size"/>
  
  <xsl:param name="item-indent" select="2"/><!-- in milimeters -->
  <xsl:param name="item-spacing" select="2"/><!-- in milimeters -->
  
  <xsl:param name="h1-size" select="1.4 * $base-size"/>
  <xsl:param name="h2-size" select="1.2 * $base-size"/>
  <xsl:param name="h3-size" select="1.0 * $base-size"/>
  
  <xsl:param name="indent" select="10"/><!-- in points -->
  
  <xsl:param name="margin-horiz" select="25"/>
  <xsl:param name="margin-vert" select="15"/>
  <xsl:variable name="margin-left" select="$margin-horiz - $item-indent"/>
  <xsl:variable name="margin-right" select="$margin-horiz + $item-indent"/>
  <xsl:variable name="margin-top" select="$margin-vert"/>
  <xsl:variable name="margin-bottom" select="$margin-vert + 10"/>
  
  <xsl:template match="/">
    <xsl:variable name="text-fullname">
      <xsl:if test="cv/data/name/title">
        <xsl:value-of select="cv/data/name/title"/>
        <xsl:text> </xsl:text>
      </xsl:if>
      <xsl:value-of select="cv/data/name/firstname"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="cv/data/name/lastname"/>
    </xsl:variable>
    
    <xsl:variable name="text-cv">Curriculum vit&#xe6;</xsl:variable>
    
    <fo:root>
      
      <fo:layout-master-set>
        <fo:simple-page-master master-name="A4" page-height="29.7cm" page-width="21cm">
          <fo:region-body margin-left="{$margin-left}mm" margin-right="{$margin-right}mm" margin-top="{$margin-top}mm" margin-bottom="{$margin-bottom}mm"/>
          <fo:region-after extent="{$margin-vert + 5}mm" />
        </fo:simple-page-master>
      </fo:layout-master-set>
      
      <fo:page-sequence master-reference="A4" font-family="Verdana">
        
        <fo:static-content flow-name="xsl-region-after">
          <fo:block margin-left="{$margin-left}mm" margin-right="{$margin-right}mm" font-size="{$footer-size}pt" text-align-last="justify">
            Page <fo:page-number />
            &#8211;
            <xsl:value-of select="$text-cv"/>
            of <xsl:value-of select="$text-fullname"/>
            <fo:leader leader-pattern="space" />
            <fo:inline font-family="Courier New" font-weight="bold">
              <xsl:value-of select="/cv/@uri"/>
            </fo:inline>
          </fo:block>
          
        </fo:static-content>
        
        <fo:flow flow-name="xsl-region-body">
          <fo:block font-size="{$headline-size}pt" font-weight="bold" space-after="2mm" width="100%" text-align="start">
            <xsl:value-of select="$text-fullname"/>
            - Curriculum vit&#xe6;
          </fo:block>
          
          <xsl:apply-templates/>
          
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>
  
  <xsl:template match="datasection">
    <fo:table border-collapse="collapse" start-indent="1pt" space-after="20pt">
      <fo:table-column column-width="75pt"/>
      <fo:table-column column-width="225pt"/>
      <fo:table-column column-width="150pt"/>
      <fo:table-body>
        <xsl:apply-templates/>
      </fo:table-body>      
    </fo:table>
  </xsl:template>

  <xsl:template match="item">
    <fo:table-row>
      <fo:table-cell>
        <fo:block font-weight="bold" font-size="{$h3-size}pt"><xsl:apply-templates select="datahead"/></fo:block>
      </fo:table-cell>
      <fo:table-cell>
        <fo:block font-size="{$h3-size}pt"><xsl:apply-templates select="datadesc"/></fo:block>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>
  
  <xsl:template match="sectiontitle">

        <fo:table-row>
          <fo:table-cell number-columns-spanned="3" border-bottom="1px solid black">
            <fo:block font-size="{$h1-size}pt" font-weight="bold">
              <xsl:apply-templates/>
            </fo:block>
          </fo:table-cell>
        </fo:table-row>

  </xsl:template>


  <xsl:template match="desc">
    <xsl:param name="list-depth" select="count(ancestor::block)"/>
    <fo:table-row>
      <xsl:for-each select="ancestor::block">
        <fo:table-cell>
          <fo:block></fo:block>
        </fo:table-cell>
      </xsl:for-each>
      <fo:table-cell>
        <fo:block></fo:block>
      </fo:table-cell>
      <fo:table-cell number-columns-spanned="{4 - $list-depth}">
        <fo:block font-size="{$h3-size}pt">
          <xsl:apply-templates/>
        </fo:block>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>
  
  <xsl:template match="section">
    <fo:table border-collapse="collapse" start-indent="1pt" space-after="20pt">

      <fo:table-column column-width="{$indent}pt"/>
      <fo:table-column column-width="{$indent}pt"/>
      <fo:table-column column-width="{$indent}pt"/>
      <fo:table-column column-width="{$indent}pt"/>
      <fo:table-column column-width="{450 - 4 * $indent}pt"/>

      <!--
          <fo:table-column column-width="{$indent}pt" border="1px solid black"/>
          <fo:table-column column-width="{$indent}pt" border="1px solid black"/>
          <fo:table-column column-width="{$indent}pt" border="1px solid black"/>
          <fo:table-column column-width="{$indent}pt" border="1px solid black"/>
          <fo:table-column column-width="{450 - 4 * $indent}pt" border="1px solid black"/>
          -->

      <fo:table-body>
        <xsl:apply-templates/>
      </fo:table-body>
    </fo:table>
  </xsl:template>
  
  <xsl:template match="title">
    <xsl:param name="title-depth" select="count(ancestor::block)"/>
    <xsl:choose>
      
      <xsl:when test="$title-depth=0">
        <fo:table-row>
          <fo:table-cell number-columns-spanned="5" border-bottom="1px solid black">
            <fo:block font-size="{$h1-size}pt" font-weight="bold">
              <xsl:apply-templates/>
            </fo:block>
          </fo:table-cell>
        </fo:table-row>
      </xsl:when>
      
      <xsl:when test="$title-depth=1">
        <!--
        <fo:table-row>          
          <fo:table-cell number-columns-spanned="5">
            <fo:block>&#160;</fo:block>
          </fo:table-cell>
        </fo:table-row>
        -->
        <fo:table-row height="18pt" display-align="after">
          <fo:table-cell>
            <fo:block></fo:block>
          </fo:table-cell>
          <fo:table-cell>
            <fo:block font-weight="bold" font-size="{$h3-size}pt">
              <xsl:text>&#x2022;</xsl:text>
            </fo:block>
          </fo:table-cell>
          <fo:table-cell number-columns-spanned="3">
            <fo:block font-weight="bold" font-size="{$h3-size}pt">
              <xsl:apply-templates/>
            </fo:block>
          </fo:table-cell>
        </fo:table-row>
      </xsl:when>
      
      <xsl:when test="$title-depth=2">
        <fo:table-row>              
          <fo:table-cell number-columns-spanned="2">
            <fo:block></fo:block>
          </fo:table-cell>
          <fo:table-cell>
            <fo:block font-weight="bold" font-size="{$h3-size}pt">
              <xsl:text>-</xsl:text>
            </fo:block>
          </fo:table-cell>
          <fo:table-cell number-columns-spanned="2">
            <fo:block font-size="{$h3-size}pt">
              <xsl:apply-templates/>
            </fo:block>
          </fo:table-cell>
        </fo:table-row>
      </xsl:when>
      
      <xsl:when test="$title-depth=3">
        <fo:table-row>              
          <fo:table-cell number-columns-spanned="4">
            <fo:block></fo:block>
          </fo:table-cell>
          <fo:table-cell number-columns-spanned="1">
            <fo:block font-size="{$h3-size}pt">
              <xsl:apply-templates/>
            </fo:block>
          </fo:table-cell>
        </fo:table-row>
      </xsl:when>
      
      
      <!--
      <xsl:otherwise>
        <fo:block font-weight="bold" font-size="{$h3-size}pt" space-before="4mm" space-after="1mm">
          <xsl:apply-templates/>
        </fo:block>
      </xsl:otherwise>
    -->
    </xsl:choose>
  </xsl:template>
  
    <xsl:template match="p">
        <fo:block space-after="{$item-spacing}mm">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="url">
        <fo:basic-link external-destination="{.}" color="blue" text-decoration="underline">
            <xsl:value-of select="."/>
        </fo:basic-link>
    </xsl:template>
    
    <xsl:template match="page-break">
        <fo:block break-before="page">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
