@REQ_PD-23360
Feature: BLOCKED: Subscription: Expired date does not clear off after renewing an expired membership
	#*Case Reporter* Manjunath Ramachandra
	#
	#*Customer* Public Responsibility in Medicine and Research
	#
	#*Reproduced by* John Herrera in2019.1.0.17
	#
	#*Reference Case#* [00022679|https://fonteva.my.salesforce.com/5004V000010ilfKQAQ]
	#
	#*Description:*
	#
	#I have expired memberships setup without any post term renewal date setup on the subscription plan.
	#
	#So it can be renewed anytime after the subscription has expired.
	#
	#Once the expired subscription is renewed the expectation is to see the expired date clear off because the Subscription is active now.
	#
	#However, the expired date still stays after renewing it.
	#
	#*Steps to Reproduce:*
	#
	#* Create Subscription Plan (Term, Make sure Post Renewal Term in the blank). No Grace Period
	#* Create a Membership Item with $100
	#* Purchase membership item and go to term and manually change the date to expire and change the status to expired.
	#* Or find an expired membership in your GCO org and renew it. This is happening in GCO org as well.
	#
	#
	#
	#*Actual Results:*
	#
	#"Expired date" is not cleared off the Subscription after renewing, but the Subscription is Active.
	#
	#*Expected Results:*
	#
	#The expired date should be cleared after renewing the membership. Or if there is a reason to keep the expired date even after renewing please point me to the documentation so I can convey the same to the client.
	#
	#
	#
	#*T3 Notes:*
	#
	#To fix this, we need to set {{sub.Expired_Date__c = null}} in [OrderApi.SubscriptionService.setStatus()|https://github.com/Fonteva/orderapi/blob/21Winter/src/classes/SubscriptionService.cls#L226] method (when sub is active).
	#
	#See when the status is changing from “Expired “ to “Active“ then clean {{Expired_Date__c}} value.
	#
	#[~accountid:6076f91ac642ff0070f2e02a] to check with [~accountid:557058:fb8f97f1-b4ed-4c05-98e8-04370d1ee764] which method does the job for setting statuses on the services. [~accountid:557058:a7cfcee7-1932-4eb3-9fa6-457bb2a64887] thinks [OrderApi.SubscriptionService.setStatus()|https://github.com/Fonteva/orderapi/blob/21Winter/src/classes/SubscriptionService.cls#L226]  is already moved.
	#
	#
	#
	#h2. QA NOTE:
	#
	#update the auto for PD-13668

	#Tests *Case Reporter* Manjunath Ramachandra
	#
	#*Customer* Public Responsibility in Medicine and Research
	#
	#*Reproduced by* John Herrera in2019.1.0.17
	#
	#*Reference Case#* [00022679|https://fonteva.my.salesforce.com/5004V000010ilfKQAQ]
	#
	#*Description:*
	#
	#I have expired memberships setup without any post term renewal date setup on the subscription plan.
	#
	#So it can be renewed anytime after the subscription has expired.
	#
	#Once the expired subscription is renewed the expectation is to see the expired date clear off because the Subscription is active now.
	#
	#However, the expired date still stays after renewing it.
	#
	#*Steps to Reproduce:*
	#
	#* Create Subscription Plan (Term, Make sure Post Renewal Term in the blank). No Grace Period
	#* Create a Membership Item with $100
	#* Purchase membership item and go to term and manually change the date to expire and change the status to expired.
	#* Or find an expired membership in your GCO org and renew it. This is happening in GCO org as well.
	#
	#
	#
	#*Actual Results:*
	#
	#"Expired date" is not cleared off the Subscription after renewing, but the Subscription is Active.
	#
	#*Expected Results:*
	#
	#The expired date should be cleared after renewing the membership. Or if there is a reason to keep the expired date even after renewing please point me to the documentation so I can convey the same to the client.
	#
	#
	#
	#*T3 Notes:*
	#
	#To fix this, we need to set {{sub.Expired_Date__c = null}} in [OrderApi.SubscriptionService.setStatus()|https://github.com/Fonteva/orderapi/blob/21Winter/src/classes/SubscriptionService.cls#L226] method (when sub is active).
	#
	#See when the status is changing from “Expired “ to “Active“ then clean {{Expired_Date__c}} value.
	#
	#[~accountid:6076f91ac642ff0070f2e02a] to check with [~accountid:557058:fb8f97f1-b4ed-4c05-98e8-04370d1ee764] which method does the job for setting statuses on the services. [~accountid:557058:a7cfcee7-1932-4eb3-9fa6-457bb2a64887] thinks [OrderApi.SubscriptionService.setStatus()|https://github.com/Fonteva/orderapi/blob/21Winter/src/classes/SubscriptionService.cls#L226]  is already moved.
	#
	#
	#
	#h2. QA NOTE:
	#
	#update the auto for PD-13668
	@REQ_PD-23360 @TEST_PD-28991 @21Winter @22Winter @regression @svinjamuri
	Scenario: Subscription: Expired date does not clear off after renewing an expired membership
		Given User will select "Etta Brown" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoTermedInvoicePlan" item on rapid order entry
		And User navigate to "apply payment" page for "AutoTermedInvoicePlan" item from rapid order entry
		Then User should be able to apply payment for "AutoTermedInvoicePlan" item using "Credit Card" payment on apply payment page
		And User expires the subscription by updating date and verifies term status
		And User navigate to community Portal page with "ettabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User will select the "Subscriptions" page in LT Portal
		Then User should be able to renew the "expired" subscription "AutoTermedInvoicePlan"
		And User verifies the expired date is not showing for expired subscription
