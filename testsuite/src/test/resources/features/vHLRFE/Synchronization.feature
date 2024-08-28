@ignore @vHLRFE @Sync @Netsim
Feature: vHLRFE Cm Synchronization management

   Scenario: Manual Synchronization
     Given Licenses in file HLRFE/licenses
     Given NetworkElements in file vHLRFE/CmSupervision
     When  ENABLE CM supervision for nodes in file vHLRFE/CmSupervisionWithMeContext
     Then  Wait 3 AVC in 400 seconds for each target in file vHLRFE/CmSupervision
      And  Sync status is SYNCHRONIZED for targets in file vHLRFE/CmSupervision