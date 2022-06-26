@REQ_PD-26917
Feature: The quantity of the Additional Package Items changes after selecting process payment when doing a ROE.
	#*Case Reporter* Julie Smith
	#
	#*Customer* National Air Transportation Association
	#
	#*Reproduced by* Linda Diemer in 2019.1.0.36,2019.1.0.37
	#
	#*Reference Case#* [00029366|https://fonteva.my.salesforce.com/5004V000014jinGQAQ]
	#
	#
	#
	#*Description:*
	#
	#This can be time-consuming when trying to do ROE as the associate would need to redo the ROE until the correct quantity is shown and it could take a few attempts for that to happen.
	#
	#
	#
	#*PM NOTE:*
	#
	#{color:#ff5630}After 20Apring.0 release product introduced a new payment page called apply payment page. We need to validate this issue with the new payment page.{color} Please note that the screenshot below belongs to the old payment page but do not get confused issue is not with the payment page itself. It is about the quantity field getting changed for SOL so my expectation is the issue on the ROE page, not the payment page.
	#
	#
	#
	#*Steps to Reproduce:*
	#
	## Go to a Contact, Ex: Bob Kelley
	## Select: ROE
	## Select an Item with Additional Package Items
	### Make sure the main item you are purchasing has a package item set up.
	### There is a related list button on the item object called ”Advanced Item Settings”
	### you can configure additional items using this button
	## Input the quantity for the Additional Package Items to be more than 1
	## Select Go to process payment
	## In the Checkout screen, the quantity for the Additional Package Items shows 1, instead of the selected amount.
	### On the new checkout page (apply payment page) open the drawer to see the order details
	### note: you can also do this via SF classic UI, get the order id when you are on the payment page and validate the record and check if the SOL quantity is matching with the number provided on the ROE page
	#
	#This issue is intermittent and there is no particular quantity you can set which would trigger this to happen.
	#
	#
	#
	#*Actual Results:*
	#
	#The observed behavior is sometimes the Additional Package Item quantity reverts to 1 instead of showing the original selected amount.
	#
	#
	#
	#*Expected Results:*
	#
	#The expected behavior would be for the quantity amount to show correct and not change from what was originally selected.
	#
	#
	#
	#*T3 Notes:*
	#The problem here is that we aren't waiting for a response from the backend when change quantity.
	#Possible solution [https://github.com/Fonteva/RapidOrderEntry/commit/45b86701254d63556f5f43c4c45cd74b4c460de6|https://github.com/Fonteva/RapidOrderEntry/commit/45b86701254d63556f5f43c4c45cd74b4c460de6]
	#So, according to this solution, we'll wait for backend response, and only then will be able to go to process payment or change the number of other package items
	#
	#
	#
	#Estimate
	#
	#QA Estimate: 24h

	#Tests *Case Reporter* Julie Smith
	#
	#*Customer* National Air Transportation Association
	#
	#*Reproduced by* Linda Diemer in 2019.1.0.36,2019.1.0.37
	#
	#*Reference Case#* [00029366|https://fonteva.my.salesforce.com/5004V000014jinGQAQ]
	#
	#
	#
	#*Description:*
	#
	#This can be time-consuming when trying to do ROE as the associate would need to redo the ROE until the correct quantity is shown and it could take a few attempts for that to happen.
	#
	#
	#
	#*PM NOTE:*
	#
	#{color:#ff5630}After 20Apring.0 release product introduced a new payment page called apply payment page. We need to validate this issue with the new payment page.{color} Please note that the screenshot below belongs to the old payment page but do not get confused issue is not with the payment page itself. It is about the quantity field getting changed for SOL so my expectation is the issue on the ROE page, not the payment page.
	#
	#
	#
	#*Steps to Reproduce:*
	#
	## Go to a Contact, Ex: Bob Kelley
	## Select: ROE
	## Select an Item with Additional Package Items
	### Make sure the main item you are purchasing has a package item set up.
	### There is a related list button on the item object called ”Advanced Item Settings”
	### you can configure additional items using this button
	## Input the quantity for the Additional Package Items to be more than 1
	## Select Go to process payment
	## In the Checkout screen, the quantity for the Additional Package Items shows 1, instead of the selected amount.
	### On the new checkout page (apply payment page) open the drawer to see the order details
	### note: you can also do this via SF classic UI, get the order id when you are on the payment page and validate the record and check if the SOL quantity is matching with the number provided on the ROE page
	#
	#This issue is intermittent and there is no particular quantity you can set which would trigger this to happen.
	#
	#
	#
	#*Actual Results:*
	#
	#The observed behavior is sometimes the Additional Package Item quantity reverts to 1 instead of showing the original selected amount.
	#
	#
	#
	#*Expected Results:*
	#
	#The expected behavior would be for the quantity amount to show correct and not change from what was originally selected.
	#
	#
	#
	#*T3 Notes:*
	#The problem here is that we aren't waiting for a response from the backend when change quantity.
	#Possible solution [https://github.com/Fonteva/RapidOrderEntry/commit/45b86701254d63556f5f43c4c45cd74b4c460de6|https://github.com/Fonteva/RapidOrderEntry/commit/45b86701254d63556f5f43c4c45cd74b4c460de6]
	#So, according to this solution, we'll wait for backend response, and only then will be able to go to process payment or change the number of other package items
	#
	#
	#
	#Estimate
	#
	#QA Estimate: 24h
	@TEST_PD-27189 @REQ_PD-26917 @regression @21Winter @22Winter @ngunda
	Scenario: Test The quantity of the Additional Package Items changes after selecting process payment when doing a ROE.
		Given User will select "Mannik Gunda" contact
		And User opens the Rapid Order Entry page from contact
		When User should be able to add "AutoAdditionalItem" item on rapid order entry
		And User is able to expand the Item details of "AutoAdditionalItem" and update the Qty of the Additional Package item to 3
		And User selects "Process Payment" as payment method and proceeds further
		Then User verifies the amount for optional Item is displayed correct based on Qty

