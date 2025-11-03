<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:f="http://www.forester-notes.org"
                xmlns:html="http://www.w3.org/1999/xhtml">
  <xsl:output method="text" encoding="utf-8" indent="yes" doctype-public="" doctype-system="" />

  <xsl:template match="html:p">
    <xsl:text>&#xa;</xsl:text>
    <xsl:apply-templates />
    <xsl:if test="parent::f:mainmatter/parent::f:tree/f:frontmatter/f:taxon[text()='Proof'] and position()=last()">
      <xsl:text>\qedhere</xsl:text>
    </xsl:if>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="html:strong">
    <xsl:text>\textbf{</xsl:text>
    <xsl:apply-templates />
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="html:em">
    <xsl:text>\emph{</xsl:text>
    <xsl:apply-templates />
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="f:tex[not(@display='block')]">
    <xsl:text>\(</xsl:text>
    <xsl:apply-templates />
    <xsl:text>\)</xsl:text>
  </xsl:template>

  <xsl:template match="f:tex[@display='block']">
    <xsl:text>\begin{equation}</xsl:text>
    <xsl:apply-templates />
    <xsl:if test="parent::f:mainmatter/parent::f:tree/f:frontmatter/f:taxon[text()='Proof'] and position()=last()">
      <xsl:text>\qedhere</xsl:text>
    </xsl:if>
    <xsl:text>\end{equation}</xsl:text>
  </xsl:template>

  <xsl:template match="html:ol">
    <xsl:text>\begin{enumerate}</xsl:text>
    <xsl:apply-templates />
    <xsl:text>\end{enumerate}</xsl:text>
  </xsl:template>

  <xsl:template match="html:ul">
    <xsl:text>\begin{itemize}</xsl:text>
    <xsl:apply-templates />
    <xsl:text>\end{itemize}</xsl:text>
  </xsl:template>

  <xsl:template match="html:li">
    <xsl:text>\item{}</xsl:text>
    <xsl:apply-templates />
    <xsl:if test="(parent::f:ol/parent::f:mainmatter/parent::f:tree/f:frontmatter/f:taxon[text()='Proof'] or parent::f:ul/parent::f:mainmatter/parent::f:tree/f:frontmatter/f:taxon[text()='Proof']) and position()=last()">
      <xsl:text>\qedhere</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="html:pre">
    <xsl:text>\begin{verbatim}</xsl:text>
    <xsl:apply-templates />
    <xsl:text>\end{verbatim}</xsl:text>
  </xsl:template>

  <xsl:template match="html:code">
    <xsl:text>\verb|</xsl:text>
    <xsl:apply-templates />
    <xsl:text>|</xsl:text>
  </xsl:template>

  <xsl:template match="f:ref[@taxon]">
    <xsl:value-of select="@taxon" />
    <xsl:text>~</xsl:text>
    <xsl:text>\ref{</xsl:text>
    <xsl:value-of select="@display-uri" />
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="f:ref[@taxon='Reference']">
    <xsl:text>\cite{</xsl:text>
    <xsl:value-of select="@display-uri" />
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="f:ref[not(@taxon)]">
    <xsl:text>\S~\ref{</xsl:text>
    <xsl:value-of select="@display-uri" />
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="f:contextual-number">
    <xsl:text>\ref{</xsl:text>
    <xsl:value-of select="@display-uri" />
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="f:link[@type='local']">
    <xsl:choose>
      <xsl:when test="//f:tree/f:frontmatter[f:display-uri/text()=current()/@display-uri and not(ancestor::f:backmatter)]">
      	<xsl:variable name="content">
          <xsl:apply-templates />
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="f:contextual-number">
            <xsl:text>\cref{</xsl:text>
            <xsl:value-of select="@display-uri" />
            <xsl:text>}</xsl:text>
          </xsl:when>
          <xsl:otherwise>
             <xsl:text>\hyperref[</xsl:text>
            <xsl:value-of select="@display-uri" />
            <xsl:text>]{</xsl:text>
            <xsl:value-of select="$content" />
            <xsl:text>}</xsl:text>
          </xsl:otherwise>
      </xsl:choose>
      </xsl:when>
      <xsl:when test="/f:tree/f:backmatter//f:tree[f:frontmatter[f:taxon[text()='Reference'] and f:display-uri[text()=current()/@display-uri]]]">
        <xsl:text>\cite{</xsl:text>
        <xsl:value-of select="@display-uri" />
        <xsl:text>}</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="f:headline" />

  <xsl:template match="f:resource">
    <!-- <xsl:text>\begin{center}</xsl:text> -->
    <!-- <xsl:text>\includestandalone{</xsl:text> -->
    <!-- <xsl:value-of select="@hash" /> -->
    <!-- <xsl:text>}</xsl:text> -->
    <xsl:apply-templates select="f:resource-source[@part='body']" />
    <!-- <xsl:text>\end{center}</xsl:text> -->
  </xsl:template>

  <xsl:template match="html:table">
    <xsl:text>\begin{tabular}</xsl:text>
    <xsl:apply-templates select="html:thead" mode="column-declaration" />
    <xsl:apply-templates />
    <xsl:text>\end{tabular}</xsl:text>
  </xsl:template>

  <xsl:template match="html:thead" mode="column-declaration">
    <xsl:text>{</xsl:text>
    <xsl:apply-templates mode="column-declaration" />
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="html:th[last()]" mode="column-declaration">
    <xsl:text>l</xsl:text>
  </xsl:template>

  <xsl:template match="html:th" mode="column-declaration">
    <xsl:text>l|</xsl:text>
  </xsl:template>

  <xsl:template match="html:tr">
    <xsl:apply-templates />
    <xsl:text>\\&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="html:td[1]">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="html:td">
    <xsl:text> &amp; </xsl:text>
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="html:thead">
    <xsl:apply-templates />
    <xsl:text>\hline&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="html:th[1]">
    <xsl:text>\strong{</xsl:text>
    <xsl:apply-templates />
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="html:th">
    <xsl:text> &amp; </xsl:text>
    <xsl:text>\strong{</xsl:text>
    <xsl:apply-templates />
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="html:figure">
    <xsl:text>\begin{center}</xsl:text>
    <xsl:apply-templates />
    <xsl:text>\end{center}</xsl:text>
  </xsl:template>

  <xsl:template match="html:img">
    <xsl:text>\includegraphics{../assets/</xsl:text>
    <xsl:value-of select="@pdfsrc" />
    <xsl:text>}</xsl:text>
  </xsl:template>

</xsl:stylesheet>
