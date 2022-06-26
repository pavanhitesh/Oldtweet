@REQ_PD-27911
Feature: Incorrect date range on subscription renewals

	#Tests *Case Reporter* James Paul
	#
	#*Customer* Alabama Farmers Federation
	#
	#*Reproduced by* Gavin Britto in 21Winter.0.0
	#
	#*Reference Case#* [00031001|https://fonteva.my.salesforce.com/5004V000017HOXtQAO]
	#
	#*Description:*
	#
	#Clicking renew on membership creates a sales order with wrong term end date. The wrong term end date is noticed in both membership record and sales order.
	#
	#*Steps to Reproduce:*
	#
	## For a contact, do ROE and purchase FON-1 Year Anniversary
	## Take a note of subscription start and end date on sales order line. It looks good.
	## Now renew the FON-1 Year Anniversary subscription for the same contact.
	## On sales order line, note the start date and end date. The end date generated is one day early which is a wrong end date.
	#
	#Replication video in GCO:
	#
	#[https://fonteva.zoom.us/rec/share/rXjFFVIoaW5zWcJPKmamfHudWkJGSUqmWIWwSL3R3iUjBf8DE9KcY2PbNWgbcQUx.UurESOSSi-peWe9n|https://fonteva.zoom.us/rec/share/rXjFFVIoaW5zWcJPKmamfHudWkJGSUqmWIWwSL3R3iUjBf8DE9KcY2PbNWgbcQUx.UurESOSSi-peWe9n]
	#
	#*Actual Results:*
	#
	#Upon renewal, a wrong end date is seen in sales order line. The end date is one day earlier than the actual end date.
	#
	#*T3 Notes*
	#
	#This is related to the change made in [https://github.com/Fonteva/orderapi/pull/3387|https://github.com/Fonteva/orderapi/pull/3387]
	#
	#We need to figure out how to fix the present issue while maintaining the effects of this PR
	#
	#*Expected Results:*
	#
	#Upon renewal, a correct end date must be seen in sales order line.
	#
	#
	#
	#*Note to QA:*
	#
	#Need to test BE, FE and Subscription batchable
	#
	#Also need to make sure if item has deferred rev, it has to be 12 deferred rev instead of 11

	@TEST_PD-29108 @REQ_PD-27911 @akash @regression @21Winter @22Winter
	Scenario: Test Incorrect date range on subscription renewals (Backend)
		Given User will select "Daniela Brown" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoTermedPlan" item on rapid order entry
		And User navigate to "apply payment" page for "AutoTermedPlan" item from rapid order entry
		Then User should be able to apply payment for "AutoTermedPlan" item using "Credit Card" payment on apply payment page
		And User verifies the end date on sales order line for "backend" checkout
		And User should renew the subscription to "AutoTermedPlan" item on backend
		And User should be able to apply payment for "AutoTermedPlan" item using "Credit Card" payment on apply payment page
		Then User verifies the end date on sales order line for "backend" checkout


	@TEST_PD-29176 @REQ_PD-27911 @akash @regression @21Winter @22Winter
	Scenario: Test Incorrect date range on subscription renewals (Portal)
		Given User navigate to community Portal page with "danielabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User should be able to select "AutoTermedPlan" item with quantity "1" on store
		And User select assign members for subscription
			| name          | role  |
			| Daniela Brown | Admin |
		And User should click on the checkout button
		And User successfully pays for the order using credit card
		And User should see the "invoice" created confirmation message
		Then User verifies the end date on sales order line for "portal" checkout
		And User navigate to profile and select the "Subscriptions" page in LT Portal
		And User should be able to renew the "active" subscription "AutoTermedPlan"
		Then User verifies the end date on sales order line for "portal" checkout

