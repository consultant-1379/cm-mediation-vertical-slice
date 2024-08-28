@SGSN-MME @Notification @NetconfServer
Feature: SGSN-MME Cm Notification management

   Scenario: Validate Supervision and Synchronization flows
     Given Licenses in file SGSN-MME/licenses
     Given NetworkElements in file SGSN-MME/CmNotification
     When  ENABLE CM supervision for nodes in file SGSN-MME/CmNotification
     Then  Wait 3 AVC in 300 seconds for each target in file SGSN-MME/CmNotification
      And  Sync status is SYNCHRONIZED for targets in file SGSN-MME/CmNotification

     When  DISABLE CM supervision for nodes in file SGSN-MME/CmNotification
     Then  Wait 1 AVC in 60 seconds for each target in file SGSN-MME/CmNotification
      And  Sync status is UNSYNCHRONIZED for targets in file SGSN-MME/CmNotification

