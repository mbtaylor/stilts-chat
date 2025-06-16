<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output version="1.0" method="xml" indent="yes"/>

  <xsl:template match="/">
    <xsl:element name="output">
      <xsl:apply-templates select="//sect[@id='cmdUsage']/subsect/subsubsect[subhead/title='Examples']"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="subsubsect">
    <xsl:text>&#x0a;</xsl:text>
    <xsl:param name="taskname" select="../@id"/>
    <xsl:for-each select="p/dl/dt">
      <xsl:element name="example">
        <xsl:element name="task">
          <xsl:apply-templates select="$taskname"/>
        </xsl:element>
        <xsl:element name="prompt">
          <xsl:apply-templates select="following-sibling::dd[1]"/>
        </xsl:element>
        <xsl:element name="response">
          <xsl:apply-templates select="."/>
        </xsl:element>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
