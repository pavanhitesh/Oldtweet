@REQ_PD-27895
Feature: BLOCKED: Error on setting contact role while renewing a subscription from the portal
	#*Case Reporter* Michael Dobinson
	#
	#*Customer* International Institute of Business Analysis
	#
	#*Reproduced by* Sandeep Bangwal in 20Spring.1.13
	#
	#*Reference Case#* [00024143|https://fonteva.my.salesforce.com/5004V000011QFdGQAW]
	#
	#*Description:*
	#
	#The client is experiencing this issue with the company subscription, if you log in to the portal with the subscription admin's contact and try to renew the subscription, it takes you to the Assign member's page and if you try to change the role of the member's in the list without checking the box in front of the member, it throws an exception on the screen then if you X out the exception, you have left with the endless spinning three dots on the screen unless you try to navigate using the browser navigation.
	#
	#
	#
	#*Recording for grooming*
	#
	# [https://drive.google.com/file/d/1l-qtdxYjAJI9qEsGoMoP7YGtK_YME_VA/view?usp=sharing|https://drive.google.com/file/d/1l-qtdxYjAJI9qEsGoMoP7YGtK_YME_VA/view?usp=sharing|smart-link]
	#
	#
	#
	#*Steps to Reproduce:*
	#
	## Purchased a company subscription.
	### Item level enable assignment = true
	### So you can assign members while you are buying or renewing this subscription item
	### Make sure Item class which is related to the subscription item has more than one “Assignment Roles“
	### Assignment Roles is an object, you can find as a related list under the item class.
	#### eg. Admin, Super Admin, Regular
	## Logged into the portal using Bob Kelley's contact as it is associated with an organizational subscription.
	## Click on the renew button next to the subscription and continue the purchase process until you reach the Assign Members.
	## Try to toggle the role without clicking the check box, the error message appears on the screen.
	## Click the X button on the error message to close the error, left with a never-ending three dots (spinning wheel) where the member list had once been.
	## The user is stuck after dismissing the error, meaning they have to use browser navigation to go back at repeat steps.
	#
	#
	#
	#*Actual Results:*
	#
	#There are endless spinning three dots on the screen if you X out the error.
	#
	#*Expected Results:*
	#
	#Users should be able to view the list of the members on the Assign Members screen after closing the exception on the screen.
	#
	#
	#
	#* *CS Note:*
	#Item configuration: Item: [https://gcoay39ob.lightning.force.com/lightning/r/OrderApi\\_\\_Item\\_\\_c/a155e000001NiFhAAK/view?0.source=alohaHeader|https://gcoay39ob.lightning.force.com/lightning/r/OrderApi__Item__c/a155e000001NiFhAAK/view?0.source=alohaHeader]
	#* Is active checked.
	#* Is subscription checked.
	#* Enable assignments checked.
	#* Item Class configuration: [https://gcoay39ob.lightning.force.com/lightning/r/OrderApi\\_\\_Item\\_Class\\_\\_c/a135e000000Vu06AAC/view?0.source=alohaHeader|https://gcoay39ob.lightning.force.com/lightning/r/OrderApi__Item_Class__c/a135e000000Vu06AAC/view?0.source=alohaHeader] Is active checked.
	#* Is subscription checked
	#* Enable assignments checked.
	#* Assignment Roles: Member > Default > Active Primary > Primary > Active GCO Details: 20Spring.1.13
	#* Org ID: 00D5e000002IZqd

	#Tests *Case Reporter* Michael Dobinson
	#
	#*Customer* International Institute of Business Analysis
	#
	#*Reproduced by* Sandeep Bangwal in 20Spring.1.13
	#
	#*Reference Case#* [00024143|https://fonteva.my.salesforce.com/5004V000011QFdGQAW]
	#
	#*Description:*
	#
	#The client is experiencing this issue with the company subscription, if you log in to the portal with the subscription admin's contact and try to renew the subscription, it takes you to the Assign member's page and if you try to change the role of the member's in the list without checking the box in front of the member, it throws an exception on the screen then if you X out the exception, you have left with the endless spinning three dots on the screen unless you try to navigate using the browser navigation.
	#
	#
	#
	#*Recording for grooming*
	#
	# [https://drive.google.com/file/d/1l-qtdxYjAJI9qEsGoMoP7YGtK_YME_VA/view?usp=sharing|https://drive.google.com/file/d/1l-qtdxYjAJI9qEsGoMoP7YGtK_YME_VA/view?usp=sharing|smart-link]
	#
	#
	#
	#*Steps to Reproduce:*
	#
	## Purchased a company subscription.
	### Item level enable assignment = true
	### So you can assign members while you are buying or renewing this subscription item
	### Make sure Item class which is related to the subscription item has more than one “Assignment Roles“
	### Assignment Roles is an object, you can find as a related list under the item class.
	#### eg. Admin, Super Admin, Regular
	## Logged into the portal using Bob Kelley's contact as it is associated with an organizational subscription.
	## Click on the renew button next to the subscription and continue the purchase process until you reach the Assign Members.
	## Try to toggle the role without clicking the check box, the error message appears on the screen.
	## Click the X button on the error message to close the error, left with a never-ending three dots (spinning wheel) where the member list had once been.
	## The user is stuck after dismissing the error, meaning they have to use browser navigation to go back at repeat steps.
	#
	#
	#
	#*Actual Results:*
	#
	#There are endless spinning three dots on the screen if you X out the error.
	#
	#*Expected Results:*
	#
	#Users should be able to view the list of the members on the Assign Members screen after closing the exception on the screen.
	#
	#
	#
	#* *CS Note:*
	#Item configuration: Item: [https://gcoay39ob.lightning.force.com/lightning/r/OrderApi\\_\\_Item\\_\\_c/a155e000001NiFhAAK/view?0.source=alohaHeader|https://gcoay39ob.lightning.force.com/lightning/r/OrderApi__Item__c/a155e000001NiFhAAK/view?0.source=alohaHeader]
	#* Is active checked.
	#* Is subscription checked.
	#* Enable assignments checked.
	#* Item Class configuration: [https://gcoay39ob.lightning.force.com/lightning/r/OrderApi\\_\\_Item\\_Class\\_\\_c/a135e000000Vu06AAC/view?0.source=alohaHeader|https://gcoay39ob.lightning.force.com/lightning/r/OrderApi__Item_Class__c/a135e000000Vu06AAC/view?0.source=alohaHeader] Is active checked.
	#* Is subscription checked
	#* Enable assignments checked.
	#* Assignment Roles: Member > Default > Active Primary > Primary > Active GCO Details: 20Spring.1.13
	#* Org ID: 00D5e000002IZqd
	@TEST_PD-29002 @REQ_PD-27895 @21Winter @22Winter @regression @ngunda
	Scenario: Error on setting contact role while renewing a subscription from the portal
		Given User will select "Max Foxworth" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "autoSubscriptionItem" item on rapid order entry
		And User navigate to "apply payment" page for "autoSubscriptionItem" item from rapid order entry
		And User should be able to apply payment for "autoSubscriptionItem" item using "Credit Card" payment on apply payment page
		When User navigate to community Portal page with "maxfoxworth@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User will select the "Subscriptions" page in LT Portal
		And User should be able to click on "renew" subscription purchased using "backend"
		And User should be able to select "autoSubscriptionItem" renew item
		Then User changes the role for "Max Foxworth" and verfies role is updated
