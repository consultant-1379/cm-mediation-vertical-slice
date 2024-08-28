@juniperTest @JUNIPER-VSRX @Sync @Netsim
Feature: JUNIPER-VSRX Cm Synchronization management

   Scenario: Manual Synchronization
     Given Licenses in file JUNIPER-VSRX/licenses
     Given NetworkElements in file JUNIPER-VSRX/CmSupervision
     When ENABLE CM supervision for nodes in file JUNIPER-VSRX/CmSupervision
     Then  Wait 3 AVC in 240 seconds for each target in file JUNIPER-VSRX/CmSupervision
     And  Sync status is SYNCHRONIZED for targets in file JUNIPER-VSRX/CmSupervision
     
     When Start synchronization for nodes in file JUNIPER-VSRX/CmSupervision
     Then Wait 2 AVC in 240 seconds for each target in file JUNIPER-VSRX/CmSupervision
      And Sync status is SYNCHRONIZED for targets in file JUNIPER-VSRX/CmSupervision
