@SGSN-MME @Supervision @Netsim
Feature: SGSN-MME Cm Supervision management

   Scenario: Validate Supervision and Synchronization flows
     Given Licenses in file SGSN-MME/licenses
     Given NetworkElements in file SGSN-MME/CmSupervision
     When  ENABLE CM supervision for nodes in file SGSN-MME/CmSupervision
     Then  Wait 3 AVC in 300 seconds for each target in file SGSN-MME/CmSupervision
      And  Sync status is SYNCHRONIZED for targets in file SGSN-MME/CmSupervision

     When  DISABLE CM supervision for nodes in file SGSN-MME/CmSupervision
     Then  Wait 1 AVC in 60 seconds for each target in file SGSN-MME/CmSupervision
      And  Sync status is UNSYNCHRONIZED for targets in file SGSN-MME/CmSupervision

