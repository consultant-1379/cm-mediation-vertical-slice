package com.ericsson.oss.mediation.netconf.config.listener.er6672;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ericsson.oss.mediation.netconf.config.XmlAddToContext;
import com.ericsson.oss.mediation.netconf.config.listener.DefaultCommandListener;
import com.ericsson.oss.mediation.netconf.server.api.*;
import com.ericsson.oss.mediation.netconf.TerribleButExpectedException;

@XmlRootElement(name = "ER6672Node")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlAddToContext
public class ER6672Node extends DefaultCommandListener {

    private static final Logger logger = LoggerFactory.getLogger(ER6672Node.class);

    @XmlAttribute
    private final String filename;

    public ER6672Node() {
	    this.filename = "/er6672.xml";
    }

    public ER6672Node(final String filename) {
	this.filename = filename;
    }

    @Override
    public void hello(final int sessionId, final PrintWriter out) {

        out.println("<hello xmlns=\"urn:ietf:params:xml:ns:netconf:base:1.0\">");
        out.println("\t<capabilities>");

        out.println(getCapabilityTree(RFC4741.BASE.urn));
        out.println(getCapabilityTree("urn:ietf:params:netconf:base:1.0"));
        out.println(getCapabilityTree("urn:com:ericsson:ebase:0.1.0"));
        out.println(getCapabilityTree("urn:com:ericsson:ebase:1.1.0"));
        out.println(getCapabilityTree("urn:com:ericsson:ebase:1.2.0"));
        out.println(getCapabilityTree(RFC4741.WRITABLE_RUNNING.urn));
        out.println(getCapabilityTree("urn:ietf:params:netconf:capability:writable-running:1.0"));
        out.println(getCapabilityTree(RFC4741.ROLLBACK_ON_ERROR.urn));
        out.println(getCapabilityTree("urn:ietf:params:netconf:capability:rollback-on-error:1.0"));
        out.println(getCapabilityTree(RFC5277.NOTIFICATION.urn));
        out.println(getCapabilityTree("urn:ietf:params:netconf:capability:notification:1.0"));
        out.println(getCapabilityTree("urn:ericsson:com:netconf:action:1.0"));
        out.println(getCapabilityTree("urn:ericsson:com:netconf:heartbeat:1.0"));
        out.println(getCapabilityTree("urn:com:ericsson:netconf:operation:1.0"));
        out.println(getCapabilityTree(RFC4741.STARTUP.urn));
        out.println(getCapabilityTree("urn:ietf:params:netconf:capability:startup:1.0"));
        out.println(getCapabilityTree("urn:com:ericsson:ipos:exec-cli:1.0"));
        out.println(getCapabilityTree("urn:com:ericsson:ipos:invoke-cli:1.0"));

        out.println("\t</capabilities>");
        out.print("\t<session-id>");
        out.print(sessionId);
        out.println("</session-id>");
        out.println("</hello>");
        out.println("]]>]]>");
    }

    @Override
    public void get(final String messageId, final Filter filter, final PrintWriter out) {

        out.print("<rpc-reply ");
        out.println("\txmlns=\"urn:ietf:params:xml:ns:netconf:base:1.0\" ");
        out.print("message-id=\"");
        out.print(messageId);
        out.println("\">");

        try {
            printFile(out, this.filename);
        } catch (final IOException e) {
            logger.error("I wasn't able to load and send back content of {} file", this.filename);
            throw new TerribleButExpectedException();
        }

        out.println("</rpc-reply>");
        out.println("]]>]]>");
    }


    private void printFile(final PrintWriter out, final String filename) throws IOException {
        try (final BufferedReader reader = new BufferedReader(new InputStreamReader(getClass().getResourceAsStream(
                filename)))) {
            String line;
            while ((line = reader.readLine()) != null) {
                out.println(line);
            }
        }
    }
}
