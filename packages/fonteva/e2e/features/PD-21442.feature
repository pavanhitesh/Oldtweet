@REQ_PD-21442
Feature: Unable to cancel pending subscriptions
	#*CS Note:*
	#
	#Go live blocker for APA
	#
	#*Reproduced by* Jason Orr in 2018.2.0.20
	#
	#*Reference Case#*[00018311|https://fonteva.my.salesforce.com/5003A00000xR93IQAS]
	#
	#*Description:*
	#
	#When a membership is in a pending status with a future start date, the system allows you to select 'is cancelled' to cancel, but will revert to a pending status with any dummy edit.
	#
	#*Steps to Reproduce:*
	#
	#* Create a Sales Order with any subscription
	#* Set the subscription start date to be in the future so the status is 'Pending'
	#* Close and post
	#* Go to subscription detail, select 'is cancelled' checkbox ->will save with a new status of 'Cancelled'
	#* Select edit and save -> subscription reverts to a pending status
	#
	#*Actual Results:*
	#
	#The subscription reverts to a pending status.
	#
	#*Expected Results:*
	#
	#The subscription should stay in a cancelled status.

	#Tests *CS Note:*
	#
	#Go live blocker for APA
	#
	#*Reproduced by* Jason Orr in 2018.2.0.20
	#
	#*Reference Case#*[00018311|https://fonteva.my.salesforce.com/5003A00000xR93IQAS]
	#
	#*Description:*
	#
	#When a membership is in a pending status with a future start date, the system allows you to select 'is cancelled' to cancel, but will revert to a pending status with any dummy edit.
	#
	#*Steps to Reproduce:*
	#
	#* Create a Sales Order with any subscription
	#* Set the subscription start date to be in the future so the status is 'Pending'
	#* Close and post
	#* Go to subscription detail, select 'is cancelled' checkbox ->will save with a new status of 'Cancelled'
	#* Select edit and save -> subscription reverts to a pending status
	#
	#*Actual Results:*
	#
	#The subscription reverts to a pending status.
	#
	#*Expected Results:*
	#
	#The subscription should stay in a cancelled status.
 @REQ_PD-21442 @TEST_PD-27171 @regression @21Winter @22Winter @akash
 Scenario: Test Unable to cancel pending subscriptions
  Given User will select "Daniela Brown" contact
  And User opens the Rapid Order Entry page from contact
  And User should be able to add "AutoTermedPlan" item on rapid order entry
  And User should update the subscription start date to "12/12/2029" future date
  And User should close and post the sales order
  Then User should check isCancelled checkbox and verify the subscription is in "Cancelled" status
	

