#Waiting for netsim docker image fix on HLRFE-BSPNODE

@ignore @HLRFE-BSP @Supervision @Netsim
Feature: HLRFE-BSP Cm Supervision management

   @ignore
   Scenario: Validate Supervision and Synchronization flows
     Given Licenses in file HLRFE/licenses
     Given NetworkElements in file HLRFE-BSP/CmSupervision
     When  ENABLE CM supervision for nodes in file HLRFE-BSP/CmSupervision
     Then  Wait 3 AVC in 400 seconds for each target in file HLRFE-BSP/CmSupervision
      And  Sync status is SYNCHRONIZED for targets in file HLRFE-BSP/CmSupervision

     When Start synchronization for nodes in file HLRFE-BSP/CmSupervision
     Then Wait for CM sync status is PENDING in 30 seconds for each target in file HLRFE-BSP/CmSupervision
      And Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file HLRFE-BSP/CmSupervision
      And Wait for CM sync status is SYNCHRONIZED in 240 seconds for each target in file HLRFE-BSP/CmSupervision     

     When  DISABLE CM supervision for nodes in file HLRFE-BSP/CmSupervision
     Then  Wait 2 AVC in 60 seconds for each target in file HLRFE-BSP/CmSupervision
      And  Sync status is UNSYNCHRONIZED for targets in file HLRFE-BSP/CmSupervision

   Scenario: Validate Supervision and Synchronization flows with MeContext
     Given Licenses in file HLRFE/licenses
     Given NetworkElements in file HLRFE-BSP/CmSupervisionWithMeContext
     When  ENABLE CM supervision for nodes in file HLRFE-BSP/CmSupervisionWithMeContext
     Then  Wait 3 AVC in 400 seconds for each target in file HLRFE-BSP/CmSupervisionWithMeContext
      And  Sync status is SYNCHRONIZED for targets in file HLRFE-BSP/CmSupervisionWithMeContext

     When  DISABLE CM supervision for nodes in file HLRFE-BSP/CmSupervisionWithMeContext
     Then  Wait 2 AVC in 60 seconds for each target in file HLRFE-BSP/CmSupervisionWithMeContext
      And  Sync status is UNSYNCHRONIZED for targets in file HLRFE-BSP/CmSupervisionWithMeContext