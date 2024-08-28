@ignore @RADIONODE @Sync @Netsim
Feature: RADIONODE Cm Synchronization management

   Scenario: Manual Synchronization
     Given Licenses in file RADIONODE/licenses
     Given NetworkElements in file RADIONODE/CmSupervision
     When Start synchronization for nodes in file RADIONODE/CmSupervision
     Then Wait 2 AVC in 60 seconds for each target in file RADIONODE/CmSupervision
      And Sync status is SYNCHRONIZED for targets in file RADIONODE/CmSupervision

      
