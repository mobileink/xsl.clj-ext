<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:clj="http://mobileink.org/schema/xml/clj"
		xmlns:cljsax="http://mobileink.org/xsl/clj/saxon"
                version='2.0'>
		<!-- xmlns:clj="http://clojure.org" -->

  <xsl:output method="html"
              encoding="utf-8"
              indent="no"/>

  <!-- <xsl:include href="stuff.xsl"/> -->

  <!-- <xsl:param name="foo" select="'bar'"/> -->

  <xsl:template match="*">
    <xsl:message>
      <xsl:text>No template matches </xsl:text>
      <xsl:value-of select="name(.)"/>
      <xsl:if test="parent::*">
	<xsl:text> in </xsl:text>
	<xsl:value-of select="name(parent::*)"/>
      </xsl:if>
      <xsl:text>.</xsl:text>
    </xsl:message>

    <font color="red">
      <xsl:text>&lt;</xsl:text>
      <xsl:value-of select="name(.)"/>
      <xsl:text>&gt;</xsl:text>
      <xsl:apply-templates/>
      <xsl:text>&lt;/</xsl:text>
      <xsl:value-of select="name(.)"/>
      <xsl:text>&gt;</xsl:text>
    </font>
  </xsl:template>

  <xsl:template match="/">
    <html>
      <head>
	<style type="text/css">
	  section {margin:1em;}
	  span.code {border:thin solid black;
	  padding-top:2px;
	  padding-bottom:9px;
	  padding-left:4px;
	  padding-right:4px;
	  margin-top:4px;
	  margin-bottom:4px;
	  margin-left:4pt;
	  margin-right:2pt;
	  background-color:#CCFFFF!important;}
	  span.form {padding-top:2px;padding-bottom:8px;background-color:#66FFFF;}
	  span.result {padding-top:2px;padding-bottom:8px;background-color:#99FFCC;}
	  tt {background-color:#F0F0F0;}
	  pre {background-color:gray;}
	  div {margin-top:8px;margin-bottom:8px;}
	</style>
      </head>
      <body>
	<xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="exegesis">
    <main>
      <h1>Lookity!  Live Documentation! (Saxon version)</h1>
      <xsl:apply-templates/>
    </main>
  </xsl:template>

  <xsl:template match="introduction">
    <section>
      <header>Introduction</header>
      <xsl:apply-templates/>
    </section>
  </xsl:template>

  <xsl:template match="doc">
    <div class="doc">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="pre">
    <pre>
      <xsl:apply-templates/>
    </pre>
  </xsl:template>

  <xsl:template match="br">
    <br/>
  </xsl:template>

  <xsl:template match="i">
    <i>
      <xsl:apply-templates/>
    </i>
  </xsl:template>

  <xsl:template match="p">
    <div>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="clj:code">
    <span class="code">
      <span class="form">
	<xsl:apply-templates/>
      </span>
      <xsl:text> ;; -> </xsl:text>
      <xsl:variable name="code">
	<xsl:apply-templates/>
      </xsl:variable>
      <!-- <xsl:variable name="i"> -->
      <!-- 	<xsl:value-of select="concat('(* 3 ', $n, ')')"/> -->
      <!-- </xsl:variable> -->
      <span class="result">
	<xsl:choose>
	  <xsl:when test="@eval='no'"/>
	  <xsl:otherwise>
	    <xsl:value-of select="cljsax:eval($code)"/>
	  </xsl:otherwise>
	</xsl:choose>
      </span>
    </span>
  </xsl:template>

  <xsl:template match="fn-body">
    <xsl:variable name="sq">
      <xsl:text>"hi!"</xsl:text>
    </xsl:variable>
    <xsl:variable name="sexp">
      <xsl:text>(doseq [x [1 2 3]] prn x)</xsl:text>
    </xsl:variable>
    <pre>
      <xsl:value-of select="cljsax:eval('(doseq [x [11 22 33]] (prn x))')"/>
      <xsl:variable name="res" select="cljsax:eval('(let [[x y] [0 1]] (list x y))')"/>
      <xsl:text>
(let [[x y] [0 1]] (list x y))
  ;; -></xsl:text>
 <xsl:value-of select="$res"/>
    </pre>
  </xsl:template>

  <xsl:template match="xref">
    <xsl:element name="a">
      <xsl:attribute name="href">
	<xsl:value-of select="@href"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="codeph">
    <tt class="codeph">
      <xsl:apply-templates/>
    </tt>
  </xsl:template>

</xsl:stylesheet>
