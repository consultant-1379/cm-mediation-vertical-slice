@juniperTest @JUNIPER-SRX @Sync @Netsim
Feature: JUNIPER-SRX Cm Synchronization management

   Scenario: Manual Synchronization
     Given Licenses in file JUNIPER-SRX/licenses
     Given NetworkElements in file JUNIPER-SRX/CmSupervision
     When ENABLE CM supervision for nodes in file JUNIPER-SRX/CmSupervision
     Then  Wait 3 AVC in 240 seconds for each target in file JUNIPER-SRX/CmSupervision
     And  Sync status is SYNCHRONIZED for targets in file JUNIPER-SRX/CmSupervision

     When Start synchronization for nodes in file JUNIPER-SRX/CmSupervision
     Then Wait 2 AVC in 240 seconds for each target in file JUNIPER-SRX/CmSupervision
      And Sync status is SYNCHRONIZED for targets in file JUNIPER-SRX/CmSupervision
