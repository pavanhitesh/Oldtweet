@REQ_PD-27838
Feature: LT Checkout - SO entity account cannot add address and complete the payment
	#*Case Reporter* Kris Witt
	#
	#*Customer* Material Handling Industry
	#
	#*Reproduced by* John Herrera in 20Spring.1.12
	#
	#*Reference Case#* [00031596|https://fonteva.my.salesforce.com/5004V00001725eHQAQ]
	#
	#*ORG To Reproduce:*
	#
	#* GCO Org ID (20Spring.1): 00D4W0000092BSp
	#
	#*Recording:* {color:#ff5630}*WATCH THE VIDEO FOR GROOMING*{color}
	#
	#[https://www.screencast.com/t/4gL16mzkGp|https://www.screencast.com/t/4gL16mzkGp]
	#
	#
	#
	#*PM NOTE:*
	#
	#* you can create an order from backend ROE or Manual but make sure the entity is ACCOUNT and you have to pay from the frontend.
	#* If the entity is contact, it is working fine.
	#* The issue is on the Store Checkout Page (FE) - LTE Package
	#*
	#
	#*Steps to Reproduce:*
	#
	## The (Primary Contact) User is authenticated and paying for the order with a Credit Card
	## The User is not able to complete the payment
	## Navigate to the payment gateway record related to the Business Group
	## Enable AVS on the Payment Gateway (select Validate Billing Address as the value from the picklist)
	## Navigate to an Account record with a primary contact that has no known addresses
	## Click on the Rapid Order Entry button
	## Add an item to the order
	## Exit to the Sales Order
	## Click on
	### Posting Entity = Receipt
	### Schedule Type = Simple Receipt
	### Sales Order Status = Unpaid
	## Navigate to Fonteva's checkout page using the custom formula field on the Sales Order record
	### THE DEVELOPER CAN CONSTRUCT THE URL MANUALLY {color:#00b8d9}*NO NEED TO CREATE A CUSTOM FORMULA FIELD*{color}
	## On the checkout page, input the Credit Card information and create a Billing Address
	#
	#*Actual Results:*
	#
	#* The Billing Address is not captured on the frontend but it is captured in the backend
	#
	#*Expected Results:*
	#
	#* The Billing Address is captured on the frontend so th*e User can complete payment.*
	#
	#*Business Justification:*
	#
	#* The customer uses a custom formula field utilizing our Fonteva Checkout page to send Sales Orders out to customers for payment
	#* This impacts the customer's ability to retrieve the revenue

	#Tests *Case Reporter* Kris Witt
	#
	#*Customer* Material Handling Industry
	#
	#*Reproduced by* John Herrera in 20Spring.1.12
	#
	#*Reference Case#* [00031596|https://fonteva.my.salesforce.com/5004V00001725eHQAQ]
	#
	#*ORG To Reproduce:*
	#
	#* GCO Org ID (20Spring.1): 00D4W0000092BSp
	#
	#*Recording:* {color:#ff5630}*WATCH THE VIDEO FOR GROOMING*{color}
	#
	#[https://www.screencast.com/t/4gL16mzkGp|https://www.screencast.com/t/4gL16mzkGp]
	#
	#
	#
	#*PM NOTE:*
	#
	#* you can create an order from backend ROE or Manual but make sure the entity is ACCOUNT and you have to pay from the frontend.
	#* If the entity is contact, it is working fine.
	#* The issue is on the Store Checkout Page (FE) - LTE Package
	#*
	#
	#*Steps to Reproduce:*
	#
	## The (Primary Contact) User is authenticated and paying for the order with a Credit Card
	## The User is not able to complete the payment
	## Navigate to the payment gateway record related to the Business Group
	## Enable AVS on the Payment Gateway (select Validate Billing Address as the value from the picklist)
	## Navigate to an Account record with a primary contact that has no known addresses
	## Click on the Rapid Order Entry button
	## Add an item to the order
	## Exit to the Sales Order
	## Click on
	### Posting Entity = Receipt
	### Schedule Type = Simple Receipt
	### Sales Order Status = Unpaid
	## Navigate to Fonteva's checkout page using the custom formula field on the Sales Order record
	### THE DEVELOPER CAN CONSTRUCT THE URL MANUALLY {color:#00b8d9}*NO NEED TO CREATE A CUSTOM FORMULA FIELD*{color}
	## On the checkout page, input the Credit Card information and create a Billing Address
	#
	#*Actual Results:*
	#
	#* The Billing Address is not captured on the frontend but it is captured in the backend
	#
	#*Expected Results:*
	#
	#* The Billing Address is captured on the frontend so th*e User can complete payment.*
	#
	#*Business Justification:*
	#
	#* The customer uses a custom formula field utilizing our Fonteva Checkout page to send Sales Orders out to customers for payment
	#* This impacts the customer's ability to retrieve the revenue
	@REQ_PD-27838 @TEST_PD-28414 @22Winter @21Winter @regression @svinjamuri
	Scenario Outline: Test Unable to proceed with payment no discount code is selected for Taxable Item
		Given User navigate to community Portal page with "ettabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User should be able to select "AutoAdditionalItem" item with quantity "1" on store
		And User selects Add to Cart from Additional items page without selecting additional item
		When User should click on the checkout button
		Then User Should add the new address as name "<name>" , type "<type>" and address "<address>"

		Examples:
			| itemName  | ruleName              | price | sourceCode      | name | type | address                               |
			| AutoItem1 | New discountNew Price | 20    | discountNewCode | test | Home | 123 Melrose Street, Brooklyn, NY, USA |
