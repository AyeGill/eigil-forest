<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:f="http://www.forester-notes.org">

  <xsl:output method="text" encoding="utf-8" indent="yes" doctype-public="" doctype-system="" />

  <xsl:template match="/f:tree/f:mainmatter/f:tree[not(f:frontmatter/f:taxon) or f:frontmatter/f:taxon = 'section']/f:frontmatter/f:title">
    <xsl:text>\section{</xsl:text>
    <xsl:apply-templates />
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="/f:tree/f:mainmatter/f:tree/f:mainmatter/f:tree[not(f:frontmatter/f:taxon) or f:frontmatter/f:taxon = 'section']/f:frontmatter/f:title">
    <xsl:text>\subsection{</xsl:text>
    <xsl:apply-templates />
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="/f:tree/f:mainmatter/f:tree/f:mainmatter/f:tree/f:mainmatter/f:tree[not(f:frontmatter/f:taxon) or f:frontmatter/f:taxon = 'section']/f:frontmatter/f:title">
    <xsl:text>\subsubsection{</xsl:text>
    <xsl:apply-templates />
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="/f:tree/f:mainmatter/f:tree/f:mainmatter/f:tree/f:mainmatter/f:tree/f:mainmatter/f:tree[not(f:frontmatter/f:taxon) or f:frontmatter/f:taxon = 'section']/f:frontmatter/f:title">
    <xsl:text>\paragraph{</xsl:text>
    <xsl:apply-templates />
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template name="environments">
    <xsl:text>\newtheorem{theorem}{Theorem}[section]%&#xa;</xsl:text>
    <xsl:text>\newtheorem{lemma}[theorem]{Lemma}%&#xa;</xsl:text>
    <xsl:text>\newtheorem{observation}[theorem]{Observation}%&#xa;</xsl:text>
    <xsl:text>\newtheorem{axiom}[theorem]{Axiom}%&#xa;</xsl:text>
    <xsl:text>\newtheorem{corollary}[theorem]{Corollary}%&#xa;</xsl:text>
    <xsl:text>\theoremstyle{definition}%&#xa;</xsl:text>
    <xsl:text>\newtheorem{definition}[theorem]{Definition}%&#xa;</xsl:text>
    <xsl:text>\newtheorem{informaldefinition}[theorem]{Informal definition}%&#xa;</xsl:text>
    <xsl:text>\newtheorem{construction}[theorem]{Construction}%&#xa;</xsl:text>
    <xsl:text>\newtheorem{notation}[theorem]{Notation}%&#xa;</xsl:text>
    <xsl:text>\newtheorem{todo}[theorem]{Todo}%&#xa;</xsl:text>
    <xsl:text>\newtheorem{explication}[theorem]{Explication}%&#xa;</xsl:text>
    <xsl:text>\newtheorem{proposition}[theorem]{Proposition}%&#xa;</xsl:text>
    <xsl:text>\newtheorem{attitude}[theorem]{Attitude}%&#xa;</xsl:text>
    <xsl:text>\newtheorem{interpretation}[theorem]{Interpretation}%&#xa;</xsl:text>
    <xsl:text>\newtheorem{example}[theorem]{Example}%&#xa;</xsl:text>
    <xsl:text>\newtheorem{remark}[theorem]{Remark}%&#xa;</xsl:text>
    <xsl:text>\newtheorem{convention}[theorem]{Convention}%&#xa;</xsl:text>
    <xsl:text>\newtheorem{aside}[theorem]{Aside}%&#xa;</xsl:text>
    <xsl:text>\newtheorem{ruleee}[theorem]{Rule}%&#xa;</xsl:text>
    <xsl:text>\newtheorem{exercise}{Exercise}%&#xa;</xsl:text>
    <xsl:text>\newtheorem{acknowledgements}{Acknowledgements}%&#xa;</xsl:text>
    <xsl:text>\newtheorem{definitionexample}[theorem]{Definition-Example}%&#xa;</xsl:text>
    <xsl:text>\newtheorem{constructionexample}[theorem]{Construction-Example}%&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Definition']">
    <xsl:text>definition</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Theorem']">
    <xsl:text>theorem</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Lemma']">
    <xsl:text>lemma</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Construction']">
    <xsl:text>construction</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Notation']">
    <xsl:text>notation</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Todo']">
    <xsl:text>todo</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Explication']">
    <xsl:text>explication</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Proposition']">
    <xsl:text>proposition</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Attitude']">
    <xsl:text>attitude</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Interpretation']">
    <xsl:text>interpretation</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Observation']">
    <xsl:text>observation</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Convention']">
    <xsl:text>convention</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Aside']">
    <xsl:text>aside</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Rule']">
    <xsl:text>ruleee</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Corollary']">
    <xsl:text>corollary</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Axiom']">
    <xsl:text>axiom</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Example']">
    <xsl:text>example</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Remark']">
    <xsl:text>remark</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Exercise']">
    <xsl:text>exercise</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Informal definition']">
    <xsl:text>informaldefinition</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Definition-example']">
    <xsl:text>definitionexample</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Construction-example']">
    <xsl:text>constructionexample</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Diagram']">
    <xsl:text>diagram</xsl:text>
  </xsl:template>

  <xsl:template match="f:taxon[text()='Acknowledgements']">
    <xsl:text>acknowledgements</xsl:text>
  </xsl:template>

  <xsl:template match="f:tree[f:frontmatter/f:taxon[text()='Proof']]">
    <xsl:text>\begin{proof}</xsl:text>
    <xsl:apply-templates select="f:mainmatter" />
    <xsl:text>\end{proof}</xsl:text>
  </xsl:template>

  <xsl:template match="f:tree[f:frontmatter/f:taxon[text()='table']]">
    <xsl:text>\begin{table}[h!]&#xa;</xsl:text>
    <xsl:text>\centering&#xa;</xsl:text>
    <xsl:apply-templates select="f:mainmatter" />
    <xsl:text>\caption{</xsl:text>
    <xsl:apply-templates select="f:frontmatter/f:title" />
    <xsl:text>}&#xa;</xsl:text>
    <xsl:apply-templates select="f:frontmatter/f:display-uri" mode="label" />
    <xsl:text>\end{table}</xsl:text>
  </xsl:template>

  <xsl:template match="f:tree[f:frontmatter/f:taxon[text()='figure']]">
    <xsl:text>\begin{figure}[H]</xsl:text>
    <xsl:apply-templates select="f:mainmatter" />
    <xsl:text>\caption{</xsl:text>
    <xsl:apply-templates select="f:frontmatter/f:title" />
    <xsl:text>}</xsl:text>
    <xsl:apply-templates select="f:frontmatter/f:display-uri" mode="label" />
    <xsl:text>\end{figure}</xsl:text>
  </xsl:template>

  <xsl:template match="f:tree[f:frontmatter/f:taxon[text()='diagram']]">
    <xsl:text>\begin{center}</xsl:text>
    <xsl:apply-templates select=".//f:resource-source[@type='latex' and @part='body']"/>
    <xsl:text>\end{center}</xsl:text>
  </xsl:template>

  <xsl:template match="f:tree[f:frontmatter/f:taxon[not(text()='Diagram' or text()='Section' or text()='Figure' or text()='Table' or text()='Proof')]]">
    <xsl:text>&#xa;\begin{</xsl:text>
    <xsl:apply-templates select="f:frontmatter/f:taxon" />
    <xsl:text>}</xsl:text>
    <xsl:if test="normalize-space(f:frontmatter/f:title)">
        <xsl:text>[{</xsl:text>
        <xsl:apply-templates select="f:frontmatter/f:title" />
        <xsl:text>}]</xsl:text>
    </xsl:if>
    <xsl:apply-templates select="f:frontmatter/f:display-uri" mode="label" />
    <xsl:text>&#xa;</xsl:text>
    <xsl:apply-templates select="f:mainmatter" />
    <xsl:text>\end{</xsl:text>
    <xsl:apply-templates select="f:frontmatter/f:taxon" />
    <xsl:text>}&#xa;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
