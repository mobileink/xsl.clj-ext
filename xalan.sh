#!/bin/sh

java -cp "/usr/local/java/xalan-j_2_7_1/*:./target/classes" \
    org.apache.xalan.xslt.Process \
    -in src/xml/exegesis.xml \
    -xsl src/xslt/exegesis.xalan.xsl \
    -out target/exegesis.xalan.html;
