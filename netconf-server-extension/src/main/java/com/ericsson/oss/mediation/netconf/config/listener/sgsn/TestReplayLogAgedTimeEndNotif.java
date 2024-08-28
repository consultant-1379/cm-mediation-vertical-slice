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
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

/**
 * Listener used to simulate the notifications and test the heartbeat based on createSubscription
 * 
 * At the moment always the same notification will be sent using the specified timing.
 * 
 * @author ebialan
 * 
 */
@XmlRootElement(name = "TestReplayLogAgedTimeEndNotif")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlAddToContext
public class TestReplayLogAgedTimeEndNotif extends DefaultCommandListener {

    @XmlAttribute
    private String nodeName;
    
    private String filename;

    private boolean secondTime;

    private int round;
    
    public TestReplayLogAgedTimeEndNotif() {
        secondTime = false;
    }

    public TestReplayLogAgedTimeEndNotif(final String nodeName) {
        this.nodeName = nodeName;
        this.filename = "/"+nodeName+".xml";
        this.round = 0;
    }

    private static Logger logger = LoggerFactory.getLogger(TestReplayLogAgedTimeEndNotif.class);
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
	    
	    // the first three tests of DeltaWithLogAgedIT with create-Subscription
	    // will have answeres with replayLogAgedTime != null 
	    if (round <  3)
	    {  
	        round++;
	        out.println("\t\t\t\t\t<replayLogAgedTime>2015-07-28T00:00:00Z</replayLogAgedTime>");
            logger.error("    ################################## round = {}",round);
	    }
	        
	    out.println("\t\t\t\t</stream>");
	    out.println("\t\t\t</streams>");
	    out.println("\t\t</netconf>");
	    out.println("\t</data>");
	    out.println("</rpc-reply>");
	    out.println("]]>]]>");
	  } else {
	    //super.get(messageId, filter, out);
		  	this.filename = "/"+nodeName+".xml";
            logger.error("    ################################## GET con filename = {}",filename);
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
            if (secondTime) 
            {
                logger.error("    ################################## END GET: starting sleep");
                try {
                  Thread.sleep(60000);
                } catch (final InterruptedException e) {
			logger.warn("Sleep Interrupted!!!");
			Thread.currentThread().interrupt();
                }
                logger.error("    ################################## END GET:    sleep END");
            } else {
              secondTime = true;
            logger.error("    ################################## END GET: END OK!!");
            }
	  }
    }


    private void printFile(final PrintWriter out, final String filename) throws IOException {
        logger.error("    ######## inizio printFile ");
        try (final BufferedReader reader = new BufferedReader(new InputStreamReader(getClass().getResourceAsStream(
                filename)))) {
            logger.error("    ########  printFile prima di while ");
            String line;
            while ((line = reader.readLine()) != null) {
                logger.error("    ########line: {} ", line);
                out.println(line);
            }
            logger.error("    ########  printFile dopo while ");
        }
    }
    
    
/*
    private void printFile(final PrintWriter out, final String filename) throws IOException {
        logger.error("    ######## inizio printFile ");
        try (final BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            logger.error("    ########  printFile prima di while ");
            String line;
            while ((line = reader.readLine()) != null) {
                logger.error(" LINE : {}",line);
                out.println(line);
            }
            reader.close();
            logger.error("    ########  printFile dopo while ");
        }
    }
*/
/*
    @Override
    public void editConfig(final String messageId, final Datastore source, final DefaultOperation defaultOpertaion,
	    final ErrorOption errorOption, final TestOption testOption, final String config, final PrintWriter out) {
	super.editConfig(messageId, source, defaultOpertaion, errorOption, testOption, config, out);
	for (final Operation operation : Operation.values()) {
	    final String operationTag = String.format("operation=\"%s\"", operation);
	    if (config.replaceAll("[\\n\\t]", "").matches(".*(" + operationTag + ").*")) {

	    }
	}
    }
*/

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
			logger.debug("SessionId {}> Sending Notification ...", sessionId);
			sendSingleNotification(getNotificationType(Operation.MERGE,  "0", ""), out);
                        sendMultipleNotifications(getNotificationType(Operation.CREATE, "2", ""), out);
                        sendEndNotification(out);
      //sendSingleNotification(getNotificationType(Operation.REMOVE, "2", ""), out);
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
	out.println("<eventTime>2015-11-24T15:52:46Z</eventTime>");
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
    
        protected void sendEndNotification(
            final PrintWriter out) {
        final String dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'";
        DateFormat df = new SimpleDateFormat(dateFormat);
        final String now = (new SimpleDateFormat(dateFormat)
                    .format(new Date(getGMTcurrentDate().getTime())));
        out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        out.println("<notification xmlns=\"urn:ietf:params:xml:ns:netconf:notification:1.0\">");
        out.println("<eventTime>" + now + "</eventTime>");
        out.println("<replayComplete xmlns=\"urn:ietf:params:xml:ns:netmod:notification\" />");
        out.println("</notification>");
        out.println("]]>]]>");
    }
        
    public Date getGMTcurrentDate() {
        final String dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'";

        final SimpleDateFormat dateFormatGmt = new SimpleDateFormat(dateFormat);
        dateFormatGmt.setTimeZone(TimeZone.getTimeZone("GMT"));

        // Local time zone
        final SimpleDateFormat dateFormatLocal = new SimpleDateFormat(
                dateFormat);

        // Time in GMT
        Date currentDate = null;
        try {
            currentDate = dateFormatLocal.parse(dateFormatGmt
                    .format(new Date()));
        } catch (ParseException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return currentDate;
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
             notificationType = "<eventTime>2015-11-24T08:45:01Z</eventTime>"
              + "<heartBeat xmlns=\"urn:ericsson:com:sgsnmme:heartbeat:1.0\"/>";
             break;

	case CREATE:
             notificationType = 
                "<objectCreated dn=\"ManagedElement="+nodeName+",SgsnMme=1,Config=2\">"
              + "<attr name=\"configName\"><v></v></attr>"
              + "<attr name=\"lastChanged\"><v></v></attr>"
              + "<attr name=\"changedBy\"><v>Test1</v></attr>"
              + "</objectCreated>"
              + "<objectCreated dn=\"ManagedElement="+nodeName+",SgsnMme=1,Config=3\">"
              + "<attr name=\"configName\"><v></v></attr>"
              + "<attr name=\"lastChanged\"><v></v></attr>"
              + "<attr name=\"changedBy\"><v>Test2</v></attr>"
              + "</objectCreated>"
              + "<AVC dn=\"ManagedElement="+nodeName+",SgsnMme=1,SLs=1\">"
	      + "<attr name=\"t3x01short\"><v>33</v></attr></AVC>";
           break;
	case REMOVE:
             notificationType =
                "<objectDeleted dn=\"ManagedElement="+nodeName+",SgsnMme=1,Config=2\"/>";
             break;
	case DELETE:
	case REPLACE:
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
