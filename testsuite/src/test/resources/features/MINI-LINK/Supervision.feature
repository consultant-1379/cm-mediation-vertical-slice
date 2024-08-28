
@MINI-LINK @SnmpAgent @Supervision
Feature: MINI-LINK CM Supervision management

   Scenario: Validate Supervision and Synchronization flows
     Given Licenses in file MINI-LINK/licenses
     Given NetworkElements in file MINI-LINK/CmSupervision
     And Initialize SNMP nodes from file MINI-LINK/CmSupervision
     And Start SNMP Agent Simulator for nodes
     And Initialize SNMP Agent Emulator for target in file MINI-LINK/CmSupervision
     
     When ENABLE CM supervision for nodes in file MINI-LINK/CmSupervision
     Then Wait for CM sync status is PENDING in 65 seconds for each target in file MINI-LINK/CmSupervision
      And Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file MINI-LINK/CmSupervision
      And Wait for CM sync status is SYNCHRONIZED in 30 seconds for each target in file MINI-LINK/CmSupervision     

     When DISABLE CM supervision for nodes in file MINI-LINK/CmSupervision
     Then Wait for CM sync status is UNSYNCHRONIZED in 30 seconds for each target in file MINI-LINK/CmSupervision

   Scenario: Validate Read error scenario handling - specific attribute GET fails
     Given Licenses in file MINI-LINK/licenses
     Given NetworkElements in file MINI-LINK/CmSupervision
     And Initialize SNMP nodes from file MINI-LINK/CmSupervision
     And Start SNMP Agent Simulator for nodes
     And Initialize SNMP Agent Emulator for target in file MINI-LINK/CmSupervision
     
     When ENABLE CM supervision for nodes in file MINI-LINK/CmSupervision
      Then Wait for CM sync status is PENDING in 65 seconds for each target in file MINI-LINK/CmSupervision
      Then Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file MINI-LINK/CmSupervision
      Then Wait for CM sync status is SYNCHRONIZED in 30 seconds for each target in file MINI-LINK/CmSupervision
     When Initialize SNMP Agent Emulator for returning generic read error upon GET requests of xfSwActiveRelease attribute for target in file MINI-LINK/CmSupervision
      And Start synchronization for nodes in file MINI-LINK/CmSupervision
       Then Wait for CM sync status is PENDING in 65 seconds for each target in file MINI-LINK/CmSupervision
       Then Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file MINI-LINK/CmSupervision
       Then Wait for CM sync status is UNSYNCHRONIZED in 30 seconds for each target in file MINI-LINK/CmSupervision
     When DISABLE CM supervision for nodes in file MINI-LINK/CmSupervision
      And Initialize SNMP Agent Emulator for target in file MINI-LINK/CmSupervision
      And ENABLE CM supervision for nodes in file MINI-LINK/CmSupervision
       Then Wait for CM sync status is PENDING in 130 seconds for each target in file MINI-LINK/CmSupervision
       Then Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file MINI-LINK/CmSupervision
       Then Wait for CM sync status is SYNCHRONIZED in 30 seconds for each target in file MINI-LINK/CmSupervision

   Scenario: Validate Read error scenario handling - all GET fails (node out-of-service)
     Given Licenses in file MINI-LINK/licenses
     Given NetworkElements in file MINI-LINK/CmSupervision
     And Initialize SNMP nodes from file MINI-LINK/CmSupervision
     And Start SNMP Agent Simulator for nodes
     And Initialize SNMP Agent Emulator for target in file MINI-LINK/CmSupervision
     
     When ENABLE CM supervision for nodes in file MINI-LINK/CmSupervision
      Then Wait for CM sync status is PENDING in 65 seconds for each target in file MINI-LINK/CmSupervision
      Then Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file MINI-LINK/CmSupervision
      Then Wait for CM sync status is SYNCHRONIZED in 30 seconds for each target in file MINI-LINK/CmSupervision
     When Initialize SNMP Agent Emulator for returning generic read error upon all GET requests for target in file MINI-LINK/CmSupervision
      And Start synchronization for nodes in file MINI-LINK/CmSupervision
       Then Wait for CM sync status is UNSYNCHRONIZED in 30 seconds for each target in file MINI-LINK/CmSupervision
     When DISABLE CM supervision for nodes in file MINI-LINK/CmSupervision
      And Initialize SNMP Agent Emulator for target in file MINI-LINK/CmSupervision
      And ENABLE CM supervision for nodes in file MINI-LINK/CmSupervision
       Then Wait for CM sync status is PENDING in 130 seconds for each target in file MINI-LINK/CmSupervision
       Then Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file MINI-LINK/CmSupervision
       Then Wait for CM sync status is SYNCHRONIZED in 30 seconds for each target in file MINI-LINK/CmSupervision

   Scenario: Validate write error scenario handling
     Given Licenses in file MINI-LINK/licenses
     Given NetworkElements in file MINI-LINK/CmSupervision
     And Initialize SNMP nodes from file MINI-LINK/CmSupervision
     And Start SNMP Agent Simulator for nodes
     And Initialize SNMP Agent Emulator for target in file MINI-LINK/CmSupervision

     When ENABLE CM supervision for nodes in file MINI-LINK/CmSupervision
      Then Wait for CM sync status is PENDING in 65 seconds for each target in file MINI-LINK/CmSupervision
      Then Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file MINI-LINK/CmSupervision
      Then Wait for CM sync status is SYNCHRONIZED in 30 seconds for each target in file MINI-LINK/CmSupervision
     When Initialize SNMP Agent Emulator for returning generic write error upon SET requests of xfSwUpgradeActiveFTP (oid=1.3.6.1.4.1.193.81.2.8.3.13) attribute for target in file MINI-LINK/CmSupervision
      And Set attributes for nodes in file MINI-LINK/CmSupervision.
        | moFdn | name | type | value | rootMoType | mediated | suppressConstrains | throwsException |
        | ericsson=1,miniLinkXF=1,xfPlatform=1,xfDcnMIB=1,xfDcnFTP=1 | xfSwUpgradeActiveFTP | INTEGER | 12 | ManagedElement | true | false | true |
       Then Wait for CM sync status is UNSYNCHRONIZED in 65 seconds for each target in file MINI-LINK/CmSupervision
     When DISABLE CM supervision for nodes in file MINI-LINK/CmSupervision
      And Initialize SNMP Agent Emulator for target in file MINI-LINK/CmSupervision
      And ENABLE CM supervision for nodes in file MINI-LINK/CmSupervision
       Then Wait for CM sync status is PENDING in 130 seconds for each target in file MINI-LINK/CmSupervision
       Then Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file MINI-LINK/CmSupervision
       Then Wait for CM sync status is SYNCHRONIZED in 30 seconds for each target in file MINI-LINK/CmSupervision

