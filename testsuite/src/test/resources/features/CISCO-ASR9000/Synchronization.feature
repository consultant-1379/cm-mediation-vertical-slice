@ignore @CISCO-ASR9000 @Sync @Netsim
Feature: CISCO-ASR9000 Cm Synchronization management

   Scenario: Manual Synchronization
     Given Licenses in file CISCO-ASR9000/licenses
     Given NetworkElements in file CISCO-ASR9000/CmSupervision
     When Start synchronization for nodes in file CISCO-ASR9000/CmSupervision
     Then Wait 2 AVC in 60 seconds for each target in file CISCO-ASR9000/CmSupervision
      And Sync status is SYNCHRONIZED for targets in file CISCO-ASR9000/CmSupervision
  
