@RADIONODE @Notification @NetconfServer
Feature: RADIONODE Cm Notification management

   Scenario: Validate Supervision and Synchronization flows
     Given Licenses in file RADIONODE/licenses
     Given NetworkElements in file RADIONODE/CmNotification
     When  ENABLE CM supervision for nodes in file RADIONODE/CmNotification
     Then  Wait 3 AVC in 240 seconds for each target in file RADIONODE/CmNotification
      And  Sync status is SYNCHRONIZED for targets in file RADIONODE/CmNotification
     
     When Start synchronization for nodes in file RADIONODE/CmNotification
     Then Wait for CM sync status is PENDING in 30 seconds for each target in file RADIONODE/CmNotification
      And Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file RADIONODE/CmNotification
      And Wait for CM sync status is SYNCHRONIZED in 180 seconds for each target in file RADIONODE/CmNotification     

     When  DISABLE CM supervision for nodes in file RADIONODE/CmNotification
     Then  Wait 2 AVC in 60 seconds for each target in file RADIONODE/CmNotification
      And  Sync status is UNSYNCHRONIZED for targets in file RADIONODE/CmNotification

