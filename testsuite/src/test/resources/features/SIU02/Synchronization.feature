@SIU02 @Sync @Netsim
Feature: SIU02 Cm Supervision management

   Scenario: Manual Synchronization
     Given NetworkElements in file SIU02/CmSupervision
     When  ENABLE CM supervision for nodes in file SIU02/CmSupervision
     Given Smrs Server
     | userName      | homeDirectory                    | relativePath |
     | root          | /home/smrs/smrsroot/cm_models/   | /            |
     Then Wait for CM sync status is SYNCHRONIZED in 120 seconds for each target in file SIU02/CmSupervision

     When Start synchronization for nodes in file SIU02/CmSupervision
      And Wait for CM sync status is SYNCHRONIZED in 120 seconds for each target in file SIU02/CmSupervision

     When  DISABLE CM supervision for nodes in file SIU02/CmSupervision
     Then  Wait 1 AVC in 60 seconds for each target in file SIU02/CmSupervision
      And  Sync status is UNSYNCHRONIZED for targets in file SIU02/CmSupervision