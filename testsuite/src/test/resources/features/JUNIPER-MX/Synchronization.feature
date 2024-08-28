@juniperTest @JUNIPER-MX @Sync @Netsim
Feature: JUNIPER-MX Cm Synchronization management

   Scenario: Manual Synchronization
     Given Licenses in file JUNIPER-MX/licenses
     Given NetworkElements in file JUNIPER-MX/CmSupervision
     When ENABLE CM supervision for nodes in file JUNIPER-MX/CmSupervision
     Then  Wait 3 AVC in 240 seconds for each target in file JUNIPER-MX/CmSupervision
     And  Sync status is SYNCHRONIZED for targets in file JUNIPER-MX/CmSupervision
     
     When Start synchronization for nodes in file JUNIPER-MX/CmSupervision
     Then Wait 2 AVC in 240 seconds for each target in file JUNIPER-MX/CmSupervision
      And Sync status is SYNCHRONIZED for targets in file JUNIPER-MX/CmSupervision
