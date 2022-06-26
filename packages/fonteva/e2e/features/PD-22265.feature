@REQ_PD-22265
Feature: Terms in grace period for renewed subscription is being set to active
	#*CS Note:*
	#
	#Behavior changed from alternating between active and inactive to just being active when patch for T1-2879 was released in 2019.1.0.13
	#
	#*Reproduced by* Eli Nesson in 2019.1.0.13
	#
	#*Reference Case#*[00019232|https://fonteva.my.salesforce.com/5003A00000yGCuMQAW]
	#
	#*Description:*
	#
	#On a renewed subscription that has an active term, but the pervious term is still in grace period, both terms are set to "Is Active" = TRUE.
	#
	#*Steps to Reproduce:*
	#
	## Create a subscription with a term where the Term End Date has passed, but the Grace Period End Date is not passed.
	## Renew the subscription
	#
	#*Actual Results:*
	#
	#Both the new term and the old term are active.
	#
	#https://screencast.com/t/pDDW8jwwDuOi
	#
	#*Expected Results:*
	#
	#The new term is active, and the old term is inactive.
	#
	#*PM NOTE:*
	#
	#The issue is: TermBatchablle picks up the record again during the night and activates again bc the grace period end date still in the future, so the fix is when we renew, immediately update the grace period end date as today/
	#
	#QA pls also test this ticket PD-13669

	#Tests *CS Note:*
	#
	#Behavior changed from alternating between active and inactive to just being active when patch for T1-2879 was released in 2019.1.0.13
	#
	#*Reproduced by* Eli Nesson in 2019.1.0.13
	#
	#*Reference Case#*[00019232|https://fonteva.my.salesforce.com/5003A00000yGCuMQAW]
	#
	#*Description:*
	#
	#On a renewed subscription that has an active term, but the pervious term is still in grace period, both terms are set to "Is Active" = TRUE.
	#
	#*Steps to Reproduce:*
	#
	## Create a subscription with a term where the Term End Date has passed, but the Grace Period End Date is not passed.
	## Renew the subscription
	#
	#*Actual Results:*
	#
	#Both the new term and the old term are active.
	#
	#https://screencast.com/t/pDDW8jwwDuOi
	#
	#*Expected Results:*
	#
	#The new term is active, and the old term is inactive.
	#
	#*PM NOTE:*
	#
	#The issue is: TermBatchablle picks up the record again during the night and activates again bc the grace period end date still in the future, so the fix is when we renew, immediately update the grace period end date as today/
	#
	#QA pls also test this ticket PD-13669
 @REQ_PD-22265 @TEST_PD-27735 @regression @21Winter @22Winter @akash
 Scenario: Test Terms in grace period for renewed subscription is being set to active
  Given User will select "Daniela Brown" contact
  And User opens the Rapid Order Entry page from contact
  And User should be able to add "AutoTermedPlan" item on rapid order entry
  And User navigate to "apply payment" page for "AutoTermedPlan" item from rapid order entry
  And User should be able to apply payment for "AutoTermedPlan" item using "Credit Card" payment on apply payment page
  And User should update the term end date to the past date and renew the subscription
  And User should be able to apply payment for "AutoTermedPlan" item using "Credit Card" payment on apply payment page
  Then User should be able to verify new term date is active and old term date is inactive
   



