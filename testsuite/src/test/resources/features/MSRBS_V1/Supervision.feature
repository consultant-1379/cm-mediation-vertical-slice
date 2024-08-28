@MSRBS_V1 @Supervision @NetconfServer
Feature: MSRBS_V1 Cm Supervision management

   Scenario: Validate Supervision and Synchronization flows
     Given Licenses in file MSRBS_V1/licenses
     Given NetworkElements in file MSRBS_V1/CmSupervision
     When  ENABLE CM supervision for nodes in file MSRBS_V1/CmSupervision
     Then  Wait 3 AVC in 240 seconds for each target in file MSRBS_V1/CmSupervision
      And  Sync status is SYNCHRONIZED for targets in file MSRBS_V1/CmSupervision
     
     When Start synchronization for nodes in file MSRBS_V1/CmSupervision
     Then Wait for CM sync status is PENDING in 30 seconds for each target in file MSRBS_V1/CmSupervision
      And Wait for CM sync status is TOPOLOGY in 30 seconds for each target in file MSRBS_V1/CmSupervision
      And Wait for CM sync status is SYNCHRONIZED in 180 seconds for each target in file MSRBS_V1/CmSupervision     

     When  DISABLE CM supervision for nodes in file MSRBS_V1/CmSupervision
     Then  Wait 2 AVC in 60 seconds for each target in file MSRBS_V1/CmSupervision
      And  Sync status is UNSYNCHRONIZED for targets in file MSRBS_V1/CmSupervision

