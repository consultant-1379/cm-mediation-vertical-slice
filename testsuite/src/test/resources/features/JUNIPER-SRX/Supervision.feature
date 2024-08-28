@juniperTest @JUNIPER-SRX @Supervision @Netsim
Feature: JUNIPER-SRX Cm Supervision management

   Scenario: Validate Supervision and Synchronization flows
     Given Licenses in file JUNIPER-SRX/licenses
     Given NetworkElements in file JUNIPER-SRX/CmSupervision
     When  ENABLE CM supervision for nodes in file JUNIPER-SRX/CmSupervision
     Then  Wait 3 AVC in 300 seconds for each target in file JUNIPER-SRX/CmSupervision
      And  Sync status is SYNCHRONIZED for targets in file JUNIPER-SRX/CmSupervision

     When  DISABLE CM supervision for nodes in file JUNIPER-SRX/CmSupervision
     Then  Wait 1 AVC in 300 seconds for each target in file JUNIPER-SRX/CmSupervision
      And  Sync status is UNSYNCHRONIZED for targets in file JUNIPER-SRX/CmSupervision
