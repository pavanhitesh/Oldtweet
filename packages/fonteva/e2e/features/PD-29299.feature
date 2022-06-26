@REQ_PD-29299
Feature: MANUAL PASS - Subscription Proration Not working when we Renew Subscription. When we purchase a Subscription Item, the Amount is getting calculated based on the Monthly Proration specified on Subscription Plan.
	#When we try to renew the same Subscription then it is getting changed with the full amount based on the Price on Item and is not getting calculated based on specified Proration.
	#
	#h2. Details
	#GCO Org: 21winter@fondash.io/Fonteva2021
	#
	#Subscription Plan:
	#Link: https://gco9kjpim.lightning.force.com/lightning/r/OrderApi__Subscription_Plan__c/a1R5Y000005lxVqUAI/view
	#Type: Calander
	#Calendar End Day: 31
	#Calendar End Month: 12 - December
	#Enable Proration: True
	#Proration Rule: Monthly
	#Auto Renew Option: Enabled
	#Invoice Days Variable: 45
	#
	#
	#Item without Package Items
	#Link: https://gco9kjpim.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000hk0UNQAY/view
	#Disable Price Rules: True
	#Is Subscription: True
	#
	#Item with Package Items
	#Link: https://gco9kjpim.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000hk0SqQAI/view
	#Disable Price Rules: True
	#Is Subscription: True
	#
	#When we purchase a Subscription Item, the Amount is getting calculated based on the Monthly Proration specified on Subscription Plan.  When we try to renew the same Subscription then it is getting changed with the full amount based on the Price on Item and is not getting calculated based on specified Proration.
	#h2. Steps to Reproduce
	#GCO Org: 21winter@fondash.io/Fonteva2021
	#
	#Steps:
	#1. Open Contact:
	#2. From ROE, purchase "MembershipT1" item which is of Subscription Type and is without Package Items
	#https://gco9kjpim.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000hk0UNQAY/view
	#3. While purchase you will see that amount is getting calculated based on Proration defined on the "Membership" Subscription Plan.
	#https://gco9kjpim.lightning.force.com/lightning/r/OrderApi__Subscription_Plan__c/a1R5Y000005lxVqUAI/view
	#4. After purchase try to renew the same membership, now while we renew it will charge in the full amount of the item and does not calculate the paid amount based on Proration which is an issue.
	#
	#Below is the video link of the issue journey:
	#https://fonteva.zoom.us/rec/share/yl3P-z-EGU6mUBcHhQ3r54lpBl3fqS1RgXwSTYQuDqUjxeEN7g0Yc-aqbyWw8_IO.1YOaBjv1wVnz0k-u?startTime=1636659223000
	#h2. Expected Results
	#It must calculate the amount based on specified proration when we are renewing the Subscription.
	#h2. Actual Results
	#When we Renew the Subscription it does not calculate the amount based on Proration specified on Subscription Plan.
	#h2. Business Justification
	#We are charging full when it should be calculated based on the remaining months of the year, based on Proration and Calander type specified on Subscription Plan.

	#Tests When we try to renew the same Subscription then it is getting changed with the full amount based on the Price on Item and is not getting calculated based on specified Proration.
	#
	#h2. Details
	#GCO Org: 21winter@fondash.io/Fonteva2021
	#
	#Subscription Plan:
	#Link: https://gco9kjpim.lightning.force.com/lightning/r/OrderApi__Subscription_Plan__c/a1R5Y000005lxVqUAI/view
	#Type: Calander
	#Calendar End Day: 31
	#Calendar End Month: 12 - December
	#Enable Proration: True
	#Proration Rule: Monthly
	#Auto Renew Option: Enabled
	#Invoice Days Variable: 45
	#
	#
	#Item without Package Items
	#Link: https://gco9kjpim.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000hk0UNQAY/view
	#Disable Price Rules: True
	#Is Subscription: True
	#
	#Item with Package Items
	#Link: https://gco9kjpim.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000hk0SqQAI/view
	#Disable Price Rules: True
	#Is Subscription: True
	#
	#When we purchase a Subscription Item, the Amount is getting calculated based on the Monthly Proration specified on Subscription Plan.  When we try to renew the same Subscription then it is getting changed with the full amount based on the Price on Item and is not getting calculated based on specified Proration.
	#h2. Steps to Reproduce
	#GCO Org: 21winter@fondash.io/Fonteva2021
	#
	#Steps:
	#1. Open Contact:
	#2. From ROE, purchase "MembershipT1" item which is of Subscription Type and is without Package Items
	#https://gco9kjpim.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000hk0UNQAY/view
	#3. While purchase you will see that amount is getting calculated based on Proration defined on the "Membership" Subscription Plan.
	#https://gco9kjpim.lightning.force.com/lightning/r/OrderApi__Subscription_Plan__c/a1R5Y000005lxVqUAI/view
	#4. After purchase try to renew the same membership, now while we renew it will charge in the full amount of the item and does not calculate the paid amount based on Proration which is an issue.
	#
	#Below is the video link of the issue journey:
	#https://fonteva.zoom.us/rec/share/yl3P-z-EGU6mUBcHhQ3r54lpBl3fqS1RgXwSTYQuDqUjxeEN7g0Yc-aqbyWw8_IO.1YOaBjv1wVnz0k-u?startTime=1636659223000
	#h2. Expected Results
	#It must calculate the amount based on specified proration when we are renewing the Subscription.
	#h2. Actual Results
	#When we Renew the Subscription it does not calculate the amount based on Proration specified on Subscription Plan.
	#h2. Business Justification
	#We are charging full when it should be calculated based on the remaining months of the year, based on Proration and Calander type specified on Subscription Plan.
	@REQ_PD-29299 @TEST_PD-29504 @regression @21Winter @22Winter @abinaya
	Scenario: Test MANUAL PASS - Subscription Proration Not working when we Renew Subscription. When we purchase a Subscription Item, the Amount is getting calculated based on the Monthly Proration specified on Subscription Plan.
		Given User will select "Bob Kelley" contact
		And User opens the Rapid Order Entry page from contact	
		And User should be able to add "Membership T1" item on rapid order entry
		And User navigate to "apply payment" page for "Membership T1" item from rapid order entry
		Then User should be able to apply payment for "Membership T1" item using "Credit Card" payment on apply payment page
		Then User renew the subscription and verifies the amount calculated for renewing the subscription
