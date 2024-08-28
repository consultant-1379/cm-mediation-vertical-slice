@juniperTest @JUNIPER-PTX @Supervision @Netsim
Feature: JUNIPER-PTX Cm Supervision management

   Scenario: Validate Supervision and Synchronization flows
     Given Licenses in file JUNIPER-PTX/licenses
     Given NetworkElements in file JUNIPER-PTX/CmSupervision
     When  ENABLE CM supervision for nodes in file JUNIPER-PTX/CmSupervision
     Then  Wait 3 AVC in 300 seconds for each target in file JUNIPER-PTX/CmSupervision
      And  Sync status is SYNCHRONIZED for targets in file JUNIPER-PTX/CmSupervision

     When  DISABLE CM supervision for nodes in file JUNIPER-PTX/CmSupervision
     Then  Wait 1 AVC in 300 seconds for each target in file JUNIPER-PTX/CmSupervision
      And  Sync status is UNSYNCHRONIZED for targets in file JUNIPER-PTX/CmSupervision
