@ignore @HLRFE @Sync @Netsim
Feature: HLRFE Cm Synchronization management

   Scenario: Manual Synchronization
     Given Licenses in file HLRFE/licenses
     Given NetworkElements in file HLRFE/CmSupervision
     When  ENABLE CM supervision for nodes in file HLRFE/CmSupervisionWithMeContext
     Then  Wait 3 AVC in 400 seconds for each target in file HLRFE/CmSupervision
      And  Sync status is SYNCHRONIZED for targets in file HLRFE/CmSupervision

      
