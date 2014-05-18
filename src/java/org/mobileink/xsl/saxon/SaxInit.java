package org.mobileink.xsl.saxon;

import javax.xml.transform.TransformerException;
import net.sf.saxon.Configuration;
import net.sf.saxon.lib.Initializer;

public class SaxInit implements Initializer {

    public void initialize (Configuration config)
	throws TransformerException {
	config.registerExtensionFunction(new SaxClj());
	// config.registerExtensionFunction(new Exegete());
    }
}
