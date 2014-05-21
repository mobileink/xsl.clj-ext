package org.mobileink.xsl.saxon;

import java.io.*;
import java.util.Stack;
import java.util.StringTokenizer;
import javax.xml.transform.TransformerException;
import org.xml.sax.*;
import org.w3c.dom.*;

import clojure.java.api.Clojure;
import clojure.lang.IFn;

import net.sf.saxon.lib.ExtensionFunctionDefinition;
import net.sf.saxon.lib.ExtensionFunctionCall;
import net.sf.saxon.om.Item;
import net.sf.saxon.om.Sequence;
import net.sf.saxon.om.StructuredQName;
import net.sf.saxon.value.*;
import net.sf.saxon.value.Int64Value;
import net.sf.saxon.value.SequenceType;
import net.sf.saxon.expr.XPathContext;
import net.sf.saxon.trans.XPathException;
import net.sf.saxon.s9api.*;
// import net.sf.saxon.TransformerFactoryImpl;

/**
 * <p>Saxon9HE extension for code exegesis.</p>
 *
 * <p>Copyright (C) 2014 G. Reynolds.</p>
 *
 * @author Gregg Reynolds
 *
 */

public class SaxClj extends ExtensionFunctionDefinition {
    private static final IFn EVAL = Clojure.var("clojure.core", "eval");
    private static final IFn REQUIRE = Clojure.var("clojure.core", "require");
    private static final ByteArrayOutputStream newOut = new ByteArrayOutputStream();
    private static final ByteArrayOutputStream newErr = new ByteArrayOutputStream();
    private static final PrintStream oldOut = System.out;
    private static final PrintStream oldErr = System.err;
    // System.setOut(new PrintStream(baos));
    static {
 	REQUIRE.invoke(Clojure.read("clojure.test"));
 	REQUIRE.invoke(Clojure.read("clojure.tools.reader"));
    }

    private static final IFn READSTR = Clojure.var("clojure.tools.reader", "read-string");

    @Override public StructuredQName getFunctionQName() {
	return new StructuredQName("mi", "http://mobileink.org/saxon", "clj");
    }

    @Override public SequenceType[] getArgumentTypes() {
	return new SequenceType[] {SequenceType.SINGLE_STRING};
    }

    @Override public SequenceType getResultType(SequenceType[] suppliedArgumentTypes) {
	return SequenceType.SINGLE_STRING; }

    @Override public ExtensionFunctionCall makeCallExpression() { return new ExtensionFunctionCall()
	{
	    public Sequence call(XPathContext context, Sequence[] arguments) throws XPathException {

		String input = arguments[0].head().getStringValue();
		System.out.println("input: " + input);

		Object expanded = READSTR.invoke(input);
		System.out.println("expanded: " + expanded.toString());

		System.setOut(new PrintStream(newOut));
		System.setErr(new PrintStream(newErr));
		Object o = EVAL.invoke(Clojure.read(expanded.toString()));
		System.out.flush();
		System.err.flush();
		System.setOut(oldOut);
		System.setErr(oldErr);

		String s;
		if (o != null) {
		    s = o.toString();
		} else {
		    s= "ok";
		}
		s = s + "\n[[stdout:\n" + newOut.toString() + "]]\n[[stderr:\n" + newErr.toString() + "]]";
		newOut.reset();
		newErr.reset();

		System.out.println("result: " + s.toString());
		return StringValue.makeStringValue(s);
	    }
	};
    }
}
