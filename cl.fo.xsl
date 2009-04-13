<?xml version="1.0" encoding="iso-8859-2"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format">
  
  <xsl:output method="xml" encoding="utf-8" omit-xml-declaration="no" indent="yes"/>

  <xsl:param name="base-size" select="9"/> <!-- in points -->
  <xsl:param name="headline-size" select="1.8 * $base-size"/>
  <xsl:param name="section-size" select="1.4 * $base-size"/>
  <xsl:param name="subsection-size" select="1.2 * $base-size"/>
  <xsl:param name="text-size" select="1.0 * $base-size"/>
  <xsl:param name="footer-size" select="0.9 * $base-size"/>
  
  <xsl:param name="item-indent" select="3"/> <!-- in milimeters -->
  <xsl:param name="item-spacing" select="2"/> <!-- in milimeters -->
  <xsl:param name="margin-horiz" select="25"/>
  <xsl:param name="margin-vert" select="15"/>

  <xsl:variable name="margin-left" select="$margin-horiz - $item-indent"/>
  <xsl:variable name="margin-right" select="$margin-horiz + $item-indent"/>
  <xsl:variable name="margin-top" select="$margin-vert"/>
  <xsl:variable name="margin-bottom" select="$margin-vert + 10"/>
  
  <xsl:template match="/">

    <xsl:variable name="text-fullname">
      <xsl:value-of select="cl/data/name/firstname"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="cl/data/name/lastname"/>
    </xsl:variable>

    <fo:root>
      <fo:layout-master-set>
	<fo:simple-page-master master-name="A4"
			       page-height="29.7cm"
			       page-width="21cm">
	  <fo:region-body margin-left="{$margin-left}mm"
			  margin-right="{$margin-right}mm"
			  margin-top="{$margin-top}mm"
			  margin-bottom="{$margin-bottom}mm"/>
	  <fo:region-after extent="{$margin-vert + 5}mm" />
	</fo:simple-page-master>
      </fo:layout-master-set>
      
      <fo:page-sequence master-reference="A4" font-family="Verdana">

	<fo:static-content flow-name="xsl-region-after">
	  <fo:block margin-left="{$margin-left}mm"
		    margin-right="{$margin-right}mm"
		    font-size="{$footer-size}pt"
		    text-align-last="justify">
	    Page <fo:page-number /> &#8211;
	    <xsl:value-of select="$text-fullname"/>
	    <fo:leader leader-pattern="space" />
	  </fo:block>	  
	</fo:static-content>

	  <fo:flow flow-name="xsl-region-body">
	  <fo:block font-size="{$headline-size}pt" font-weight="bold" space-after="2mm" width="100%"
		    text-align="start">
	    <xsl:value-of select="$text-fullname"/> - Cover letter
	  </fo:block>
	  
	  <xsl:apply-templates/>	   

	</fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

  <xsl:template match="section">
   <fo:table table-layout="fixed" width="100%" space-before="4mm">
     <fo:table-column column-number="1"/>
     <fo:table-body>
       <fo:table-row keep-with-next="always">
	 <fo:table-cell>
    <fo:block margin-left="{$item-indent}mm" text-align="justify" font-size="{$text-size}pt">
      <xsl:apply-templates/>
    </fo:block>
	 </fo:table-cell>
       </fo:table-row>
     </fo:table-body>
   </fo:table>
  </xsl:template>


</xsl:stylesheet>
