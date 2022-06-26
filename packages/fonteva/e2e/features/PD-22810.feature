@REQ_PD-22810
Feature: An issue with Inactive membership and Renewal on LT Portal
	#*CS Note:*
	#
	#In the 2018.1.0.14 we had a validation displayed which is not a case anymore
	#
	#*Reproduced by* Ewa Imtiaz in 2019.1.0.18
	#
	#*Reference Case#*[00021658|https://fonteva.my.salesforce.com/5003A00000zYxZmQAK]
	#
	#*Description:*
	#
	#null
	#
	#*Steps to Reproduce:*
	#
	## Find a contact who has a subscription configure/due for renewal
	## Uncheck the checkbox for Active on a subscription item *(The Item is NOT active, but subscription is still active)*
	## Navigate to the portal as an authenticated user
	##  Attempt to renew the subscription
	#
	#*Actual Results:*
	#
	#No validation was displayed. In the CPBase community user is redirected to different membership (Renewal Path not configured), in LT community blank containers are displayed
	#
	#*Expected Results:*
	#
	#Validation displayed for user that the item is not available for renewal.
	#
	#2018R1 version had validation
	#
	#
	#
	#*PM NOTE:*
	#
	#See if there is any validation rule already created for inactive items. if yes use that one do not let the user to renew.
	#
	#if no validation rule is introduced. disable the renew button. 
	#
	#Let’s handle this on the UI, not services.
	#
	#developer to let [~accountid:557058:a7cfcee7-1932-4eb3-9fa6-457bb2a64887] know about the findings so we can make the call regarding disabling button / show a validation rule. 
	#
	#the issue is we cannot introduce. a new validation rule since it is a patch branch.
	#
	#if there is a validation rule, pls share with QA via comment

	#Tests *CS Note:*
	#
	#In the 2018.1.0.14 we had a validation displayed which is not a case anymore
	#
	#*Reproduced by* Ewa Imtiaz in 2019.1.0.18
	#
	#*Reference Case#*[00021658|https://fonteva.my.salesforce.com/5003A00000zYxZmQAK]
	#
	#*Description:*
	#
	#null
	#
	#*Steps to Reproduce:*
	#
	## Find a contact who has a subscription configure/due for renewal
	## Uncheck the checkbox for Active on a subscription item *(The Item is NOT active, but subscription is still active)*
	## Navigate to the portal as an authenticated user
	##  Attempt to renew the subscription
	#
	#*Actual Results:*
	#
	#No validation was displayed. In the CPBase community user is redirected to different membership (Renewal Path not configured), in LT community blank containers are displayed
	#
	#*Expected Results:*
	#
	#Validation displayed for user that the item is not available for renewal.
	#
	#2018R1 version had validation
	#
	#
	#
	#*PM NOTE:*
	#
	#See if there is any validation rule already created for inactive items. if yes use that one do not let the user to renew.
	#
	#if no validation rule is introduced. disable the renew button. 
	#
	#Let’s handle this on the UI, not services.
	#
	#developer to let [~accountid:557058:a7cfcee7-1932-4eb3-9fa6-457bb2a64887] know about the findings so we can make the call regarding disabling button / show a validation rule. 
	#
	#the issue is we cannot introduce. a new validation rule since it is a patch branch.
	#
	#if there is a validation rule, pls share with QA via comment
	@REQ_PD-22810 @TEST_PD-28975 @regression @21Winter @22Winter @sophiya
	Scenario: Test An issue with Inactive membership and Renewal on LT Portal
		Given User will select "David Brown" contact
		When User opens the Rapid Order Entry page from contact
		And User should be able to add "autoSubscriptionItem" item on rapid order entry
		And User navigate to "apply payment" page for "autoSubscriptionItem" item from rapid order entry
		And User should be able to apply payment for "autoSubscriptionItem" item using "Credit Card" payment on apply payment page
		And User navigate to community Portal page with "davidbrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User will select the "Subscriptions" page in LT Portal
		And User verifies the renew button is "displayed" in active subscription
		Then User updates the item as inactive
		And User verifies the renew button is "absent" in active subscription
