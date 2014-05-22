xsl.clj-ext
===========

XSLT extension functions to evaluate Clojure code

## Status

Currently proof-of-concept; not even close to production quality.  But
it works for the provided example, and it's extremely simple once you
know how to write an XSL extension in Java.

## Usage

Clone it, then:

```
$ lein deps
$ lein do clean, javac
$ ./saxon.sh
```

That's it.  Now open the output (`target/saxon-test.html`) in a browser,
and look at `src/xml/test.xml` and `src/xsl/saxon-test.xsl` to see
where the results came from.

## How it works

The basic idea is simple: write an XSL extension function that takes a
Clojure s-expression and sends it (via `clojure.java.api.Clojure`) to
the Clojure runtime for evaluation.  See the code in
`src/java/org/mobileink/xsl/saxon`, which is a few dozen lines of
Java.

Now you can put Clojure code in an XML file (the example uses
`<clj:code>`, but you can make up your own schema) and write an XSL
file to grab it and evaluate it; e.g.

```
<xsl:template match="clj:code">
  <xsl:variable name="code">
    <xsl:apply-templates/>
  </xsl:variable>
  <xsl:value-of select="cljsax:eval($code)"/>
</xsl:template>
```

Pay attention to the namespaces in `saxon-test.xsl`.  The URI and
local prefix for the extention function are hardcoded in
`SaxClj.java`, so you have to get it right.

## Unit Testing

One possible use for this is to create unit testing along the lines of
[Concordion](http://concordion.org/).  What's needed is an XML schema
and stylesheet.  XSL parameters could be used to select tests to run.

## Roadmap

### Required

* Testing - currently only a few types of Clojure expressions have been run through it.
* Xalan support
* Implement extension tag as well as function
* Robust error-checking
* Deploy to clojars

### Nice-to-have

* XML scheme for unit testing
* Stylesheets
  * Unit testing
  * API documentation by cases

