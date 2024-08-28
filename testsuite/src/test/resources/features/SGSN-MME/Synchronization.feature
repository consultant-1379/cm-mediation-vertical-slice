@ignore @SGSN-MME @Sync @Netsim
Feature: SGSN-MME Cm Synchronization management

   Scenario: Manual Synchronization
     Given Licenses in file SGSN-MME/licenses
     Given NetworkElements in file SGSN-MME/CmSupervision
     When Start synchronization for nodes in file SGSN-MME/CmSupervision
     Then Wait 2 AVC in 180 seconds for each target in file SGSN-MME/CmSupervision
      And Sync status is SYNCHRONIZED for targets in file SGSN-MME/CmSupervision