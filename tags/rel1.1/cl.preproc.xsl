<?xml version="1.0" encoding="iso-8859-2"?>

<xsl:stylesheet version="1.0"
		        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		        xmlns:date="http://exslt.org/dates-and-times"
		        extension-element-prefixes="date">
  
  <xsl:output method="xml" encoding="iso-8859-2" omit-xml-declaration="no" indent="yes"/>


  <xsl:template match="/">
    <xsl:copy-of select="/"/>
  </xsl:template>

</xsl:stylesheet>
