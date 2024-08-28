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
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ericsson.oss.mediation.netconf.config.XmlAddToContext;
import com.ericsson.oss.mediation.netconf.TerribleButExpectedException;
import com.ericsson.oss.mediation.netconf.parser.operation.RpcReplyFormat;

import com.ericsson.oss.mediation.netconf.server.api.Filter;

/**
 * Listener used to simulate the notifications and test the heartbeat based on createSubscription
 * 
 * At the moment always the same notification will be sent using the specified timing.
 * 
 * @author ebialan
 * 
 */
@XmlRootElement(name = "TestRegressionOnNotifications")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlAddToContext
public class TestRegressionOnNotifications extends DefaultCommandListener {

    @XmlAttribute
    private String nodeName;
    
    @XmlAttribute
    private String notificationFileName;
    
    private String filename;

    private boolean secondTime;
    
    public TestRegressionOnNotifications() {
        secondTime = false;
    }

    public TestRegressionOnNotifications(final String nodeName) {
        this.nodeName = nodeName;
        this.filename = "/"+nodeName+".xml";
    }

    private static Logger logger = LoggerFactory.getLogger(TestRegressionOnNotifications.class);
    protected static ThreadLocal<Boolean> isSubscriptionCreated = new ThreadLocal<Boolean>() {
        @Override
        protected Boolean initialValue() {
          return new Boolean(false);
        }
    };

    private int sessionId;

    @Override
    public void get(final String messageId, final Filter filter, final PrintWriter out) {
      if (filter != null && filter.asString() != null && filter.asString().contains("streams")) {
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
        out.println("\t\t\t\t\t<replayLogAgedTime>2015-07-03T00:00:00Z</replayLogAgedTime>");
        out.println("\t\t\t\t</stream>");
        out.println("\t\t\t</streams>");
        out.println("\t\t</netconf>");
        out.println("\t</data>");
        out.println("</rpc-reply>");
        out.println("]]>]]>");
      } else {
        //super.get(messageId, filter, out);
            this.filename = "/"+nodeName+".xml";
            out.print(RpcReplyFormat.XML_START);
            out.print("<rpc-reply message-id=\"");
            out.print(messageId);
            out.println("\"");
            out.println("\txmlns=\"urn:ietf:params:xml:ns:netconf:base:1.0\">");
            try {
                printFile(out, filename);
            } catch (IOException e) {
                logger.error("I wasn't able to load and send back content of {} file", filename);
                throw new TerribleButExpectedException();
            }
            out.println("</rpc-reply>");
            logger.error(" LINE : </rpc-reply>");
            out.println("]]>]]>");
            logger.error(" LINE : ]]>]]>");
            if (secondTime) 
            {
                try {
                  Thread.sleep(60000);
                } catch (final InterruptedException e) {
            logger.warn("Sleep Interrupted!!!");
            Thread.currentThread().interrupt();
                }
            } else {
              secondTime = true;
            }
      }
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

    @Override
    public Callable<Boolean> createSubscription(final String messageId, final String stream, final Filter filter,
        final String startTime, final String stopTime, final PrintWriter out) {
    if (isSubscriptionCreated.get()) {
        super.sendError(messageId, String.format(RpcReplyFormat.RPC_ERROR_CREATE_SUBSCRIPTION_FAILED, messageId),
            out);
    } else {
        out.print(String.format(RpcReplyFormat.RPC_OK, messageId));
        out.println("]]>]]>");
        if (notificationFileName != null && !notificationFileName.equals("")) {
            final Callable<Boolean> result = new NotificationSender(0, 180000, out, "/"+notificationFileName);
            // final Future<Boolean> result = startNotificationSender(0, 0, out);
            isSubscriptionCreated.set(true);
            return result;
        } else {
            logger.error("notificationFileName is null");
            Thread.currentThread().interrupt();
            return null;
        }
    }
    return null;
    }

    protected Future<Boolean> startNotificationSender(final long timeout, final long notificationInterval,
        final PrintWriter out) {
    logger.info("Starting Notification Sender");
    final ExecutorService executor = Executors.newSingleThreadExecutor();
    final Future<Boolean> future = executor.submit(new NotificationSender(executor, timeout, notificationInterval,
        out, "/"+notificationFileName));
    return future;
    }

    protected class NotificationSender implements Callable<Boolean> {
    final ExecutorService executor;
    final long timeout;
    final long notificationInterval;
    final PrintWriter out;
    final String notificationsInputFile;

    /**
     * @param timeout
     * @param notificationInterval
     * @param out
     */
    public NotificationSender(final long timeout, final long notificationInterval, 
        final PrintWriter out, final String notificationsInputFile) {
        super();
        this.executor = null;
        this.timeout = timeout;
        this.notificationInterval = notificationInterval;
        this.out = out;
        this.notificationsInputFile = notificationsInputFile;
    }

    /**
     * @param executor
     * @param timeout
     * @param notificationInterval
     * @param out
     */
    public NotificationSender(final ExecutorService executor,
        final long timeout,
        final long notificationInterval,
        final PrintWriter out,
        final String notificationsInputFile) {
        super();
        this.executor = executor;
        this.timeout = timeout;
        this.notificationInterval = notificationInterval;
        this.out = out;
        this.notificationsInputFile = notificationsInputFile;
    }

    @Override
    public Boolean call() throws IOException {
        logger.error("~~~~~~~~~~~~~~~~~~~~~~~~ Starting Notification Sender ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        try {
            Thread.sleep(notificationInterval > 0 ? notificationInterval : 30000);
            //Thread.sleep(notificationInterval > 0 ? notificationInterval : 120000);
            logger.debug("SessionId {}> Sending Notification ...", sessionId);
            try (final BufferedReader reader = new BufferedReader(
                    new InputStreamReader(getClass().getResourceAsStream(
                            notificationsInputFile)))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    if (line.equals("<SINGLE>") ) {
                        String singleotification = "";
                        line = reader.readLine();
                        while (! line.equals("</SINGLE>")) {
                            if (!line.startsWith("<!--", 0)) {
                                singleotification = singleotification+line; 
                            }
                            line = reader.readLine();
                        }
                        sendSingleNotification(singleotification, out);
                    } else if (line.equals("<MULTIPLE>") ) {
                        String multipleNotification = "";
                        line = reader.readLine();
                        while (! line.equals("</MULTIPLE>")) {
                            if (!line.startsWith("<!--", 0)) {
                                multipleNotification = multipleNotification+line; 
                            }
                            line = reader.readLine();
                        }
                        sendMultipleNotifications(multipleNotification, out);
                    } else {
                        logger.error("unrecognized tag {}", line);
                    }
                }
            }
        } catch (final InterruptedException e) {
            logger.warn("SessionId {}> Notification Sender Sleep Interrupted!!!", sessionId);
            Thread.currentThread().interrupt();
        }
        return true; 
    }

    }

    protected void sendMultipleNotifications(final String notificationType, final PrintWriter out) {
    out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
    out.println("<notification xmlns=\"urn:ietf:params:xml:ns:netconf:notification:1.0\">");
    out.println("<eventTime>2011-11-24T15:52:46Z</eventTime>");
    out.println("<events xmlns=\"urn:ericsson:com:netconf:notification:1.0\">");
    out.println(notificationType);
    out.println("</events>");
    out.println("</notification>");
    out.println("]]>]]>");
    }

    protected void sendSingleNotification(final String notificationType, final PrintWriter out) {
    out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
    out.println("<notification xmlns=\"urn:ietf:params:xml:ns:netconf:notification:1.0\">");
    out.println(notificationType);
    out.println("</notification>");
    out.println("]]>]]>");
    }

}
