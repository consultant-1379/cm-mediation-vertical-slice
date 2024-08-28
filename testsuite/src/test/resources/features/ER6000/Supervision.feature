@ER6000 @Supervision @Netsim
Feature: ER6000 Cm Supervision management

   Scenario: Validate Supervision and Synchronization flows
     Given Licenses in file ER6000/licenses
     Given NetworkElements in file ER6000/CmSupervision
     When ENABLE CM supervision for nodes in file ER6000/CmSupervision
     Then  Wait 3 AVC in 240 seconds for each target in file ER6000/CmSupervision
     And  Sync status is SYNCHRONIZED for targets in file ER6000/CmSupervision

     When DISABLE CM supervision for nodes in file ER6000/CmSupervision
     Then  Wait 1 AVC in 60 seconds for each target in file ER6000/CmSupervision
     And  Sync status is UNSYNCHRONIZED for targets in file ER6000/CmSupervision