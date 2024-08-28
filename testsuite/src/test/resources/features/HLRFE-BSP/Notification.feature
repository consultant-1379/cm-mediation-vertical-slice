@ignore @HLRFE-BSP @Notification @NetconfServer
Feature: HLRFE-BSP Cm Notification management

   Scenario: Validate Supervision and Synchronization flows
     Given Licenses in file HLRFE/licenses
     Given NetworkElements in file HLRFE-BSP/CmNotification
     When  ENABLE CM supervision for nodes in file HLRFE-BSP/CmNotification
     Then  Wait 3 AVC in 240 seconds for each target in file HLRFE-BSP/CmNotification
      And  Sync status is SYNCHRONIZED for targets in file HLRFE-BSP/CmNotification

     When Start synchronization for nodes in file HLRFE-BSP/CmNotification
     Then Wait for CM sync status is PENDING in 30 seconds for each target in file HLRFE-BSP/CmNotification
      And Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file HLRFE-BSP/CmNotification
      And Wait for CM sync status is SYNCHRONIZED in 180 seconds for each target in file HLRFE-BSP/CmNotification     

     When  DISABLE CM supervision for nodes in file HLRFE-BSP/CmNotification
     Then  Wait 2 AVC in 60 seconds for each target in file HLRFE-BSP/CmNotification
      And  Sync status is UNSYNCHRONIZED for targets in file HLRFE-BSP/CmNotification