@ignore @vHLRFE @Notification @NetconfServer
Feature: vHLRFE Cm Notification management

   Scenario: Validate Supervision and Synchronization flows
     Given Licenses in file HLRFE/licenses
     Given NetworkElements in file vHLRFE/CmNotification
     When  ENABLE CM supervision for nodes in file vHLRFE/CmNotification
     Then  Wait 3 AVC in 240 seconds for each target in file vHLRFE/CmNotification
      And  Sync status is SYNCHRONIZED for targets in file vHLRFE/CmNotification

     When Start synchronization for nodes in file vHLRFE/CmNotification
     Then Wait for CM sync status is PENDING in 30 seconds for each target in file vHLRFE/CmNotification
      And Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file vHLRFE/CmNotification
      And Wait for CM sync status is SYNCHRONIZED in 180 seconds for each target in file vHLRFE/CmNotification     

     When  DISABLE CM supervision for nodes in file vHLRFE/CmNotification
     Then  Wait 2 AVC in 60 seconds for each target in file vHLRFE/CmNotification
      And  Sync status is UNSYNCHRONIZED for targets in file vHLRFE/CmNotification