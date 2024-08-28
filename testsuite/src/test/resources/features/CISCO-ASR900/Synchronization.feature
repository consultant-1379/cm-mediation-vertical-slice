@ignore @CISCO-ASR900 @Sync
Feature: CISCO-ASR900 Cm Synchronization management

   Scenario: Manual Synchronization
     Given Licenses in file CISCO-ASR900/licenses
     Given NetworkElements in file CISCO-ASR900/CmSupervision
     When Start synchronization for nodes in file CISCO-ASR900/CmSupervision
     Then Wait 2 AVC in 60 seconds for each target in file CISCO-ASR900/CmSupervision
      And Sync status is SYNCHRONIZED for targets in file CISCO-ASR900/CmSupervision
