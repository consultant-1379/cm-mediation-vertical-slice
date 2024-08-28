#Waiting for netsim docker image fix on vHLRFENODE

@ignore @vHLRFE @Supervision @Netsim
Feature: vHLRFE Cm Supervision management

   @ignore
   Scenario: Validate Supervision and Synchronization flows
     Given Licenses in file HLRFE/licenses
     Given NetworkElements in file vHLRFE/CmSupervision
     When  ENABLE CM supervision for nodes in file vHLRFE/CmSupervision
     Then  Wait 3 AVC in 400 seconds for each target in file vHLRFE/CmSupervision
      And  Sync status is SYNCHRONIZED for targets in file vHLRFE/CmSupervision

     When Start synchronization for nodes in file vHLRFE/CmSupervision
     Then Wait for CM sync status is PENDING in 30 seconds for each target in file vHLRFE/CmSupervision
      And Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file vHLRFE/CmSupervision
      And Wait for CM sync status is SYNCHRONIZED in 240 seconds for each target in file vHLRFE/CmSupervision     

     When  DISABLE CM supervision for nodes in file vHLRFE/CmSupervision
     Then  Wait 2 AVC in 60 seconds for each target in file vHLRFE/CmSupervision
      And  Sync status is UNSYNCHRONIZED for targets in file vHLRFE/CmSupervision

   Scenario: Validate Supervision and Synchronization flows with MeContext
     Given Licenses in file HLRFE/licenses
     Given NetworkElements in file vHLRFE/CmSupervisionWithMeContext
     When  ENABLE CM supervision for nodes in file vHLRFE/CmSupervisionWithMeContext
     Then  Wait 3 AVC in 400 seconds for each target in file vHLRFE/CmSupervisionWithMeContext
      And  Sync status is SYNCHRONIZED for targets in file vHLRFE/CmSupervisionWithMeContext

     When  DISABLE CM supervision for nodes in file vHLRFE/CmSupervisionWithMeContext
     Then  Wait 2 AVC in 60 seconds for each target in file vHLRFE/CmSupervisionWithMeContext
      And  Sync status is UNSYNCHRONIZED for targets in file vHLRFE/CmSupervisionWithMeContext