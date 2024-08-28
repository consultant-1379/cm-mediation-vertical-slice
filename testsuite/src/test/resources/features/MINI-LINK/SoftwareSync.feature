@MINI-LINK @SnmpAgent @SoftwareSync
Feature: MINI-LINK CM Software Synchronization

   Scenario: Validate the Software Synchronization flow - Prefix match: correct OSS and node model identities are found for baseline revision values; N/A -> 15A
     Given Licenses in file MINI-LINK/licenses
     Given NetworkElements in file MINI-LINK/SwSync_NoModelId
     And Initialize SNMP nodes from file MINI-LINK/SwSync_NoModelId
     And Start SNMP Agent Simulator for nodes
     And Initialize SNMP Agent Emulator for nodeIdentity="CXP9010021_1" and nodeRevision="R30K156" for targets in file MINI-LINK/SwSync_NoModelId

    When Verify attributes for nodes in file MINI-LINK/SwSync_NoModelId.
       | moFdn | name | type | value | rootMoType | mediated | suppressConstrains | throwsException |
       |  | ossModelIdentity | STRING | NULL | NetworkElement | true | false | false |
       |  | nodeModelIdentity | STRING | NULL | NetworkElement | true | false | false |
       |  | release | STRING | NULL | NetworkElement | true | false | false |
       |  | neProductVersion | STRING | NULL | NetworkElement | true | false | false |
      And ENABLE CM supervision for nodes in file MINI-LINK/SwSync_NoModelId
      And Start synchronization for nodes in file MINI-LINK/SwSync_NoModelId
      And Wait for CM sync status is PENDING in 65 seconds for each target in file MINI-LINK/SwSync_NoModelId
      And Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file MINI-LINK/SwSync_NoModelId
      And Wait for CM sync status is SYNCHRONIZED in 30 seconds for each target in file MINI-LINK/SwSync_NoModelId
     Then Verify attributes for nodes in file MINI-LINK/SwSync_NoModelId.
       | moFdn | name | type | value | rootMoType | mediated | suppressConstrains | throwsException |
       |  | ossModelIdentity | STRING | M15A-TN-5.3FP.2-LH-1.5FP.2 | NetworkElement | true | false | false |
       |  | nodeModelIdentity | STRING | M15A-TN-5.3FP.2-LH-1.5FP.2 | NetworkElement | true | false | false |
       |  | release | STRING | 15A | NetworkElement | true | false | false |
       |  | neProductVersion | STRING | [{revision=R30K156, identity=CXP9010021/1}] | NetworkElement | true | false | false |

     When DISABLE CM supervision for nodes in file MINI-LINK/SwSync_NoModelId
     Then Wait for CM sync status is UNSYNCHRONIZED in 30 seconds for each target in file MINI-LINK/SwSync_NoModelId



   Scenario: Validate the Software Synchronization flow - Prefix match: correct OSS and node model identities are found for baseline revision values; 15A -> 16A
     Given Licenses in file MINI-LINK/licenses
     Given NetworkElements in file MINI-LINK/SwSync_15AModelId
     And Initialize SNMP nodes from file MINI-LINK/SwSync_15AModelId
     And Start SNMP Agent Simulator for nodes
     And Initialize SNMP Agent Emulator for nodeIdentity="CXP9010021_1" and nodeRevision="R32B126" for targets in file MINI-LINK/SwSync_15AModelId

     When Verify attributes for nodes in file MINI-LINK/SwSync_15AModelId.
       | moFdn | name | type | value | rootMoType | mediated | suppressConstrains | throwsException |
       |  | ossModelIdentity | STRING | M15A-TN-5.3FP.2-LH-1.5FP.2 | NetworkElement | true | false | false |
       |  | nodeModelIdentity | STRING | NULL | NetworkElement | true | false | false |
       |  | release | STRING | NULL | NetworkElement | true | false | false |
       |  | neProductVersion | STRING | NULL | NetworkElement | true | false | false |
      And ENABLE CM supervision for nodes in file MINI-LINK/SwSync_15AModelId
      And Start synchronization for nodes in file MINI-LINK/SwSync_15AModelId
      And Wait for CM sync status is PENDING in 65 seconds for each target in file MINI-LINK/SwSync_15AModelId
      And Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file MINI-LINK/SwSync_15AModelId
      And Wait for CM sync status is SYNCHRONIZED in 30 seconds for each target in file MINI-LINK/SwSync_15AModelId
     Then Verify attributes for nodes in file MINI-LINK/SwSync_15AModelId.
       | moFdn | name | type | value | rootMoType | mediated | suppressConstrains | throwsException |
       |  | ossModelIdentity | STRING | M16A-TN-5.4FP-LH-1.6FP | NetworkElement | true | false | false |
       |  | nodeModelIdentity | STRING | M16A-TN-5.4FP-LH-1.6FP | NetworkElement | true | false | false |
       |  | release | STRING | 16A | NetworkElement | true | false | false |
       |  | neProductVersion | STRING | [{revision=R32B126, identity=CXP9010021/1}] | NetworkElement | true | false | false |

     When DISABLE CM supervision for nodes in file MINI-LINK/SwSync_15AModelId
     Then Wait for CM sync status is UNSYNCHRONIZED in 30 seconds for each target in file MINI-LINK/SwSync_15AModelId



   Scenario: Validate the Software Synchronization flow - Prefix match: correct OSS and node model identities are found for baseline revision values; release and ne_product_type are filled in even when not stepping releases; 16A -> 16A
     Given Licenses in file MINI-LINK/licenses
     Given NetworkElements in file MINI-LINK/SwSync_16AModelId
     And Initialize SNMP nodes from file MINI-LINK/SwSync_16AModelId
     And Start SNMP Agent Simulator for nodes
     And Initialize SNMP Agent Emulator for nodeIdentity="CXP9010021_1" and nodeRevision="R32B01" for targets in file MINI-LINK/SwSync_16AModelId

     When Verify attributes for nodes in file MINI-LINK/SwSync_16AModelId.
       | moFdn | name | type | value | rootMoType | mediated | suppressConstrains | throwsException |
       |  | ossModelIdentity | STRING | M16A-TN-5.4FP-LH-1.6FP | NetworkElement | true | false | false |
       |  | nodeModelIdentity | STRING | NULL | NetworkElement | true | false | false |
       |  | release | STRING | NULL | NetworkElement | true | false | false |
       |  | neProductVersion | STRING | NULL | NetworkElement | true | false | false |
      And ENABLE CM supervision for nodes in file MINI-LINK/SwSync_16AModelId
      And Start synchronization for nodes in file MINI-LINK/SwSync_16AModelId
      And Wait for CM sync status is PENDING in 65 seconds for each target in file MINI-LINK/SwSync_16AModelId
      And Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file MINI-LINK/SwSync_16AModelId
      And Wait for CM sync status is SYNCHRONIZED in 30 seconds for each target in file MINI-LINK/SwSync_16AModelId
     Then Verify attributes for nodes in file MINI-LINK/SwSync_16AModelId.
       | moFdn | name | type | value | rootMoType | mediated | suppressConstrains | throwsException |
       |  | ossModelIdentity | STRING | M16A-TN-5.4FP-LH-1.6FP | NetworkElement | true | false | false |
       |  | nodeModelIdentity | STRING | M16A-TN-5.4FP-LH-1.6FP | NetworkElement | true | false | false |
       |  | release | STRING | 16A | NetworkElement | true | false | false |
       |  | neProductVersion | STRING | [{revision=R32B01, identity=CXP9010021/1}] | NetworkElement | true | false | false |

     When DISABLE CM supervision for nodes in file MINI-LINK/SwSync_16AModelId
     Then Wait for CM sync status is UNSYNCHRONIZED in 30 seconds for each target in file MINI-LINK/SwSync_16AModelId



   Scenario: Validate the Software Synchronization flow - Automatic Treat-As: release differs also in letter code, but still correctly identified, OSS model identity is set accordingly, but node model identity is left NULL, node synchronizes
     Given Licenses in file MINI-LINK/licenses
     Given NetworkElements in file MINI-LINK/SwSync_NoModelId
     And Initialize SNMP nodes from file MINI-LINK/SwSync_NoModelId
     And Start SNMP Agent Simulator for nodes
     And Initialize SNMP Agent Emulator for nodeIdentity="CXP9010021_1" and nodeRevision="R34E123" for targets in file MINI-LINK/SwSync_NoModelId

     When Verify attributes for nodes in file MINI-LINK/SwSync_NoModelId.
       | moFdn | name | type | value | rootMoType | mediated | suppressConstrains | throwsException |
       |  | ossModelIdentity | STRING | NULL | NetworkElement | true | false | false |
       |  | nodeModelIdentity | STRING | NULL | NetworkElement | true | false | false |
       |  | release | STRING | NULL | NetworkElement | true | false | false |
       |  | neProductVersion | STRING | NULL | NetworkElement | true | false | false |
     And ENABLE CM supervision for nodes in file MINI-LINK/SwSync_NoModelId
      And Start synchronization for nodes in file MINI-LINK/SwSync_NoModelId
      And Wait for CM sync status is PENDING in 65 seconds for each target in file MINI-LINK/SwSync_NoModelId
      And Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file MINI-LINK/SwSync_NoModelId
      And Wait for CM sync status is SYNCHRONIZED in 30 seconds for each target in file MINI-LINK/SwSync_NoModelId
     Then Verify attributes for nodes in file MINI-LINK/SwSync_NoModelId.
       | moFdn | name | type | value | rootMoType | mediated | suppressConstrains | throwsException |
       |  | ossModelIdentity | STRING | M16A-TN-5.4FP-LH-1.6FP | NetworkElement | true | false | false |
       |  | nodeModelIdentity | STRING | NULL | NetworkElement | true | false | false |
       |  | release | STRING | 16A | NetworkElement | true | false | false |
       |  | neProductVersion | STRING | [{revision=R34E123, identity=CXP9010021/1}] | NetworkElement | true | false | false |

     When DISABLE CM supervision for nodes in file MINI-LINK/SwSync_NoModelId
     Then Wait for CM sync status is UNSYNCHRONIZED in 30 seconds for each target in file MINI-LINK/SwSync_NoModelId



   Scenario: Validate the Software Synchronization flow - No match: no model identity found for revision (but node type exists), no OSS model identity set, node is not getting synchronized
     Given Licenses in file MINI-LINK/licenses
     Given NetworkElements in file MINI-LINK/SwSync_NoModelId
     And Initialize SNMP nodes from file MINI-LINK/SwSync_NoModelId
     And Start SNMP Agent Simulator for nodes
     And Initialize SNMP Agent Emulator for target in file MINI-LINK/SwSync_NoModelId
     And Initialize SNMP Agent Emulator for nodeIdentity="CXP9010021_1" and nodeRevision="XB29" for targets in file MINI-LINK/SwSync_NoModelId

     When Verify attributes for nodes in file MINI-LINK/SwSync_NoModelId.
       | moFdn | name | type | value | rootMoType | mediated | suppressConstrains | throwsException |
       |  | ossModelIdentity | STRING | NULL | NetworkElement | true | false | false |
       |  | nodeModelIdentity | STRING | NULL | NetworkElement | true | false | false |
       |  | release | STRING | NULL | NetworkElement | true | false | false |
       |  | neProductVersion | STRING | NULL | NetworkElement | true | false | false |
      And ENABLE CM supervision for nodes in file MINI-LINK/SwSync_NoModelId
      And Start synchronization for nodes in file MINI-LINK/SwSync_NoModelId
      And Wait for CM sync status is PENDING in 65 seconds for each target in file MINI-LINK/SwSync_NoModelId
      And Wait for CM sync status is UNSYNCHRONIZED in 30 seconds for each target in file MINI-LINK/SwSync_NoModelId
     When Verify attributes for nodes in file MINI-LINK/SwSync_NoModelId.
       | moFdn | name | type | value | rootMoType | mediated | suppressConstrains | throwsException |
       |  | ossModelIdentity | STRING | NULL | NetworkElement | true | false | false |
       |  | nodeModelIdentity | STRING | NULL | NetworkElement | true | false | false |
       |  | release | STRING | NULL | NetworkElement | true | false | false |
       |  | neProductVersion | STRING | NULL | NetworkElement | true | false | false |
      And DISABLE CM supervision for nodes in file MINI-LINK/SwSync_NoModelId



   Scenario: Validate the Software Synchronization flow - Manual Treat-As: special release revision is read from node and OSS model identity is set by operator, values left unchanged, node synchronizes
     Given Licenses in file MINI-LINK/licenses
     Given NetworkElements in file MINI-LINK/SwSync_17AModelId
     And Initialize SNMP nodes from file MINI-LINK/SwSync_17AModelId
     And Start SNMP Agent Simulator for nodes
     And Initialize SNMP Agent Emulator for nodeIdentity="CXP9010021_1" and nodeRevision="P1A1" for targets in file MINI-LINK/SwSync_17AModelId

     When Verify attributes for nodes in file MINI-LINK/SwSync_17AModelId.
       | moFdn | name | type | value | rootMoType | mediated | suppressConstrains | throwsException |
       |  | ossModelIdentity | STRING | M17A-TN-6.0-LH-2.0 | NetworkElement | true | false | false |
       |  | nodeModelIdentity | STRING | NULL | NetworkElement | true | false | false |
       |  | release | STRING | NULL | NetworkElement | true | false | false |
       |  | neProductVersion | STRING | NULL | NetworkElement | true | false | false |
      And ENABLE CM supervision for nodes in file MINI-LINK/SwSync_17AModelId
      And Start synchronization for nodes in file MINI-LINK/SwSync_17AModelId
      And Wait for CM sync status is PENDING in 65 seconds for each target in file MINI-LINK/SwSync_17AModelId
      And Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file MINI-LINK/SwSync_17AModelId
      And Wait for CM sync status is SYNCHRONIZED in 30 seconds for each target in file MINI-LINK/SwSync_17AModelId
     Then Verify attributes for nodes in file MINI-LINK/SwSync_17AModelId.
       | moFdn | name | type | value | rootMoType | mediated | suppressConstrains | throwsException |
       |  | ossModelIdentity | STRING | M17A-TN-6.0-LH-2.0 | NetworkElement | true | false | false |
       |  | nodeModelIdentity | STRING | NULL | NetworkElement | true | false | false |
       |  | release | STRING | NULL | NetworkElement | true | false | false |
       |  | neProductVersion | STRING | NULL | NetworkElement | true | false | false |

     When DISABLE CM supervision for nodes in file MINI-LINK/SwSync_17AModelId
     Then Wait for CM sync status is UNSYNCHRONIZED in 30 seconds for each target in file MINI-LINK/SwSync_17AModelId



   Scenario: Validate the Software Synchronization flow - Manual Treat-As: too old revision is read from node and OSS model identity is set by operator, values left unchanged, node synchronizes
     Given Licenses in file MINI-LINK/licenses
     Given NetworkElements in file MINI-LINK/SwSync_17AModelId
     And Initialize SNMP nodes from file MINI-LINK/SwSync_17AModelId
     And Start SNMP Agent Simulator for nodes
     And Initialize SNMP Agent Emulator for nodeIdentity="CXP9010021_1" and nodeRevision="R1A1" for targets in file MINI-LINK/SwSync_17AModelId

     When Verify attributes for nodes in file MINI-LINK/SwSync_17AModelId.
       | moFdn | name | type | value | rootMoType | mediated | suppressConstrains | throwsException |
       |  | ossModelIdentity | STRING | M17A-TN-6.0-LH-2.0 | NetworkElement | true | false | false |
       |  | nodeModelIdentity | STRING | NULL | NetworkElement | true | false | false |
       |  | release | STRING | NULL | NetworkElement | true | false | false |
       |  | neProductVersion | STRING | NULL | NetworkElement | true | false | false |
      And ENABLE CM supervision for nodes in file MINI-LINK/SwSync_17AModelId
      And Start synchronization for nodes in file MINI-LINK/SwSync_17AModelId
      And Wait for CM sync status is PENDING in 65 seconds for each target in file MINI-LINK/SwSync_17AModelId
      And Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file MINI-LINK/SwSync_17AModelId
      And Wait for CM sync status is SYNCHRONIZED in 30 seconds for each target in file MINI-LINK/SwSync_17AModelId
     Then Verify attributes for nodes in file MINI-LINK/SwSync_17AModelId.
       | moFdn | name | type | value | rootMoType | mediated | suppressConstrains | throwsException |
       |  | ossModelIdentity | STRING | M17A-TN-6.0-LH-2.0 | NetworkElement | true | false | false |
       |  | nodeModelIdentity | STRING | NULL | NetworkElement | true | false | false |
       |  | release | STRING | NULL | NetworkElement | true | false | false |
       |  | neProductVersion | STRING | [{revision=R1A1, identity=CXP9010021/1}] | NetworkElement | true | false | false |

     When DISABLE CM supervision for nodes in file MINI-LINK/SwSync_17AModelId
     Then Wait for CM sync status is UNSYNCHRONIZED in 30 seconds for each target in file MINI-LINK/SwSync_17AModelId



   Scenario: Validate the Software Synchronization flow - No match: Software Sync is not possible due to not supported node type, node is not getting synchronized
     Given Licenses in file MINI-LINK/licenses
     Given NetworkElements in file MINI-LINK/SwSync_NoModelId
     And Initialize SNMP nodes from file MINI-LINK/SwSync_NoModelId
     And Start SNMP Agent Simulator for nodes
     And Initialize SNMP Agent Emulator for nodeIdentity="CXP000000_1" and nodeRevision="R32B123" for targets in file MINI-LINK/SwSync_NoModelId

     When Verify attributes for nodes in file MINI-LINK/SwSync_NoModelId.
       | moFdn | name | type | value | rootMoType | mediated | suppressConstrains | throwsException |
       |  | ossModelIdentity | STRING | NULL | NetworkElement | true | false | false |
       |  | nodeModelIdentity | STRING | NULL | NetworkElement | true | false | false |
       |  | release | STRING | NULL | NetworkElement | true | false | false |
       |  | neProductVersion | STRING | NULL | NetworkElement | true | false | false |
      And ENABLE CM supervision for nodes in file MINI-LINK/SwSync_NoModelId
      And Start synchronization for nodes in file MINI-LINK/SwSync_NoModelId
      And Wait for CM sync status is PENDING in 65 seconds for each target in file MINI-LINK/SwSync_NoModelId
      And Wait for CM sync status is UNSYNCHRONIZED in 30 seconds for each target in file MINI-LINK/SwSync_NoModelId
     Then Verify attributes for nodes in file MINI-LINK/SwSync_NoModelId.
       | moFdn | name | type | value | rootMoType | mediated | suppressConstrains | throwsException |
       |  | ossModelIdentity | STRING | NULL | NetworkElement | true | false | false |
       |  | nodeModelIdentity | STRING | NULL | NetworkElement | true | false | false |
       |  | release | STRING | NULL | NetworkElement | true | false | false |
       |  | neProductVersion | STRING | [{revision=R32B123, identity=CXP000000/1}] | NetworkElement | true | false | false |
      And DISABLE CM supervision for nodes in file MINI-LINK/SwSync_NoModelId

