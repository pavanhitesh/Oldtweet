@REQ_PD-28058
Feature: RESEARCH:When a package item are purchased along with the purchase of membership then an additional package item generates an extra assignment.
	#*Case Reporter* Michael Dobinson
	#
	#*Customer* International Institute of Business Analysis
	#
	#*Reproduced by* Shilpa Gupta in 2019.1.0.31
	#
	#*Reference Case#* [00024286|https://fonteva.my.salesforce.com/5004V000011QsgvQAC]
	#
	#*Description:*
	#
	#When a package item is purchased along with the purchase of membership then an additional package item generates an extra assignment. This leads to situations where the total assignments on a subscription/term exceed the maximum amount.
	#
	#*Steps to Reproduce:*
	#
	#Org Id = 00D3t000002P1Wj
	#
	#Items Configuration ->
	#
	#h2. Item Name = Platinum Global Corporate Program
	#
	#[https://gdoigdvcv.my.salesforce.com/a153t00000DJxlD|https://gdoigdvcv.my.salesforce.com/a153t00000DJxlD]
	#
	#Is Subscription = True
	#
	#Enable Assignments = True
	#
	#Restrict Number of Assignments = True
	#
	#Maximum Number of Assignments = 10
	#
	#Subscription Plan - >
	#
	#h2. Name = One Year Corporate Subscription
	#
	#[https://gdoigdvcv.my.salesforce.com/a1R3t000002JsvU|https://gdoigdvcv.my.salesforce.com/a1R3t000002JsvU]
	#
	#Type = Termed
	#
	#Enable Proration = True
	#
	#Proration Rule = Monthly
	#
	#Disable Renew = True
	#
	#Package Item Configuration ->
	#
	#h2. *Name =* Corporate Membership Additional Slots
	#
	#[https://gdoigdvcv.my.salesforce.com/a153t00000DJxlN|https://gdoigdvcv.my.salesforce.com/a153t00000DJxlN]
	#
	#Is Subscription = True
	#
	#Enable Assignments = True
	#
	#Restrict Number of Assignments = True
	#
	#Maximum Number of Assignments = 1
	#
	#Steps to replicate ->
	#
	## Login to lightning Community (Lightning Community) as a contact.
	## Purchase membership (Platinum Global Corporate Program) and add an additional seat to it.
	## Go back to the contact and open the membership/subscription.
	## check subscription > subscribers related list- note that the purchasing user will have 1 subscriber entry for the corporate subscription and active assignment should be 1.
	#
	#Note - Test Contact ([https://gdoigdvcv.my.salesforce.com/0033t000036zvEA)|https://gdoigdvcv.my.salesforce.com/0033t000036zvEA)]
	#
	#Subscription ([https://gdoigdvcv.my.salesforce.com/a1S3t000019bQuf)|https://gdoigdvcv.my.salesforce.com/a1S3t000019bQuf)][https://fonteva--c.na138.content.force.com/servlet/rtaImage?eid=a4p4V000000gPws&feoid=00N3A00000ClSV7&refid=0EM4V000001vESL|https://fonteva--c.na138.content.force.com/servlet/rtaImage?eid=a4p4V000000gPws&feoid=00N3A00000ClSV7&refid=0EM4V000001vESL]
	#
	#*Actual Results:*
	#
	#Purchasing user is having one subscriber entry for the corporate subscription plus one subscriber entry for additional seat purchased and value on the active assignment is 2.
	#
	#*Expected Results:*
	#
	#The purchasing user will have 1 subscriber entry for the corporate subscription and the active assignment should be 1.
	#
	#*PM Note:*
	#
	#We treat the two items as one subscription. therefore there should only be one assignment created per contact, under one term
	#
	#
	#
	#*Auto Notes:* This item has required config: *AutoAssignmentMembership*

	#Tests *Case Reporter* Michael Dobinson
	#
	#*Customer* International Institute of Business Analysis
	#
	#*Reproduced by* Shilpa Gupta in 2019.1.0.31
	#
	#*Reference Case#* [00024286|https://fonteva.my.salesforce.com/5004V000011QsgvQAC]
	#
	#*Description:*
	#
	#When a package item is purchased along with the purchase of membership then an additional package item generates an extra assignment. This leads to situations where the total assignments on a subscription/term exceed the maximum amount.
	#
	#*Steps to Reproduce:*
	#
	#Org Id = 00D3t000002P1Wj
	#
	#Items Configuration ->
	#
	#h2. Item Name = Platinum Global Corporate Program
	#
	#[https://gdoigdvcv.my.salesforce.com/a153t00000DJxlD|https://gdoigdvcv.my.salesforce.com/a153t00000DJxlD]
	#
	#Is Subscription = True
	#
	#Enable Assignments = True
	#
	#Restrict Number of Assignments = True
	#
	#Maximum Number of Assignments = 10
	#
	#Subscription Plan - >
	#
	#h2. Name = One Year Corporate Subscription
	#
	#[https://gdoigdvcv.my.salesforce.com/a1R3t000002JsvU|https://gdoigdvcv.my.salesforce.com/a1R3t000002JsvU]
	#
	#Type = Termed
	#
	#Enable Proration = True
	#
	#Proration Rule = Monthly
	#
	#Disable Renew = True
	#
	#Package Item Configuration ->
	#
	#h2. *Name =* Corporate Membership Additional Slots
	#
	#[https://gdoigdvcv.my.salesforce.com/a153t00000DJxlN|https://gdoigdvcv.my.salesforce.com/a153t00000DJxlN]
	#
	#Is Subscription = True
	#
	#Enable Assignments = True
	#
	#Restrict Number of Assignments = True
	#
	#Maximum Number of Assignments = 1
	#
	#Steps to replicate ->
	#
	## Login to lightning Community (Lightning Community) as a contact.
	## Purchase membership (Platinum Global Corporate Program) and add an additional seat to it.
	## Go back to the contact and open the membership/subscription.
	## check subscription > subscribers related list- note that the purchasing user will have 1 subscriber entry for the corporate subscription and active assignment should be 1.
	#
	#Note - Test Contact ([https://gdoigdvcv.my.salesforce.com/0033t000036zvEA)|https://gdoigdvcv.my.salesforce.com/0033t000036zvEA)]
	#
	#Subscription ([https://gdoigdvcv.my.salesforce.com/a1S3t000019bQuf)|https://gdoigdvcv.my.salesforce.com/a1S3t000019bQuf)][https://fonteva--c.na138.content.force.com/servlet/rtaImage?eid=a4p4V000000gPws&feoid=00N3A00000ClSV7&refid=0EM4V000001vESL|https://fonteva--c.na138.content.force.com/servlet/rtaImage?eid=a4p4V000000gPws&feoid=00N3A00000ClSV7&refid=0EM4V000001vESL]
	#
	#*Actual Results:*
	#
	#Purchasing user is having one subscriber entry for the corporate subscription plus one subscriber entry for additional seat purchased and value on the active assignment is 2.
	#
	#*Expected Results:*
	#
	#The purchasing user will have 1 subscriber entry for the corporate subscription and the active assignment should be 1.
	#
	#*PM Note:*
	#
	#We treat the two items as one subscription. therefore there should only be one assignment created per contact, under one term
	#
	#
	#
	#*Auto Notes:* This item has required config: *AutoAssignmentMembership*
	@TEST_PD-29092 @REQ_PD-28058 @21Winter @22Winter @regression @pavan
	Scenario: Test RESEARCH:When a package item are purchased along with the purchase of membership then an additional package item generates an extra assignment.
		Given User navigate to community Portal page with "cdulce@mailinator.com" user and password "705Fonteva" as "authenticated" user
		When User should be able to select "Platinum Global Corporate Program" item with quantity "1" on store
		And User should be able to select additional item "Corporate Membership Additional Slots" and navigate to add to order page
		And User should click on the checkout button
		And User successfully pays for the order using credit card
		And User should see the "receipt" created confirmation message
		Then User verfies subscription has one active assignments and only one subscriber

