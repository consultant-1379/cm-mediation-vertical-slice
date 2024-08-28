
@Fronthaul @Supervision
Feature: FRONTHAUL-6020 CM Synchronization management

   @ManualSync
   Scenario: Manual Synchronization
     Given Licenses in file FRONTHAUL/licenses
     Given NetworkElements in file FRONTHAUL-6020/CmSupervision

     When ENABLE CM supervision for nodes in file FRONTHAUL-6020/CmSupervision
     Then Wait for CM sync status is PENDING in 65 seconds for each target in file FRONTHAUL-6020/CmSupervision
      And Wait for CM sync status is SYNCHRONIZED in 60 seconds for each target in file FRONTHAUL-6020/CmSupervision     

     When DISABLE CM supervision for nodes in file FRONTHAUL-6020/CmSupervision
     Then Wait for CM sync status is UNSYNCHRONIZED in 30 seconds for each target in file FRONTHAUL-6020/CmSupervision

 
