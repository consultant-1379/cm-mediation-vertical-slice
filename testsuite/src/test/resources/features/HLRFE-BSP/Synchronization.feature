@ignore @HLRFE-BSP @Sync @Netsim
Feature: HLRFE-BSP Cm Synchronization management

   Scenario: Manual Synchronization
     Given Licenses in file HLRFE/licenses
     Given NetworkElements in file HLRFE-BSP/CmSupervision
     When  ENABLE CM supervision for nodes in file HLRFE-BSP/CmSupervisionWithMeContext
     Then  Wait 3 AVC in 400 seconds for each target in file HLRFE-BSP/CmSupervision
      And  Sync status is SYNCHRONIZED for targets in file HLRFE-BSP/CmSupervision