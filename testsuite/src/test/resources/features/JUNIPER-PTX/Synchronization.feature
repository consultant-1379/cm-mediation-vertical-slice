@juniperTest @JUNIPER-PTX @Sync @Netsim
Feature: JUNIPER-PTX Cm Synchronization management

   Scenario: Manual Synchronization
     Given Licenses in file JUNIPER-PTX/licenses
     Given NetworkElements in file JUNIPER-PTX/CmSupervision
     When ENABLE CM supervision for nodes in file JUNIPER-PTX/CmSupervision
     Then  Wait 3 AVC in 300 seconds for each target in file JUNIPER-PTX/CmSupervision
     And  Sync status is SYNCHRONIZED for targets in file JUNIPER-PTX/CmSupervision
   
     When Start synchronization for nodes in file JUNIPER-PTX/CmSupervision
     Then Wait 2 AVC in 300 seconds for each target in file JUNIPER-PTX/CmSupervision
      And Sync status is SYNCHRONIZED for targets in file JUNIPER-PTX/CmSupervision
