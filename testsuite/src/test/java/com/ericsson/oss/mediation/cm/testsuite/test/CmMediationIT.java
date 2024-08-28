package com.ericsson.oss.mediation.cm.testsuite.test;

import java.io.File;
import java.io.IOException;
import java.util.concurrent.TimeUnit;

import javax.inject.Inject;

import org.jboss.arquillian.container.test.api.Deployment;
import org.jboss.shrinkwrap.api.Archive;
import org.jboss.shrinkwrap.api.spec.WebArchive;
import org.junit.AfterClass;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ericsson.oss.cucumber.arquillian.api.GluePackages;
import com.ericsson.oss.cucumber.arquillian.runtime.ArquillianCucumberExtension;
import com.ericsson.oss.itpf.datalayer.dps.notification.event.AttributeChangeData;
import com.ericsson.oss.itpf.datalayer.dps.notification.event.DpsAttributeChangedEvent;
import com.ericsson.oss.mediation.cm.stub.StubbedIdentitymgmtServices;
import com.ericsson.oss.mediation.cm.testsuite.deployment.Artifact;
import com.ericsson.oss.services.cm.test.constant.Constant;
import com.ericsson.oss.services.cm.test.helper.CmNodeHeartbeatSupervisionDatabaseHandler;
import com.ericsson.oss.services.snmp.agent.test.helper.SnmpAgentUtils;
import com.ericsson.oss.services.test.deployment.Configuration;
import com.ericsson.oss.services.test.deployment.Deployments;
import com.ericsson.oss.services.test.helper.NetworkElementDataBaseHandler;

import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.runtime.arquillian.api.Features;

@RunWith(ArquillianCucumberExtension.class)

@Features({ "Supervision.feature", "Synchronization.feature", "Notification.feature", "SoftwareSync.feature" })
@GluePackages
public class CmMediationIT {

    private static final Logger logger = LoggerFactory.getLogger(CmMediationIT.class);

    @Inject
    private NetworkElementDataBaseHandler networkElementDataBaseHandler;
    @Inject
    private CmNodeHeartbeatSupervisionDatabaseHandler cmNodeHeartbeatSupervisionDatabaseHandler;
    @Inject
    private SnmpAgentUtils snmpAgentUtils;

    /**
     * Deploy war archive with our taste case. Here we are using standard arquillian testing approach, where we deploy war containing our test case(s)
     *
     * @return Web archive with our test case.
     * @author ecarova
     */
    @Deployment(testable = true)
    public static Archive<?> createTestableWarModuleDeployment() throws IOException, InterruptedException {
        logger.info("<------- createTestableWarModuleDeployment ------->");

        final WebArchive testableWar;
        testableWar = Deployments.createCustomWar("TestCmMediation",
                new Class[] { CmMediationIT.class, Constant.class, DpsAttributeChangedEvent.class, AttributeChangeData.class, StubbedIdentitymgmtServices.class }, new Package[] {},
                new String[] { Configuration.COM_ERICSSON_OSS_CM_MEDIATION_CUCUMBER_STEPS__JAR,
                        Configuration.COM_ERICSSON_OSS_SNMP_AGENT_CUCUMBER_STEPS__JAR,
                        Artifact.COM_ERICSSON_LICENSEMANAGEMENT_LICENSE_MANAGEMENT_SERVICE_API, Artifact.IDENTITY_SERVER__JAR,
                        Artifact.COM_ERICSSON_OSS_SERVICES_LCM_LICENSE_CONTROL_MONITORING_SERVICE_API, Artifact.ORG_ADVENTNET_SNMP,
                        Artifact.ORG_ADVENTNET_LOGGING, Artifact.ORG_ADVENTNET_SNMPV3USM, Artifact.SNMP_AGENT_SIMULATOR_BASE, Artifact.AWAITITILITY_JAR },
                new String[] {});
        testableWar.addAsWebInfResource(new File("src/test/resources/jboss-deployment-structure.xml"));
        testableWar.addAsResource(new File("src/test/resources/ServiceFrameworkConfiguration.properties"));
        Deployments.setManifest(testableWar, "org.slf4j");
        return testableWar;
    }

    static boolean isShutdownHookConfigured = false;

    @Before
    public void setUpEnv() throws IOException {
        logger.info("<-------- SET UP ENV -------->");
    }

    @After(value = { "@Supervision" }, order = 3)
    public void disableCmSupervision() throws IOException, InterruptedException {
        logger.info("<-------- CLEANUP disableCmSupervision -------->");
        cmNodeHeartbeatSupervisionDatabaseHandler.setCmNodeHeartbeatSupervisionStatus(false);
        TimeUnit.SECONDS.sleep(3);
    }

    @After(order = 2)
    public void cleanup() throws IOException, InterruptedException {
        logger.info("<-------- CLEANUP deleteNetworkElements -------->");
        networkElementDataBaseHandler.deleteNetworkElements();
    }

    @After(value = { "@SnmpAgent" }, order = 1)
    public void stopSnmpAgent() {
        logger.info("<-------- CLEANUP stopSnmpAgent -------->");
        snmpAgentUtils.stopServers();
    }

    @AfterClass
    public static void end() {
        logger.info("Test finished");
    }
}