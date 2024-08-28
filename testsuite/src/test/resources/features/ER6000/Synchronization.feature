@ER6000 @Sync @Netsim
Feature: ER6000 Cm Synchronization management

   Scenario: Manual Synchronization
     Given Licenses in file ER6000/licenses
     Given NetworkElements in file ER6000/CmSupervision
     When ENABLE CM supervision for nodes in file ER6000/CmSupervision
     Then  Wait 3 AVC in 240 seconds for each target in file ER6000/CmSupervision
     And  Sync status is SYNCHRONIZED for targets in file ER6000/CmSupervision

     When Start synchronization for nodes in file ER6000/CmSupervision
     Then Wait for CM sync status is PENDING in 30 seconds for each target in file ER6000/CmSupervision
      And Wait for CM sync status is SYNCHRONIZED in 180 seconds for each target in file ER6000/CmSupervision

     When DISABLE CM supervision for nodes in file ER6000/CmSupervision
     Then  Wait 1 AVC in 60 seconds for each target in file ER6000/CmSupervision
     And  Sync status is UNSYNCHRONIZED for targets in file ER6000/CmSupervision