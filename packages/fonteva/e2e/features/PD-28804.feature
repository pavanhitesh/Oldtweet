@REQ_PD-28804
Feature: Subscription lines are missing for the subscription items added to the order while renewing an existing subscription.
	#h2. Details
	#Subscription lines are missing for the subscription items added to the order while renewing an existing subscription.
	#h2. Steps to Reproduce
	#Replicated in: 21Winter.0.11
	#Org ID: 00D5Y000001NF952
	#URL: https://eligco.lightning.force.com/lightning/page/home
	#Username: enesson-20r2b@fonteva.com
	#Password: Fonteva703
	#
	#	1. Created a subscription Item, Subscription plan, and an Item Class.
	#
	#Subscription Plan: https://eligco.lightning.force.com/lightning/r/OrderApi__Subscription_Plan__c/a1R5Y0000063eeHUAQ/view
	#Type: Termed
	#Auto Renew Option : Disabled
	#Item-Regular Member:  https://eligco.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000ic7ZQQAY/view?0.source=alohaHeader
	#Item has two renewal paths, default one is set to the same item and another one is set to the renewal item.
	#Item Class: https://eligco.lightning.force.com/lightning/r/OrderApi__Item_Class__c/a135Y00000l3ExoQAE/view?0.source=alohaHeader
	#
	#	2. Created another subscription item and added that item to the renewal path on the above item.
	#Item-Retired Member: https://eligco.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000ic7b2QAA/view?0.source=alohaHeader
	#
	#	3. Add the below items as an Additional Items to the Retired Member item.
	#Chapters: https://eligco.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000ic7ZRQAY/view?0.source=alohaHeader
	#Journal: https://eligco.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000ic7fTQAQ/view?0.source=alohaHeader
	#
	#	3. Processed an order for the primary item from the portal.
	#Sales Order Regular Member Item: https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000AN1qhUAD/view
	# Membership record: https://eligco.lightning.force.com/lightning/r/OrderApi__Subscription__c/a1S5Y000006uqPMUAY/view
	#	4. Logged into the portal> Subscription> Click on Renew button next to the Regular Member and choose to renew with the Retired Member item.
	#	5. Add the Chapters & Journals to the order.
	#
	#	6. Process the order.
	#	Renewal Sales order: https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000AN1qmUAD/view?0.source=alohaHeader
	#Membership record: https://eligco.lightning.force.com/lightning/r/OrderApi__Subscription__c/a1S5Y000006uqPRUAY/view?0.source=alohaHeader
	#
	#	7. There is only one Subscription line for the Retired Member item and the subscription lines for the chapter and journals are missing.
	#
	#Issue Journey: https://togetherwork-my.sharepoint.com/:v:/r/personal/sbangwal_fonteva_com/Documents/00032626.mp4?csf=1&web=1&e=lFeLBw
	#h2. Expected Results
	#Should have subscription lines for the subscription items added to the car upon renewing an existing subscription.
	#h2. Actual Results
	#Subscription lines for the additional items are missing from the membership record.
	#h2. Business Justification
	#Some subscription lines are used in other business processes and if customers pay for them but the system doesn't generate them, then we cannot provide proper services to our customers.

	#Tests h2. Details
	#Subscription lines are missing for the subscription items added to the order while renewing an existing subscription.
	#h2. Steps to Reproduce
	#Replicated in: 21Winter.0.11
	#Org ID: 00D5Y000001NF952
	#URL: https://eligco.lightning.force.com/lightning/page/home
	#Username: enesson-20r2b@fonteva.com
	#Password: Fonteva703
	#
	#	1. Created a subscription Item, Subscription plan, and an Item Class.
	#
	#Subscription Plan: https://eligco.lightning.force.com/lightning/r/OrderApi__Subscription_Plan__c/a1R5Y0000063eeHUAQ/view
	#Type: Termed
	#Auto Renew Option : Disabled
	#Item-Regular Member:  https://eligco.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000ic7ZQQAY/view?0.source=alohaHeader
	#Item has two renewal paths, default one is set to the same item and another one is set to the renewal item.
	#Item Class: https://eligco.lightning.force.com/lightning/r/OrderApi__Item_Class__c/a135Y00000l3ExoQAE/view?0.source=alohaHeader
	#
	#	2. Created another subscription item and added that item to the renewal path on the above item.
	#Item-Retired Member: https://eligco.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000ic7b2QAA/view?0.source=alohaHeader
	#
	#	3. Add the below items as an Additional Items to the Retired Member item.
	#Chapters: https://eligco.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000ic7ZRQAY/view?0.source=alohaHeader
	#Journal: https://eligco.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000ic7fTQAQ/view?0.source=alohaHeader
	#
	#	3. Processed an order for the primary item from the portal.
	#Sales Order Regular Member Item: https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000AN1qhUAD/view
	# Membership record: https://eligco.lightning.force.com/lightning/r/OrderApi__Subscription__c/a1S5Y000006uqPMUAY/view
	#	4. Logged into the portal> Subscription> Click on Renew button next to the Regular Member and choose to renew with the Retired Member item.
	#	5. Add the Chapters & Journals to the order.
	#
	#	6. Process the order.
	#	Renewal Sales order: https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000AN1qmUAD/view?0.source=alohaHeader
	#Membership record: https://eligco.lightning.force.com/lightning/r/OrderApi__Subscription__c/a1S5Y000006uqPRUAY/view?0.source=alohaHeader
	#
	#	7. There is only one Subscription line for the Retired Member item and the subscription lines for the chapter and journals are missing.
	#
	#Issue Journey: https://togetherwork-my.sharepoint.com/:v:/r/personal/sbangwal_fonteva_com/Documents/00032626.mp4?csf=1&web=1&e=lFeLBw
	#h2. Expected Results
	#Should have subscription lines for the subscription items added to the car upon renewing an existing subscription.
	#h2. Actual Results
	#Subscription lines for the additional items are missing from the membership record.
	#h2. Business Justification
	#Some subscription lines are used in other business processes and if customers pay for them but the system doesn't generate them, then we cannot provide proper services to our customers.
 @TEST_PD-29232 @REQ_PD-28804 @21Winter @22Winter @regression @alex
 Scenario: Test Subscription lines are missing for the subscription items added to the order while renewing an existing subscription.
  Given User will select "Daniela Brown" contact
  And User opens the Rapid Order Entry page from contact
  And User should be able to add "Auto_SubscriptionItemWithTwoRenewalPaths" item on rapid order entry
  And User should be able to close and post sales order
  And User navigate to community Portal page with "danielabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
  And User will select the "Subscriptions" page in LT Portal
  Then User "Daniela Brown" should be able to renew the subscription and validate the sales order lines
