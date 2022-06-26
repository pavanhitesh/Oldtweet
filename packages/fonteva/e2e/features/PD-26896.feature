@REQ_PD-26896
Feature: Unable to proceed with the booking once discount code makes purchase free if tax address is not populated.
	@REQ_PD-26896 @TEST_PD-27037 @regression @21winter @22Winter @pavan
	Scenario Outline: Test Unable to proceed with payment when free Source is applied for Taxable Item
		Given User should removes the known address for the contact "<contactName>"
		And User should create a source code as "<sourceCode>" for channel "Website"
		And User should create a item "<itemName>" which is taxable
		And User should add created item to catalogs "AutoCatalog"
		And User Should the price rule with following details
			| ruleName   | price   | sourceCode   |
			| <ruleName> | <price> | <sourceCode> |
		When User navigate to community Portal page with "cdulce@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User Should navigate to store and add the item "<itemName>"
		And User should click on the checkout button
		And User Should select the sourcecode "<sourceCode>"
		And User Should add the new address as name "<name>" , type "<type>" and address "<address>"
		Then User Should process the payment
		Examples:
			| contactName | itemName          | ruleName       | price | sourceCode | name | type | address                               |
			| Coco Dulce  | Free New Cap | New Free Price | 0     | FreeCode   | test | Home | 123 Melrose Street, Brooklyn, NY, USA |

	@REQ_PD-26896 @TEST_PD-27073 @regression @21Winter @22Winter @pavan
	Scenario Outline: Test Unable to proceed with payment when discounted source is applied for Taxable Item
		Given User should removes the known address for the contact "<contactName>"
		And User should create a source code as "<sourceCode>" for channel "Website"
		And User should create a item "<itemName>" which is taxable
		And User should add created item to catalogs "AutoCatalog"
		And User Should the price rule with following details
			| ruleName   | price   | sourceCode   |
			| <ruleName> | <price> | <sourceCode> |
		When User navigate to community Portal page with "cdulce@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User Should navigate to store and add the item "<itemName>"
		And User should click on the checkout button
		And User Should select the sourcecode "<sourceCode>"
		And User Should add the new address as name "<name>" , type "<type>" and address "<address>"
		And User successfully pays for the order using credit card
		And User should see the "receipt" created confirmation message

		Examples:
			| contactName | itemName          | ruleName           | price | sourceCode   | name | type | address                               |
			| Coco Dulce  | Discount New Cap | New discount Price | 20    | discountCode | test | Home | 123 Melrose Street, Brooklyn, NY, USA |

	#Tests *Case Reporter* Ben Harwood
	#
	#*Customer* Pensions and Lifetime Savings Association
	#
	#*Reproduced by* Kapil Patel in 2019.1.0.30
	#
	#*Reference Case#* [00028708|https://fonteva.my.salesforce.com/5004V000014JpfjQAC]
	#
	#*Description:*
	#
	#I want my client to use the source code so the item can be free.
	#
	#*Overview:*
	#
	#Through our portal it's been noted that if a contact doesn't have a known address and the item originally has a payment required but a discount reduces the item to free, then the booker can't save a tax address (it just goes in an infinite loop).
	#
	#Video attached to explain the issue in detail.
	#
	#*Steps to Reproduce*
	#
	## Create a contact without a known address and enable community user profile
	### Or use an existing Contact but make sure it has no Known Address.
	### Note: known Address is an object you can find it under contact related list.
	## Create an item with a price and make sure the item is taxable.
	### you can use an existing item too, just make sure the item is enabled for tax.
	### Item has a checkbox called "Is Taxable"
	## Add a price rule to the item with a source code to make the item free.
	## Login to the community with contact
	## Go to the Store add the item to the cart and go to checkout
	## Use the source code before creating a known address
	## Process payment
	#
	#
	#
	#*Actual Results:*
	#
	#Checkout is not successful and no message. The user is stuck on the page
	#
	#
	#
	#*Expected Results / Acceptance Results*
	#
	#Checkout should be flawless and the user can complete the purchase with or without a source (discount) code.
	#
	#I can checkout without using source code
	#
	#I can Checkout with the source code
	#
	#* Free Order
	#* Paid Order
	#
	#
	#
	#*Business Justification:*
	#
	#Revenue and data impact, bad user experience.
	#
	#
	#
	#*T3 Notes:*
	#
	#This issue is for logged-in users only. Guest user works well.
	#
	#
	#
	#Estimate
	#
	#QA: 22h
	@REQ_PD-26896 @TEST_PD-27074 @regression @21winter @22Winter @pavan
	Scenario Outline: Test Unable to proceed with payment no discount code is selected for Taxable Item
		Given User should removes the known address for the contact "<contactName>"
		And User should create a source code as "<sourceCode>" for channel "Website"
		And User should create a item "<itemName>" which is taxable
		And User should add created item to catalogs "AutoCatalog"
		And User Should the price rule with following details
			| ruleName   | price   | sourceCode   |
			| <ruleName> | <price> | <sourceCode> |
		When User navigate to community Portal page with "cdulce@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User Should navigate to store and add the item "<itemName>"
		And User should click on the checkout button
		And User Should add the new address as name "<name>" , type "<type>" and address "<address>"
		And User successfully pays for the order using credit card
		Then And User should see the "receipt" created confirmation message

		Examples:
			| contactName | itemName          | ruleName              | price | sourceCode      | name | type | address                               |
			| Coco Dulce  | Composite New Cap | New discountNew Price | 20    | discountNewCode | test | Home | 123 Melrose Street, Brooklyn, NY, USA |
