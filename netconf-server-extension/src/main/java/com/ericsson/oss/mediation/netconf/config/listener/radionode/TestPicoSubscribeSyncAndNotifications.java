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

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Random;
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

//import com.ericsson.oss.mediation.util.netconf.api.Datastore;
//import com.ericsson.oss.mediation.util.netconf.api.Filter;
//import com.ericsson.oss.mediation.util.netconf.api.editconfig.DefaultOperation;
//import com.ericsson.oss.mediation.util.netconf.api.editconfig.ErrorOption;
//import com.ericsson.oss.mediation.util.netconf.api.editconfig.Operation;
//import com.ericsson.oss.mediation.util.netconf.api.editconfig.TestOption;

import com.ericsson.oss.mediation.netconf.server.api.Filter;
import com.ericsson.oss.mediation.netconf.server.api.Operation;
/**
 * Listener used to simulate the notifications and test the heartbeat based on createSubscription
 * 
 * At the moment always the same notification will be sent using the specified timing.
 * 
 * @author ebialan
 * 
 */
@XmlRootElement(name = "TestPicoSubscribeSyncAndNotifications")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlAddToContext
public class TestPicoSubscribeSyncAndNotifications extends DefaultCommandListener {

    @XmlAttribute
    private String nodeName;
    
    private String filename;

    private boolean secondTime;

    public TestPicoSubscribeSyncAndNotifications() {
        secondTime = false;
    }

    public TestPicoSubscribeSyncAndNotifications(final String nodeName) {
        this.nodeName = nodeName;
        this.filename = "/"+nodeName+".xml";
    }

    private static Logger logger = LoggerFactory.getLogger(TestPicoSubscribeSyncAndNotifications.class);
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
	    out.println("\t\t\t\t</stream>");
	    out.println("\t\t\t</streams>");
	    out.println("\t\t</netconf>");
	    out.println("\t</data>");
	    out.println("</rpc-reply>");
	    out.println("]]>]]>");
	  } else {
	    //super.get(messageId, filter, out);
		  	this.filename = "/"+nodeName+".xml";
            logger.info("    ################################## GET con filename = {}",filename);
            out.print(RpcReplyFormat.XML_START);
            out.print("<rpc-reply message-id=\"");
            out.print(messageId);
            out.println("\"");
            out.println("\txmlns=\"urn:ietf:params:xml:ns:netconf:base:1.0\">");
            try {
                printFile(out, filename);
            } catch (IOException e) {
                logger.error("I wasn't able to load and send back content of {} file", filename);
                logger.error("    ################################## ERROR GET con filename = {}",filename);
                throw new TerribleButExpectedException();
            }
            out.println("</rpc-reply>");
            logger.error(" LINE : </rpc-reply>");
            out.println("]]>]]>");
            logger.error(" LINE : ]]>]]>");
            logger.error("    ################################## END GET: END OK!!");
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
	    final Callable<Boolean> result = new NotificationSender(0, 0, out);
	    // final Future<Boolean> result = startNotificationSender(0, 0, out);
	    isSubscriptionCreated.set(true);
	    return result;
	}
	return null;
    }

    protected Future<Boolean> startNotificationSender(final long timeout, final long notificationInterval,
	    final PrintWriter out) {
	logger.info("Starting Notification Sender");
	final ExecutorService executor = Executors.newSingleThreadExecutor();
	final Future<Boolean> future = executor.submit(new NotificationSender(executor, timeout, notificationInterval,
		out));
	return future;
    }

    protected class NotificationSender implements Callable<Boolean> {
	final ExecutorService executor;
	final long timeout;
	final long notificationInterval;
	final PrintWriter out;

	/**
	 * @param timeout
	 * @param notificationInterval
	 * @param out
	 */
	public NotificationSender(final long timeout, final long notificationInterval, final PrintWriter out) {
	    super();
	    this.executor = null;
	    this.timeout = timeout;
	    this.notificationInterval = notificationInterval;
	    this.out = out;

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
		final PrintWriter out) {
	    super();
	    this.executor = executor;
	    this.timeout = timeout;
	    this.notificationInterval = notificationInterval;
	    this.out = out;
	}

	@Override
	public Boolean call() throws IOException {
	    logger.info("Starting Notification Sender");
	    try {
		//while (!Thread.currentThread().isInterrupted()) {
		    try {
			Thread.sleep(notificationInterval > 0 ? notificationInterval : 30000);
			logger.info("SessionId {}> Sending Notification ...", sessionId);
			sendSingleNotification(getNotificationType(Operation.MERGE,  "0", ""), out);
			Thread.sleep(notificationInterval > 0 ? notificationInterval : 30);
 			sendSingleNotification(getNotificationType(Operation.MERGE,  "1", ""), out);
                        sendMultipleNotifications(getNotificationType(Operation.CREATE, "2", ""), out);
			Thread.sleep(notificationInterval > 0 ? notificationInterval : 30);
                        sendSingleNotification(getNotificationType(Operation.REPLACE, "2", ""), out);
			//sendSingleNotification(getNotificationType(Operation.MERGE,   "0", ""), out);
			//sendSingleNotification(getNotificationType(Operation.REPLACE, "3", ""), out);
			//sendSingleNotification(getNotificationType(Operation.REPLACE, "4", ""), out);
			//sendSingleNotification(getNotificationType(Operation.REPLACE, "5", ""), out);
			//sendSingleNotification(getNotificationType(Operation.REPLACE, "6", ""), out);
			//sendSingleNotification(getNotificationType(Operation.MERGE,   "0", ""), out);
		    } catch (final InterruptedException e) {
			logger.warn("SessionId {}> Notification Sender Sleep Interrupted!!!", sessionId);
			Thread.currentThread().interrupt();
		    }
		//}
	    } catch (final Exception ex) {
		logger.warn("SessionId {}> Notification Sender Interrupted: {}.", sessionId, ex.getMessage());
	    } finally {
		if (!executor.isTerminated()) {
		    executor.shutdownNow();
		}
		logger.info("SessionId {}> Notification Sender terminated!!!", sessionId);
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

    protected String getNotificationType(final Operation operation, final String val, final String config) {
	// TODO: parse the config and build the dn
	String notificationType;
	switch (operation) {
                /*
                possible values: 
                     NOT_REQUESTED("not-requested"), 
                     MERGE("merge"), 
                     CREATE("create"), 
                     DELETE("delete"), 
                     REPLACE("replace"), 
                     REMOVE("remove");
                */
	case MERGE: // used for HEARTBEAT that is missing in the enum
             notificationType = 
                "<AVC dn=\"ManagedElement="+nodeName+",Equipment=1\">"
	      + "<attr name=\"userLabel\"><v>ThiIsMyEq"+val+"</v></attr></AVC>";
             break;

	case CREATE:
             notificationType = 
                "<objectCreated dn=\"ManagedElement="+nodeName+",Equipment=1,Cabinet=1\">"
              + "<attr name=\"cabinetId\"><v>1</v></attr>"
              + "<attr name=\"cabinetIdentifier\"><v></v></attr>"
              + "<attr name=\"climateControlMode\"><v>NORMAL</v></attr>"
              + "<attr name=\"climateSystem\"><v>STANDARD</v></attr>"
              + "<attr name=\"productData\">"
              + "<v>"
              + "<elem name=\"productionDate\"><v></v></elem>"
              + "<elem name=\"productName\"><v></v></elem>"
              + "<elem name=\"productNumber\"><v></v></elem>"
              + "<elem name=\"productRevision\"><v></v></elem>"
              + "<elem name=\"serialNumber\"><v></v></elem>"
              + "</v>"
              + "</attr>"
              + "<attr name=\"reservedBy\"/>"
              + "<attr name=\"smokeDetector\"><v>false</v></attr>"
              + "</objectCreated>"
              + "<objectCreated dn=\"ManagedElement="+nodeName+",Equipment=1,Cabinet=1,FanGroup=1\">"
              + "<attr name=\"fanGroupId\"><v>1</v></attr>"
              + "<attr name=\"fanGroupFaultIndicator\"><v>NOT_APPLICABLE</v></attr>"
              + "</objectCreated>";
           break;
        case REPLACE:
              notificationType = 
                "<AVC dn=\"ManagedElement="+nodeName+",Equipment=1,Cabinet=1\">"
	      + "<attr name=\"cabinetIdentifier\"><v>pink</v></attr></AVC>";
	break;
	case REMOVE:
        case DELETE:
	default:
	     notificationType = "<AVC dn=\"ManagedElement="+nodeName+",SgsnMme=1,SLs=1\">"
	      + "<attr name=\"t3x01long\"><v>"+val+"</v> </attr>"
              + "</AVC>";
	    break;
	}
	return notificationType;
    }


    private Operation getRandomOperation() {
	final List<Operation> operations = Collections.unmodifiableList(Arrays.asList(Operation.values()));
	return operations.get(new Random().nextInt(operations.size()));
    }

}
