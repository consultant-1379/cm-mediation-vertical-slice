@juniperTest @CISCO-ASR9000 @Supervision @Netsim
Feature: CISCO-ASR9000 Cm Supervision management

   Scenario: Validate Supervision and Synchronization flows
     Given Licenses in file CISCO-ASR9000/licenses
     Given NetworkElements in file CISCO-ASR9000/CmSupervision
     When  ENABLE CM supervision for nodes in file CISCO-ASR9000/CmSupervision
     Then  Wait 3 AVC in 120 seconds for each target in file CISCO-ASR9000/CmSupervision
      And  Sync status is SYNCHRONIZED for targets in file CISCO-ASR9000/CmSupervision

     When  DISABLE CM supervision for nodes in file CISCO-ASR9000/CmSupervision
     Then  Wait 1 AVC in 60 seconds for each target in file CISCO-ASR9000/CmSupervision
      And  Sync status is UNSYNCHRONIZED for targets in file CISCO-ASR9000/CmSupervision
