@REQ_PD-27744
Feature: Promotional Price appearing in eStore AFTER Price Rule End Date
	#*Case Reporter* Jenny Powell
	#
	#*Customer* National Association of RV Parks and Campgrounds
	#
	#*Reproduced by* Ewa Imtiaz in 2019.1.0.32
	#
	#*Reference Case#* [00026211|https://fonteva.my.salesforce.com/5004V000012SRZMQA4]
	#
	#*Description:*
	#
	#Offer customer promotional pricing
	#
	#*Steps to Reproduce:*
	#
	#* Select an item and create a promotional price (other than default price) rule with a start and end date
	#** Make sure to provide the dates in the past
	#** Make sure promotional price is cheaper than the default price
	#* Navigate to the portal and verify the promotional pricing is not displayed anymore in the e-store
	#
	#*Actual Results:*
	#
	#Price is displayed as a promotional price on the item but is showing correctly in the shopping cart
	#
	#*Expected Results:*
	#
	#The correct price is displayed
	#
	#Promotional price should not be displayed to customers because en ate passed, the user is not qualifying anymore.
	#
	#*Business Justification:*
	#
	#Correct price is displayed to customers
	#
	#*CS Note:*
	#Screenshot attached as a reference
	#
	#*PM Notes:*
	#
	#Bug - *we are not deactivating the price rules (We do not have a scheduled class do deactivate)* but on the page load, we should *evaluate the price rule and see if it is a match or not.* And if the end date has passed it is clearly not matching so the *PriceruleService* should not return that price rule even tho it is active.
	#
	#eg: Companies set discounted prices for early registrations, if you pass a certain date you won't get that price.
	#
	#The fix is likely to go in services, Pricerule service should not return that price, so it is not a UI Bug actually. We need to make sure, we call the same method when insert SOL bc the shopping cart and the actual SOL record has the right price.
	#
	#Item List view also shows the promotional price but when u click on a specific item u land on the item detail page. we need to call the price rule service and show u the right price
	#
	#The page itself is on LTE
	#
	#The service method is in FD Service

	#Tests *Case Reporter* Jenny Powell
	#
	#*Customer* National Association of RV Parks and Campgrounds
	#
	#*Reproduced by* Ewa Imtiaz in 2019.1.0.32
	#
	#*Reference Case#* [00026211|https://fonteva.my.salesforce.com/5004V000012SRZMQA4]
	#
	#*Description:*
	#
	#Offer customer promotional pricing
	#
	#*Steps to Reproduce:*
	#
	#* Select an item and create a promotional price (other than default price) rule with a start and end date
	#** Make sure to provide the dates in the past
	#** Make sure promotional price is cheaper than the default price
	#* Navigate to the portal and verify the promotional pricing is not displayed anymore in the e-store
	#
	#*Actual Results:*
	#
	#Price is displayed as a promotional price on the item but is showing correctly in the shopping cart
	#
	#*Expected Results:*
	#
	#The correct price is displayed
	#
	#Promotional price should not be displayed to customers because en ate passed, the user is not qualifying anymore.
	#
	#*Business Justification:*
	#
	#Correct price is displayed to customers
	#
	#*CS Note:*
	#Screenshot attached as a reference
	#
	#*PM Notes:*
	#
	#Bug - *we are not deactivating the price rules (We do not have a scheduled class do deactivate)* but on the page load, we should *evaluate the price rule and see if it is a match or not.* And if the end date has passed it is clearly not matching so the *PriceruleService* should not return that price rule even tho it is active.
	#
	#eg: Companies set discounted prices for early registrations, if you pass a certain date you won't get that price.
	#
	#The fix is likely to go in services, Pricerule service should not return that price, so it is not a UI Bug actually. We need to make sure, we call the same method when insert SOL bc the shopping cart and the actual SOL record has the right price.
	#
	#Item List view also shows the promotional price but when u click on a specific item u land on the item detail page. we need to call the price rule service and show u the right price
	#
	#The page itself is on LTE
	#
	#The service method is in FD Service
	@REQ_PD-27744 @TEST_PD-28151 @21winter @22Winter @regression @pavan
	Scenario: Test Promotional Price appearing in eStore AFTER Price Rule End Date
		Given User creates a item to catalog and configure the price rule with start and past date with past date
			| itemName           | itemPrice | catalog     | ruleName      | discountprice |
			| priceRuleConfigure | 40        | Merchandise | discountPrice | 20            |
		When User navigate to community Portal page with "cdulce@mailinator.com" user and password "705Fonteva" as "authenticated" user
		Then User Should navigate to store and add a item "priceRuleConfigure" and validate the price displayed for Item is "$40.00"
		And User verifies the final amount "$40.00" on the checkout page


