@REQ_PD-24310
Feature: Deferral Revenue records not being created correctly for a non-Subscription Item
	#*Case Reporter* Julie Smith
	#
	#*Customer* National Business Aviation Association
	#
	#*Reproduced by* Erich Ehinger in 20Spring.0.3
	#
	#*Reference Case#* [00024858|https://fonteva.my.salesforce.com/5004V000011s6ICQAY]
	#
	#*Description:*
	#
	#Identified deferred revenue configurations for a non-Subscription Item. When the receipt was created, it deferred the revenue but no according to the configuration.
	#
	#*Steps to Reproduce:*
	#
	#Refer to [https://docs.fonteva.com/user/Setting-up-Deferred-Revenue.1638400016.html|https://docs.fonteva.com/user/Setting-up-Deferred-Revenue.1638400016.html|smart-link] for configuration of deferred revenue
	#
	#*Created an Item Class
	#
	#* Defer Revenue checkbox checked
	#* Revenue Recognition Rule = Overtime
	#* Revenue Recognition Term Rule = Daily
	#* Deferred Revenue Term (In Months) = 12
	#
	#* Create an Item with the same deferred configuration as the Item Class
	#
	#* Navigate to a Contact
	#
	#* Navigate to ROE page, 
	#
	#* Purchase the above Item
	#
	#*Actual Results:*
	#
	#* Only 2 transaction records were created
	#
	#> First transaction record was correctly created: Deposit GL Account was a Debit and the Defer Rev GL Account was a Credit
	#
	#> Second Transaction Record reflected the date "10/31/2020" and reflected the Defer Rev GL Account was the Debit and the Income GL Account was the Credit
	#
	#*Expected Results:*
	#
	#* Expected 13 transactions to be created
	#
	#> First transaction record: Deposit GL Account was a Debit and the Defer Rev GL Account was a Credit
	#
	#> 12 additional transaction records would have been created - as identified on the item. Each transaction record would reflect the date as "Month/same day as today" - meaning 10/6, 11/6, 12/6, 1/6, 2/6, 3/6, 4/6, 5/6, 6/6, 7/6, 8/6, and 9/6. The Defer Rev GL Account would be the Debit and the Income GL Account would be the Credit

	#Tests *Case Reporter* Julie Smith
	#
	#*Customer* National Business Aviation Association
	#
	#*Reproduced by* Erich Ehinger in 20Spring.0.3
	#
	#*Reference Case#* [00024858|https://fonteva.my.salesforce.com/5004V000011s6ICQAY]
	#
	#*Description:*
	#
	#Identified deferred revenue configurations for a non-Subscription Item. When the receipt was created, it deferred the revenue but no according to the configuration.
	#
	#*Steps to Reproduce:*
	#
	#Refer to [https://docs.fonteva.com/user/Setting-up-Deferred-Revenue.1638400016.html|https://docs.fonteva.com/user/Setting-up-Deferred-Revenue.1638400016.html|smart-link] for configuration of deferred revenue
	#
	#*Created an Item Class
	#
	#* Defer Revenue checkbox checked
	#* Revenue Recognition Rule = Overtime
	#* Revenue Recognition Term Rule = Daily
	#* Deferred Revenue Term (In Months) = 12
	#
	#* Create an Item with the same deferred configuration as the Item Class
	#
	#* Navigate to a Contact
	#
	#* Navigate to ROE page, 
	#
	#* Purchase the above Item
	#
	#*Actual Results:*
	#
	#* Only 2 transaction records were created
	#
	#> First transaction record was correctly created: Deposit GL Account was a Debit and the Defer Rev GL Account was a Credit
	#
	#> Second Transaction Record reflected the date "10/31/2020" and reflected the Defer Rev GL Account was the Debit and the Income GL Account was the Credit
	#
	#*Expected Results:*
	#
	#* Expected 13 transactions to be created
	#
	#> First transaction record: Deposit GL Account was a Debit and the Defer Rev GL Account was a Credit
	#
	#> 12 additional transaction records would have been created - as identified on the item. Each transaction record would reflect the date as "Month/same day as today" - meaning 10/6, 11/6, 12/6, 1/6, 2/6, 3/6, 4/6, 5/6, 6/6, 7/6, 8/6, and 9/6. The Defer Rev GL Account would be the Debit and the Income GL Account would be the Credit
	@TEST_PD-30549 @REQ_PD-24310 @21Winter @22Winter @regression @Pavan
	Scenario: Test Deferral Revenue records not being created correctly for a non-Subscription Item
		Given User will select "Coco Dulce" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "DeferRevenueItem" item on rapid order entry
		And User navigate to "apply payment" page for "DeferRevenueItem" item from rapid order entry
		When User should be able to apply payment for "DeferRevenueItem" item using "Credit Card" payment on apply payment page
		Then User verifies debit, credit accounts and 13 transaction records are created with date value as end of month

