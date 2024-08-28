/*------------------------------------------------------------------------------
 *******************************************************************************
 * COPYRIGHT Ericsson 2012
 *
 * The copyright to the computer program(s) herein is the property of
 * Ericsson Inc. The programs may be used and/or copied only with written
 * permission from Ericsson Inc. or in accordance with the terms and
 * conditions stipulated in the agreement/contract under which the
 * program(s) have been supplied.
 *******************************************************************************
 *----------------------------------------------------------------------------*/
package com.ericsson.oss.mediation.netconf.config.listener;

import java.io.*;
import java.util.concurrent.*;

import javax.xml.bind.annotation.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ericsson.oss.mediation.netconf.TerribleButExpectedException;
import com.ericsson.oss.mediation.netconf.config.XmlAddToContext;
import com.ericsson.oss.mediation.netconf.parser.operation.RpcReplyFormat;
import com.ericsson.oss.mediation.netconf.server.api.Filter;

@XmlRootElement(name = "TestCreateSubscriptionError")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlAddToContext
public class TestCreateSubscriptionError extends DefaultCommandListener {

    @XmlAttribute
    private String nodeName;

    private String filename;

    public TestCreateSubscriptionError() {

    }

    public TestCreateSubscriptionError(final String nodeName) {
        this.nodeName = nodeName;
        this.filename = "/" + nodeName + ".xml";
    }

    private static Logger logger = LoggerFactory
            .getLogger(TestRadioSubscribeSyncAndNotificationsWithFailures.class);

    @Override
    public void get(final String messageId, final Filter filter,
            final PrintWriter out) {
        if (filter != null && filter.asString() != null
                && filter.asString().contains("streams")) {
            out.print("<rpc-reply message-id=\"");
            out.print(messageId);
            out.println("\" xmlns=\"urn:ietf:params:xml:ns:netconf:base:1.0\">");
            out.println("\t<data>");
            out.println("\t\t<netconf xmlns=\"urn:ietf:params:xml:ns:netmod:notification\">");
            out.println("\t\t\t<streams>");
            out.println("\t\t\t\t<stream>");
            out.println("\t\t\t\t\t<name>NETCONF</name>");
            out.println("\t\t\t\t\t<description>default NETCONF event stream</description>");
            out.println("\t\t\t\t\t<replaySupport>true</replaySupport>");
            out.println("\t\t\t\t\t<replayLogCreationTime>2015-07-08T00:00:00Z</replayLogCreationTime>");
            out.println("\t\t\t\t\t<replayLogAgedTime>2015-07-02T00:00:00Z</replayLogAgedTime>");
            out.println("\t\t\t\t</stream>");
            out.println("\t\t\t</streams>");
            out.println("\t\t</netconf>");
            out.println("\t</data>");
            out.println("</rpc-reply>");
            out.println("]]>]]>");
        } else {
            this.filename = "/" + nodeName + ".xml";
            logger.error(
                    "    ################################## GET con filename = {}",
                    filename);
            out.print(RpcReplyFormat.XML_START);
            out.print("<rpc-reply message-id=\"");
            out.print(messageId);
            out.println("\"");
            out.println("\txmlns=\"urn:ietf:params:xml:ns:netconf:base:1.0\">");
            try {
                printFile(out, filename);
            } catch (final IOException e) {
                logger.error(
                        "I wasn't able to load and send back content of {} file",
                        filename);
                logger.error(
                        "    ################################## ERROR GET con filename = {}",
                        filename);
                throw new TerribleButExpectedException();
            }
            out.println("</rpc-reply>");
            logger.error(" LINE : </rpc-reply>");
            out.println("]]>]]>");
            logger.error(" LINE : ]]>]]>");
            logger.error("    ################################## END GET: END OK!!");
        }
    }

    private void printFile(final PrintWriter out, final String filename)
            throws IOException {
        try (final BufferedReader reader = new BufferedReader(
                new InputStreamReader(getClass().getResourceAsStream(filename)))) {
            String line;
            while ((line = reader.readLine()) != null) {
                out.println(line);
            }
        }
    }

    @Override
    public Callable<Boolean> createSubscription(final String messageId,
            final String stream, final Filter filter, final String startTime,
            final String stopTime, final PrintWriter out) {
        Callable<Boolean> result = null;
        logger.info("createSubscription called");

        logger.info("createSubscription: RPC_ERROR_CREATE_SUBSCRIPTION_FAILED sent");
        out.print(String.format(
                RpcReplyFormat.RPC_ERROR_CREATE_SUBSCRIPTION_FAILED, messageId));
        out.println("]]>]]>");

        return result;
    }

}
