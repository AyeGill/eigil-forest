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
    <xsl:text>\documentclass[oneside,a4paper]{article}%&#xa;</xsl:text>
    <xsl:text>\usepackage[final]{microtype}%&#xa;</xsl:text>
    <xsl:text>\usepackage{amsthm,mathtools}%&#xa;</xsl:text>
    <xsl:text>\usepackage{xcolor}%&#xa;</xsl:text>
    <xsl:text>\usepackage{tikzit}%&#xa;</xsl:text>
    <xsl:text>\usepackage{float}%&#xa;</xsl:text>
    <xsl:text>\usepackage[export]{adjustbox}%&#xa;</xsl:text>
    <xsl:text>\usepackage{tikz, tikz-cd, mathtools, amssymb, stmaryrd}</xsl:text>
    <!-- <xsl:text>\usepackage{tangle}</xsl:text> -->
    <xsl:text>\usetikzlibrary{calc}&#xa;</xsl:text>
    <xsl:text>\usetikzlibrary{decorations.pathmorphing}&#xa;</xsl:text>
    <xsl:text>\usetikzlibrary{spath3}&#xa;</xsl:text>
    <xsl:text>\usepackage{tikzit}&#xa;</xsl:text>
    <xsl:text>\usetikzlibrary{backgrounds}&#xa;</xsl:text>
    <xsl:text>\usetikzlibrary{arrows}&#xa;</xsl:text>
    <xsl:text>\usetikzlibrary{shapes,shapes.geometric,shapes.misc}&#xa;</xsl:text>
    <xsl:text>\usepackage{circuitikz}&#xa;</xsl:text>
    <xsl:text>
\tikzset{curve/.style={settings={#1},to path={(\tikztostart)
    .. controls ($(\tikztostart)!\pv{pos}!(\tikztotarget)!\pv{height}!270:(\tikztotarget)$)
    and ($(\tikztostart)!1-\pv{pos}!(\tikztotarget)!\pv{height}!270:(\tikztotarget)$)
    .. (\tikztotarget)\tikztonodes}},
    settings/.code={\tikzset{quiver/.cd,#1}
        \def\pv##1{\pgfkeysvalueof{/tikz/quiver/##1}}},
    quiver/.cd,pos/.initial=0.35,height/.initial=0}
\tikzset{between/.style n args={2}{/tikz/spath/at end path construction={
    \tikzset{spath/split at keep middle={current}{#1}{#2}}
}}}

% TikZ arrowhead/tail styles.
\tikzset{tail reversed/.code={\pgfsetarrowsstart{tikzcd to}}}
\tikzset{2tail/.code={\pgfsetarrowsstart{Implies[reversed]}}}
\tikzset{2tail reversed/.code={\pgfsetarrowsstart{Implies}}}
% TikZ arrow styles.
\tikzset{no body/.style={/tikz/dash pattern=on 0 off 1mm}}
    </xsl:text>
    <xsl:text>\usepackage{mathpartir}&#xa;</xsl:text>
    <xsl:call-template name="environments" />
    <xsl:text>\usepackage[colorlinks=true,linkcolor={blue!30!black}]{hyperref}%&#xa;</xsl:text>
    <xsl:text>\usepackage{newpxmath,newpxtext}%&#xa;</xsl:text>
    <xsl:text>\usepackage{cleveref}%&#xa;</xsl:text>
    <xsl:text>\usepackage[mode=buildmissing]{standalone}%&#xa;</xsl:text>
    <xsl:text>\setcounter{tocdepth}{5}%&#xa;</xsl:text>
    <xsl:text>\setcounter{secnumdepth}{5}%&#xa;</xsl:text>
    <xsl:text>
\lineskip 1pt
\normallineskip 1pt
\def\baselinestretch{1}
\marginparsep 10pt
\topmargin 0pt
\headheight 12pt
\headsep 15pt
\topskip = 0pt
\footskip 20pt
\textheight = 8.5in
\textwidth 6.3in
\oddsidemargin0pt
\evensidemargin0pt
    </xsl:text>

    <xsl:apply-templates select="/f:tree/f:frontmatter" mode="top" />

    <xsl:text>\begin{document}</xsl:text>

    <!-- <xsl:for-each select="//f:resource[not(ancestor::f:backmatter)]"> -->
    <!--   <xsl:text>&#xa;</xsl:text> -->
    <!--   <xsl:text>\begin{filecontents*}[overwrite]{</xsl:text> -->
    <!--   <xsl:value-of select="@hash" /> -->
    <!--   <xsl:text>.tex}</xsl:text> -->
    <!--   <xsl:text>&#xa;</xsl:text> -->
    <!--   <xsl:text>\documentclass[crop]{standalone}</xsl:text> -->
    <!--   <xsl:text>&#xa;</xsl:text> -->
    <!--   <xsl:value-of select="f:resource-source[@part='preamble']" /> -->
    <!--   <xsl:text>\usepackage{newtxmath,newtxtext}</xsl:text> -->
    <!--   <xsl:text>&#xa;</xsl:text> -->
    <!--   <xsl:text>\begin{document}</xsl:text> -->
    <!--   <xsl:value-of select="f:resource-source[@part='body']" /> -->
    <!--   <xsl:text>\end{document}</xsl:text> -->
    <!--   <xsl:text>&#xa;</xsl:text> -->
    <!--   <xsl:text>\end{filecontents*}</xsl:text> -->
    <!--   <xsl:text>&#xa;</xsl:text> -->
    <!-- </xsl:for-each> -->

    <xsl:text>&#xa;</xsl:text>
    <xsl:text>\begin{filecontents*}[overwrite]{\jobname.bib}</xsl:text>
    <xsl:text>&#xa;</xsl:text>
    <xsl:apply-templates select="/f:tree/f:backmatter//f:tree/f:frontmatter[f:taxon[text()='Reference']]/f:meta[@name='bibtex']" />
    <xsl:text>&#xa;</xsl:text>
    <xsl:text>\end{filecontents*}</xsl:text>
    <xsl:text>&#xa;</xsl:text>

    <xsl:text>\maketitle</xsl:text>
    \tableofcontents
    <xsl:apply-templates select="/f:tree/f:mainmatter" />
    <xsl:text>\nocite{*}</xsl:text>
    <xsl:text>\bibliographystyle{plain}</xsl:text>
    <xsl:text>\bibliography{\jobname.bib}</xsl:text>
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
   <xsl:text>\label{</xsl:text>
    <xsl:apply-templates />
   <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="f:tree[not(f:frontmatter/f:taxon) or f:frontmatter/f:taxon = 'section']">
    <xsl:apply-templates select="f:frontmatter/f:title" />
    <xsl:apply-templates select="f:frontmatter/f:display-uri" mode="label" />
    <xsl:apply-templates select="f:mainmatter" />
  </xsl:template>

  <xsl:template match="f:mainmatter">
    <xsl:apply-templates select="html:p|f:tex|html:ol|html:ul|html:pre|f:tree|f:resource|html:figure|html:table" />
  </xsl:template>

</xsl:stylesheet>
