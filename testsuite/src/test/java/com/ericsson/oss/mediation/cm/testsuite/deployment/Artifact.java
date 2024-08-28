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
package com.ericsson.oss.mediation.cm.testsuite.deployment;

import java.io.*;
import java.util.*;

import org.jboss.shrinkwrap.resolver.api.maven.Maven;

/**
 * Utility class
 *
 * This class contains all coordinates for maven artifacts used in the testsuite.
 *
 * The feature artifact versions could be overridden by system properties.
 *
 * @author ebialan
 */
public abstract class Artifact {
    public static String AWAITITILITY_JAR = "com.jayway.awaitility:awaitility:jar:?";

    /**
     * SLF4J coordinates
     */
    public static final String ORG_SLF4J___SLF4J_API_JAR = "org.slf4j:slf4j-api:jar";

    /**
     * SFTP coordinates
     */
    public static final String SFTP_SERVER__JAR = "com.ericsson.oss.services.test:sftp-server:jar:?";
    public static final String SFTP_CLIENT__JAR = "com.ericsson.oss.services.test:sftp-client:jar:?";

    /**
     * POI XML
     */
    public static final String ORG_APACHE_POI___POI_OOXML_JAR = "org.apache.poi:poi-ooxml:jar:?";

    /**
     * Service framework coordinates
     */
    public static final String COM_ERICSSON_OSS_ITPF_SDK___SERVICES_CORE_JAR = "com.ericsson.oss.itpf.sdk:sdk-services-core:jar";
    public static final String COM_ERICSSON_OSS_ITPF_SDK___CONFIG_API_JAR = "com.ericsson.oss.itpf.sdk:sdk-config-api:jar";
    public static final String COM_ERICSSON_OSS_ITPF_SDK___CONFIG_CORE_JAR = "com.ericsson.oss.itpf.sdk:sdk-config-core:jar";
    public static final String COM_ERICSSON_OSS_ITPF_SDK___CONFIG_CACHE_NON_CDI_JAR = "com.ericsson.oss.itpf.sdk:sdk-config-cache-non-cdi:jar";
    public static final String COM_ERICSSON_OSS_ITPF_SDK___SFWK_DIST = "com.ericsson.oss.itpf.sdk:service-framework-dist:jar:?";
    public static final String COM_ERICSSON_OSS_ITPF_SDK___SDK_MODELED_EVENTBUS_API = "com.ericsson.oss.itpf.sdk:sdk-modeled-eventbus-api";
    public static final String COM_ERICSSON_OSS_ITPF_SDK___SDK_MODELED_EVENTBUS = "com.ericsson.oss.itpf.sdk:sdk-modeled-eventbus";

    public static final String COM_ERICSSON_OSS_ITPF_SDK___SDK_CONTEXT_API = "com.ericsson.oss.itpf.sdk:sdk-context-api:jar:?";
    public static final String COM_ERICSSON_OSS_ITPF_SDK___SDK_CONTEXT_CORE = "com.ericsson.oss.itpf.sdk:sdk-context-core:jar:?";
    /**
     * Core mediation events
     */
    public static final String COM_ERICSSON_OSS_MEDIATION___CORE_MEDIATION_MODELS_API = "com.ericsson.nms.mediation:core-mediation-models-api:jar:?";

    /**
     * DPS api
     *
     */
    public static final String COM_ERICSSON_OSS_MEDIATION__DPS_API = "com.ericsson.oss.itpf.datalayer.dps:dps-api:jar:?";

    /**
     * Camel Engine coordinates
     *
     */
    public static final String COM_ERICSSON_OSS_MEDIATION__CAMEL_ENGINE = "org.jboss.as.camel:camel-engine-ear:ear:?";
    public static final String COM_ERICSSON_OSS_MEDIATION__CAMEL_ENGINE_JCA_COMMON = "com.ericsson.nms.mediation:camel-engine-jca-common:jar:?";

    /**
     * Jca Connector Api for netconf ssh connection (pom scope provided in jar package)
     *
     */
    // public static final String
    // COM_ERICSSON_OSS_MEDIATION_ADAPTER_SSH__JCA_CONNECTOR_API =
    // "com.ericsson.oss.mediation.adapter.ssh:ssh-jca-connector-api:jar:?";

    /**
     * Mediation Service coordinates
     */
    public static final String COM_ERICSSON_OSS_MEDIATION__MEDIATION_SERVICE_EAR = "com.ericsson.nms.mediation:mediation-service-ear:ear:?";

    /**
     * Mediation Core coordinates
     */
    // public static final String COM_ERICSSON_OSS_MEDIATION__MEDIATION_CORE_EAR
    // =
    // "com.ericsson.nms.mediation:mediation-core-ear:ear:?";
    public static final String COM_ERICSSON_OSS_MEDIATION__MEDIATION_ROUTER_EAR = "com.ericsson.oss.mediation:mediation-router-ear:ear:?";
    public static final String COM_ERICSSON_OSS_MEDIATION__EVENT_BASED_CLIENT_EAR = "com.ericsson.oss.mediation:event-based-client-ear:ear:?";
    public static final String COM_ERICSSON_OSS_MEDIATION__DPS_BASED_CLIENT_EAR = "com.ericsson.oss.mediation:dps-based-client-ear:ear:?";

    /**
     * shared-services-helper
     *
     * @author ecarova
     */
    public static final String COM_ERICSSON_OSS_SHARED_SERVICES_HELPER_EVENTS = "com.ericsson.oss.services.test:shared-services-helper-event-model:jar:?";
    public static final String COM_ERICSSON_OSS_SHARED_SERVICES_HELPER_API = "com.ericsson.oss.services.test:shared-services-helper-api:jar:?";
    public static final String COM_ERICSSON_OSS_SHARED_SERVICES_HELPER_EAR = "com.ericsson.oss.services.test:shared-services-helper-ear:ear:?";

    public static final String COM_ERICSSON_OSS_SERVICES_LCM_LICENSE_CONTROL_MONITORING_SERVICE_API = "com.ericsson.oss.services.lcm:license-control-monitoring-service-api:jar:?";
    public static final String COM_ERICSSON_OSS_SERVICES_LCM_LICENSE_CONTROL_MONITORING_SERVICE_EAR = "com.ericsson.oss.services.lcm:license-control-monitoring-service-ear:ear:?";


    public static final String COM_ERICSSON_LICENSEMANAGEMENT_LICENSE_MANAGEMENT_SERVICE_API = "com.ericsson.licensemanagement:LicenseManagementService-API:jar:?";
    /**
     * ftp and sshd and common jars for file collection
     */
    public static final String APACHE_EMBD_SFTPSERVER = "org.apache.sshd:sshd-core:jar:?";
    public static final String APACHE_COMMONS_IO = "commons-io:commons-io:jar:?";
    public static final String FTP_JCA_CONNECTOR_RAR = "com.ericsson.oss.mediation.adapter.ftp:ftp-jca-connector-rar:rar:?";
    public static final String JSCH = "com.jcraft:jsch:jar:?";


    /**
     * IDENTITYMANAGEMENTSERVICE coordinates
     */
    public static final String IDENTITY_SERVER__JAR = "com.ericsson.nms.security:identitymgmtservices-api:jar:?";


       /*
     * Snmp
     */

    public static final String ORG_ADVENTNET_SNMP = "org.adventnet:AdventNetSnmp:jar:?";
    public static final String ORG_ADVENTNET_LOGGING = "org.adventnet:AdventNetLogging:jar:?";
    public static final String ORG_ADVENTNET_SNMPV3USM = "org.adventnet:AdventNetSnmpV3USM:jar:?";
    public static final String SNMP_AGENT_SIMULATOR_BASE = "com.ericsson.oss.mediation.adapter.snmp.sim:snmp-agent-simulator-jar:jar:?";
    //public static final String SNMP_AGENT_SIMULATOR = "com.ericsson.oss.services.test:snmp-agent-simulator:jar:?";
 }
