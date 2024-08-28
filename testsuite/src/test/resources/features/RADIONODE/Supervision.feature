#Waiting for netsim docker image fix on RadioNode
@ignore
@RADIONODE @Supervision @Netsim
Feature: RADIONODE Cm Supervision management

   @ignore
   Scenario: Validate Supervision and Synchronization flows
     Given Licenses in file RADIONODE/licenses
     Given NetworkElements in file RADIONODE/CmSupervision
     When  ENABLE CM supervision for nodes in file RADIONODE/CmSupervision
     Then  Wait 3 AVC in 400 seconds for each target in file RADIONODE/CmSupervision
      And  Sync status is SYNCHRONIZED for targets in file RADIONODE/CmSupervision
     
     When Start synchronization for nodes in file RADIONODE/CmSupervision
     Then Wait for CM sync status is PENDING in 30 seconds for each target in file RADIONODE/CmSupervision
      And Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file RADIONODE/CmSupervision
      And Wait for CM sync status is SYNCHRONIZED in 240 seconds for each target in file RADIONODE/CmSupervision     

     When  DISABLE CM supervision for nodes in file RADIONODE/CmSupervision
     Then  Wait 2 AVC in 60 seconds for each target in file RADIONODE/CmSupervision
      And  Sync status is UNSYNCHRONIZED for targets in file RADIONODE/CmSupervision

   Scenario: Validate Supervision and Synchronization flows with MeContext
     Given Licenses in file RADIONODE/licenses
     Given NetworkElements in file RADIONODE/CmSupervisionWithMeContext
     When  ENABLE CM supervision for nodes in file RADIONODE/CmSupervisionWithMeContext
     Then  Wait 3 AVC in 400 seconds for each target in file RADIONODE/CmSupervisionWithMeContext
      And  Sync status is SYNCHRONIZED for targets in file RADIONODE/CmSupervisionWithMeContext

     When  DISABLE CM supervision for nodes in file RADIONODE/CmSupervisionWithMeContext
     Then  Wait 2 AVC in 60 seconds for each target in file RADIONODE/CmSupervisionWithMeContext
      And  Sync status is UNSYNCHRONIZED for targets in file RADIONODE/CmSupervisionWithMeContext

