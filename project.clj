(defproject org.mobileink.xsl/clj "0.1.0-SNAPSHOT"
  :description "XSL extension functions to eval Clojure code"
  :url "https://github.com/mobileink/xsl.clj-ext"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :source-paths ["src/clojure"]
  :java-source-paths ["src/java"]
  :target-path "target/%s"
  :dependencies [[org.clojure/clojure "1.6.0"]
                 [org.clojure/tools.reader "0.8.4"]
                 [net.sf.saxon/Saxon-HE "9.5.1-5"]
                 [xalan/xalan "2.7.1"]])
