@ignore @CISCO-ASR900 @Supervision
Feature: CISCO-ASR900 Cm Supervision management

   Scenario: Validate Supervision and Synchronization flows
     Given Licenses in file CISCO-ASR900/licenses
     Given NetworkElements in file CISCO-ASR900/CmSupervision
     When  ENABLE CM supervision for nodes in file CISCO-ASR900/CmSupervision
     Then  Wait 2 AVC in 60 seconds for each target in file CISCO-ASR900/CmSupervision
      And  Sync status is SYNCHRONIZED for targets in file CISCO-ASR900/CmSupervision

     When  DISABLE CM supervision for nodes in file CISCO-ASR900/CmSupervision
     Then  Wait 1 AVC in 60 seconds for each target in file CISCO-ASR900/CmSupervision
      And  Sync status is UNSYNCHRONIZED for targets in file CISCO-ASR900/CmSupervision
