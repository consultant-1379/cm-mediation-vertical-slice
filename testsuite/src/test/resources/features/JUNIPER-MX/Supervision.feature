@juniperTest @JUNIPER-MX @Supervision @Netsim
Feature: JUNIPER-MX Cm Supervision management

   Scenario: Validate Supervision and Synchronization flows
     Given Licenses in file JUNIPER-MX/licenses
     Given NetworkElements in file JUNIPER-MX/CmSupervision
     When  ENABLE CM supervision for nodes in file JUNIPER-MX/CmSupervision
     Then  Wait 3 AVC in 240 seconds for each target in file JUNIPER-MX/CmSupervision
      And  Sync status is SYNCHRONIZED for targets in file JUNIPER-MX/CmSupervision

     When  DISABLE CM supervision for nodes in file JUNIPER-MX/CmSupervision
     Then  Wait 1 AVC in 240 seconds for each target in file JUNIPER-MX/CmSupervision
      And  Sync status is UNSYNCHRONIZED for targets in file JUNIPER-MX/CmSupervision
