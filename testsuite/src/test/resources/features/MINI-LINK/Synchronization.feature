
@MINI-LINK @SnmpAgent @Supervision
Feature: MINI-LINK CM Synchronization management

   @ManualSync
   Scenario: Manual Synchronization
     Given Licenses in file MINI-LINK/licenses
     Given NetworkElements in file MINI-LINK/CmSupervision
     And Initialize SNMP nodes from file MINI-LINK/CmSupervision
     And Start SNMP Agent Simulator for nodes
     And Initialize SNMP Agent Emulator for target in file MINI-LINK/CmSupervision

     When ENABLE CM supervision for nodes in file MINI-LINK/CmSupervision
     Then Wait for CM sync status is PENDING in 65 seconds for each target in file MINI-LINK/CmSupervision
      And Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file MINI-LINK/CmSupervision
      And Wait for CM sync status is SYNCHRONIZED in 30 seconds for each target in file MINI-LINK/CmSupervision     

     When Start synchronization for nodes in file MINI-LINK/CmSupervision
     Then Wait for CM sync status is PENDING in 65 seconds for each target in file MINI-LINK/CmSupervision
      And Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file MINI-LINK/CmSupervision
      And Wait for CM sync status is SYNCHRONIZED in 30 seconds for each target in file MINI-LINK/CmSupervision     

     When DISABLE CM supervision for nodes in file MINI-LINK/CmSupervision
     Then Wait for CM sync status is UNSYNCHRONIZED in 30 seconds for each target in file MINI-LINK/CmSupervision

   @DeltaSync
   Scenario: Delta Synchronization
     Given Licenses in file MINI-LINK/licenses
     Given NetworkElements in file MINI-LINK/CmSupervision
     And Initialize SNMP nodes from file MINI-LINK/CmSupervision
     And Start SNMP Agent Simulator for nodes
     And Initialize SNMP Agent Emulator for target in file MINI-LINK/CmSupervision

     When ENABLE CM supervision for nodes in file MINI-LINK/CmSupervision
     Then Wait for CM sync status is PENDING in 65 seconds for each target in file MINI-LINK/CmSupervision
      And Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file MINI-LINK/CmSupervision
      And Wait for CM sync status is SYNCHRONIZED in 30 seconds for each target in file MINI-LINK/CmSupervision

     Given Clear SNMP Agent Emulator parameters
      And Parameterize SNMP Agent Emulator request types
      | GETBULK |
      And Parameterize SNMP Agent Emulator for targets in file MINI-LINK/CmSupervision
      And Parameterize SNMP Agent Emulator for returning the following attribute-value pairs as table entries
      | .1.3.6.1.4.1.193.81.2.8.3.11 | .1.3.6.1.4.1.193.81.2.8.3.11.1.1.1 | 3 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.1.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.2.1 | 1 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.2.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.3.1 | 3.4.5.6 | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.3.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.4.1 | alias | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.4.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.5.1 | 56 | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.5.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.6.1 | userName | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.6.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.7.1 | password | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.7.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.8.1 | encrPwd | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.8.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.9.1 | 1 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.9.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.10.1 | 2 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.10.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.11.1 | 2 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.11.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.1.2| 43 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.1.2 | .1.3.6.1.4.1.193.81.2.8.3.11.1.2.2 | 1 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.2.2 | .1.3.6.1.4.1.193.81.2.8.3.11.1.3.2 | 3.4.5.6 | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.3.2 | .1.3.6.1.4.1.193.81.2.8.3.11.1.4.2 | alias | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.4.2 | .1.3.6.1.4.1.193.81.2.8.3.11.1.5.2 | 56 | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.5.2 | .1.3.6.1.4.1.193.81.2.8.3.11.1.6.2 | userName | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.6.2 | .1.3.6.1.4.1.193.81.2.8.3.11.1.7.2 | password | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.7.2 | .1.3.6.1.4.1.193.81.2.8.3.11.1.8.2 | encrPwd | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.8.2 | .1.3.6.1.4.1.193.81.2.8.3.11.1.9.2 | 1 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.9.2 | .1.3.6.1.4.1.193.81.2.8.3.11.1.10.2 | 2 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.10.2 | .1.3.6.1.4.1.193.81.2.8.3.11.1.11.2 | 2 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.11.2 | .1.3.6.1.4.1.193.81.2.8.3.12.1.2| 12 | INTEGER |
      And Create parameterized SNMP Agent Emulator
     Then Create BEFORE snapshot of MOs and attributes in DPS under ManagedElement for nodes in file MINI-LINK/CmSupervision
      And Start synchronization for nodes in file MINI-LINK/CmSupervision
      And Wait for CM sync status is PENDING in 65 seconds for each target in file MINI-LINK/CmSupervision
      And Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file MINI-LINK/CmSupervision
      And Wait for CM sync status is SYNCHRONIZED in 30 seconds for each target in file MINI-LINK/CmSupervision     
      And Create AFTER snapshot of MOs and attributes in DPS under ManagedElement for nodes in file MINI-LINK/CmSupervision
      And Verify DPS changes in this interval for ManagedObjects
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=43 | CREATED |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=3 | CREATED |
      And Verify DPS changes in this interval for attributes
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=43 | xfDcnFTPConfigPassword | NULL | password |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=43 | xfDcnFTPConfigRowStatus | NULL | active |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=43 | xfDcnFTPConfigAlias | NULL | alias |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=43 | xfDcnFTPConfigAddress | NULL | 3.4.5.6 |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=43 | xfDcnFTPConfigTCPPort | NULL | 56 |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=43 | xfDcnFTPConfigCheckConnectivityStatus | NULL | checkOK |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=43 | xfDcnFTPConfigProtocol | NULL | sftp |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=43 | xfDcnFTPConfigUser | NULL | userName |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=43 | xfDcnFTPConfigEncryptedPwd | NULL | encrPwd |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=43 | xfDcnFTPConfigIndex | NULL | 43 |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=3 | xfDcnFTPConfigPassword | NULL | password |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=3 | xfDcnFTPConfigRowStatus | NULL | active |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=3 | xfDcnFTPConfigAlias | NULL | alias |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=3 | xfDcnFTPConfigAddress | NULL | 3.4.5.6 |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=3 | xfDcnFTPConfigTCPPort | NULL | 56 |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=3 | xfDcnFTPConfigCheckConnectivityStatus | NULL | checkOK |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=3 | xfDcnFTPConfigProtocol | NULL | sftp |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=3 | xfDcnFTPConfigUser | NULL | userName |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=3 | xfDcnFTPConfigEncryptedPwd | NULL | encrPwd |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=3 | xfDcnFTPConfigIndex | NULL | 3 |

     Given Clear SNMP Agent Emulator parameters
      And Parameterize SNMP Agent Emulator request types
      | GETBULK |
      And Parameterize SNMP Agent Emulator for targets in file MINI-LINK/CmSupervision
      And Parameterize SNMP Agent Emulator for returning the following attribute-value pairs as table entries
      | .1.3.6.1.4.1.193.81.2.8.3.11 | .1.3.6.1.4.1.193.81.2.8.3.11.1.1.1 | 3 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.1.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.2.1 | 1 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.2.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.3.1 | 3.4.5.6 | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.3.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.4.1 | alias | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.4.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.5.1 | 100 | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.5.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.6.1 | userName2 | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.6.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.7.1 | password | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.7.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.8.1 | encrPwd | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.8.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.9.1 | 1 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.9.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.10.1 | 2 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.10.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.11.1 | 2 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.11.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.1.2| 43 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.1.2 | .1.3.6.1.4.1.193.81.2.8.3.11.1.2.2 | 1 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.2.2 | .1.3.6.1.4.1.193.81.2.8.3.11.1.3.2 | 3.4.5.6 | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.3.2 | .1.3.6.1.4.1.193.81.2.8.3.11.1.4.2 | alias | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.4.2 | .1.3.6.1.4.1.193.81.2.8.3.11.1.5.2 | 56 | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.5.2 | .1.3.6.1.4.1.193.81.2.8.3.11.1.6.2 | userName | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.6.2 | .1.3.6.1.4.1.193.81.2.8.3.11.1.7.2 | password | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.7.2 | .1.3.6.1.4.1.193.81.2.8.3.11.1.8.2 | encrPwd | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.8.2 | .1.3.6.1.4.1.193.81.2.8.3.11.1.9.2 | 1 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.9.2 | .1.3.6.1.4.1.193.81.2.8.3.11.1.10.2 | 2 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.10.2 | .1.3.6.1.4.1.193.81.2.8.3.11.1.11.2 | 2 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.11.2 | .1.3.6.1.4.1.193.81.2.8.3.12.1.2| 12 | INTEGER |
      And Create parameterized SNMP Agent Emulator
     Then Create BEFORE snapshot of MOs and attributes in DPS under ManagedElement for nodes in file MINI-LINK/CmSupervision
      And Start synchronization for nodes in file MINI-LINK/CmSupervision
      And Wait for CM sync status is PENDING in 65 seconds for each target in file MINI-LINK/CmSupervision
      And Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file MINI-LINK/CmSupervision
      And Wait for CM sync status is SYNCHRONIZED in 30 seconds for each target in file MINI-LINK/CmSupervision     
      And Create AFTER snapshot of MOs and attributes in DPS under ManagedElement for nodes in file MINI-LINK/CmSupervision
      And Verify DPS changes in this interval for ManagedObjects
      | | |
      And Verify DPS changes in this interval for attributes
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=3 | xfDcnFTPConfigTCPPort | 56 | 100 |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=3 | xfDcnFTPConfigUser | userName | userName2 |

     Given Clear SNMP Agent Emulator parameters
      And Parameterize SNMP Agent Emulator request types
      | GETBULK |
      And Parameterize SNMP Agent Emulator for targets in file MINI-LINK/CmSupervision
      And Parameterize SNMP Agent Emulator for returning the following attribute-value pairs as table entries
      | .1.3.6.1.4.1.193.81.2.8.3.11 | .1.3.6.1.4.1.193.81.2.8.3.11.1.1.1 | 3 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.1.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.2.1 | 1 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.2.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.3.1 | 3.4.5.6 | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.3.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.4.1 | alias | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.4.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.5.1 | 100 | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.5.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.6.1 | userName2 | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.6.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.7.1 | password | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.7.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.8.1 | encrPwd | STRING |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.8.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.9.1 | 1 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.9.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.10.1 | 2 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.10.1 | .1.3.6.1.4.1.193.81.2.8.3.11.1.11.1 | 2 | INTEGER |
      | .1.3.6.1.4.1.193.81.2.8.3.11.1.11.1 | .1.3.6.1.4.1.193.81.2.8.3.12.1.2| 12 | INTEGER |
      And Create parameterized SNMP Agent Emulator
     Then Create BEFORE snapshot of MOs and attributes in DPS under ManagedElement for nodes in file MINI-LINK/CmSupervision
      And Start synchronization for nodes in file MINI-LINK/CmSupervision
      And Wait for CM sync status is PENDING in 65 seconds for each target in file MINI-LINK/CmSupervision
      And Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file MINI-LINK/CmSupervision
      And Wait for CM sync status is SYNCHRONIZED in 30 seconds for each target in file MINI-LINK/CmSupervision     
      And Create AFTER snapshot of MOs and attributes in DPS under ManagedElement for nodes in file MINI-LINK/CmSupervision
      And Verify DPS changes in this interval for ManagedObjects
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=43 | DELETED |
      And Verify DPS changes in this interval for attributes
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=43 | xfDcnFTPConfigPassword | password | NULL |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=43 | xfDcnFTPConfigRowStatus | active | NULL |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=43 | xfDcnFTPConfigAlias | alias | NULL |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=43 | xfDcnFTPConfigAddress | 3.4.5.6 | NULL |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=43 | xfDcnFTPConfigTCPPort | 56 | NULL |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=43 | xfDcnFTPConfigCheckConnectivityStatus | checkOK | NULL |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=43 | xfDcnFTPConfigProtocol | sftp | NULL |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=43 | xfDcnFTPConfigUser | userName | NULL |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=43 | xfDcnFTPConfigEncryptedPwd | encrPwd | NULL |
      | ManagedElement=ML_indoor_1,ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1,xfDcnFTPConfigTable=1,xfDcnFTPConfigEntry=43 | xfDcnFTPConfigIndex | 43 | NULL |
