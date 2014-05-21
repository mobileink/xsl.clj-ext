#!/bin/sh

# in your .bash_profile:
# export CLJ_JAR=path/to/clojure.jar
# export XSLT_JAR=path/to/clojure.jar
# explort MAVEN=~/.m2

java -cp $XSLT_JAR:$CLJ_JAR:$MAVEN/repository/org/clojure/tools.reader/0.8.4/tools.reader-0.8.4.jar:`pwd`/target/classes \
    net.sf.saxon.Transform \
    -init:org.mobileink.xsl.saxon.SaxInit \
    -s:src/xml/test.xml \
    -xsl:src/xsl/saxon-test.xsl \
    -o:target/saxon-test.html;

    # -init:com.mobileink.saxon.$@ \
    # -xsl:src/xslt/exegesis.saxon.xsl \
