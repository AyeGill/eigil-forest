<?xml version="1.0"?>
<!-- SPDX-License-Identifier: CC0-1.0 -->
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:f="http://www.forester-notes.org"
                xmlns:html="http://www.w3.org/1999/xhtml">

  <xsl:output method="text" encoding="utf-8" indent="yes" doctype-public="" doctype-system="" />

  <xsl:include href="core.xsl" />
  <xsl:include href="environments.xsl" />

  <xsl:template match="/">
    <xsl:text>\documentclass[english, a4paper, oneside, 11pt, reqno]{article}%&#xa;</xsl:text>
    <xsl:text>\input{mc-preamble.tex}&#xa;</xsl:text>
    <xsl:text>
      \addbibresource{./\jobname.bib}
      \allowdisplaybreaks
      \raggedbottom
    </xsl:text>

    <xsl:apply-templates select="/f:tree/f:frontmatter" mode="top" />

    <xsl:text>\begin{document}</xsl:text>

    <xsl:text>&#xa;</xsl:text>
    <xsl:text>\begin{filecontents*}[overwrite]{\jobname.bib}</xsl:text>
    <xsl:text>&#xa;</xsl:text>
    <xsl:apply-templates select="/f:tree/f:backmatter//f:tree/f:frontmatter[f:taxon[text()='Reference']]/f:meta[@name='bibtex']" />
    <xsl:text>&#xa;</xsl:text>
    <xsl:text>\end{filecontents*}</xsl:text>
    <xsl:text>&#xa;</xsl:text>
    <xsl:text>
    \maketitle
    \tableofcontents
    </xsl:text>
    <xsl:apply-templates select="/f:tree/f:mainmatter" />
    <!-- <xsl:text>\nocite{*}</xsl:text>
    <xsl:text>\bibliographystyle{plain}</xsl:text>
    <xsl:text>\bibliography{\jobname.bib}</xsl:text> -->
    <xsl:text>\end{document}</xsl:text>
  </xsl:template>

  <xsl:template match="f:meta[@name='bibtex']">
    <xsl:apply-templates />
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="f:frontmatter" mode="top">
    <xsl:text>\title{</xsl:text>
    <xsl:apply-templates select="f:title" />
    <xsl:text>}</xsl:text>
    <xsl:text>\author{</xsl:text>
    <xsl:for-each select="f:authors/f:author">
      <xsl:value-of select="." />
      <xsl:if test="not(position()=last())">
        <xsl:text>\and{}</xsl:text>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="f:frontmatter/f:display-uri" mode="label">
   <xsl:text>\label[</xsl:text>
   <xsl:apply-templates select="../f:taxon" />
   <xsl:text>]</xsl:text>
   <xsl:text>{</xsl:text>
    <xsl:apply-templates />
   <xsl:text>}</xsl:text>
  </xsl:template>
<!--
  <xsl:template match="f:frontmatter/f:display-uri[@type='machine']" mode="label">
  </xsl:template> -->

  <xsl:template match="f:tree[not(f:frontmatter/f:taxon) or f:frontmatter/f:taxon = 'section']">
    <xsl:apply-templates select="f:frontmatter/f:title" />
    <xsl:apply-templates select="f:frontmatter/f:display-uri" mode="label" />
    <xsl:apply-templates select="f:mainmatter" />
  </xsl:template>

  <xsl:template match="f:mainmatter">
    <xsl:apply-templates select="html:p|f:tex|html:ol|html:ul|html:pre|f:tree|f:resource|html:figure|html:table" />
  </xsl:template>

</xsl:stylesheet>
