@ignore @HLRFE-IS @Sync @Netsim
Feature: HLRFE-IS Cm Synchronization management

   Scenario: Manual Synchronization
     Given Licenses in file HLRFE/licenses
     Given NetworkElements in file HLRFE-IS/CmSupervision
     When  ENABLE CM supervision for nodes in file HLRFE-IS/CmSupervisionWithMeContext
     Then  Wait 3 AVC in 400 seconds for each target in file HLRFE-IS/CmSupervision
      And  Sync status is SYNCHRONIZED for targets in file HLRFE-IS/CmSupervision