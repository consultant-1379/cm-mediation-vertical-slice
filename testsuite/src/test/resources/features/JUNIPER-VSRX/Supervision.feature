@juniperTest @JUNIPER-VSRX @Supervision @Netsim
Feature: JUNIPER-VSRX Cm Supervision management

   Scenario: Validate Supervision and Synchronization flows
     Given Licenses in file JUNIPER-VSRX/licenses
     Given NetworkElements in file JUNIPER-VSRX/CmSupervision
     When  ENABLE CM supervision for nodes in file JUNIPER-VSRX/CmSupervision
     Then  Wait 3 AVC in 240 seconds for each target in file JUNIPER-VSRX/CmSupervision
      And  Sync status is SYNCHRONIZED for targets in file JUNIPER-VSRX/CmSupervision

     When  DISABLE CM supervision for nodes in file JUNIPER-VSRX/CmSupervision
     Then  Wait 1 AVC in 240 seconds for each target in file JUNIPER-VSRX/CmSupervision
      And  Sync status is UNSYNCHRONIZED for targets in file JUNIPER-VSRX/CmSupervision
