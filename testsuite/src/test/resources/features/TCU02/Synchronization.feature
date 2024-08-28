@TCU02 @Sync @Netsim
Feature: TCU02 Cm Supervision management

   Scenario: Manual Synchronization
     Given NetworkElements in file TCU02/CmSupervision
     When  ENABLE CM supervision for nodes in file TCU02/CmSupervision
     Given Smrs Server
     | userName      | homeDirectory                    | relativePath |
     | root          | /home/smrs/smrsroot/cm_models/   | /            |
     Then Wait for CM sync status is SYNCHRONIZED in 120 seconds for each target in file TCU02/CmSupervision

     When Start synchronization for nodes in file TCU02/CmSupervision
      And Wait for CM sync status is SYNCHRONIZED in 120 seconds for each target in file TCU02/CmSupervision

     When  DISABLE CM supervision for nodes in file TCU02/CmSupervision
     Then  Wait 1 AVC in 60 seconds for each target in file TCU02/CmSupervision
      And  Sync status is UNSYNCHRONIZED for targets in file TCU02/CmSupervision