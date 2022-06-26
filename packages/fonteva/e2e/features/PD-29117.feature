@REQ_PD-29117
Feature: $0 Shipping Fee or Free Shipping Item are missing on Sales Order
	#h2. Details
	#Scenario 1:
	#In ROE, when override the shipping fee down to $0, there is NO Sales Order Line generated for the Shipping Fee.
	#
	#Scenario 2:
	#In ROE, when choosing a Free Shipping Item for the shipping method, there is NO Sales Order Line generated for the Shipping Fee.
	#
	#However, in the Community Portal Store, when choosing a Free Shipping Item for the shipping method, the Sales Order Line is generated for the Shipping Fee.
	#
	#The above behavior happen in 21Winter, 20Spring.0, and 20Spring.1
	#In 2019-R1: when the shipping fee was reduced to $0 in ROE, the shipping fee would stay on the sales order.
	#h2. Steps to Reproduce
	#Scenario 1:
	#1. Go into ROE
	#2. Add a shippable item
	#3. Go to next screen
	#4. Override the shipping amount to $0
	#5. Go to next screen and pay
	#6. Review the sales order and you will see the shipping fee is not there.
	#
	#
	#Scenario 2:
	#1. Create an Free Shipping Item:
	#    Item Name = Free Shipping
	#    Item Class = Fon-Fedex Shipping Carrier
	#    Item Price = $0.00
	#    Is Active = True
	#    Is Shipping Rate = True
	#    Shipping Region
	#    Fon-US Shipping
	#    Delivery Method: Fon-Fedex Ground
	#    Maximum Weight = 25
	#
	#2. Go into ROE
	#2. Add a shippable item
	#3. Go to next screen
	#4. Choose the above "Free Shipping" item as the Shipping Method
	#5. Go to next screen and pay
	#6. Review the sales order and you will see the shipping fee is not there.
	#h2. Expected Results
	#A Sales Order Line should still be generated even when the shipping is free, to reflect the Shipping Method being selected by the customer.
	#h2. Actual Results
	#The $0 Shipping Fee or Free Shipping Item are not showing on Sales Order.
	#h2. Business Justification
	#When the client offers free shipping to their customers, the merchandise purchased still need to be shipped to the customers.
	#But because they can't see the shipping fee item in the Sales Orders, the client had a hard time to tell which shipping method was chosen by their customers.

	#Tests h2. Details
	#Scenario 1:
	#In ROE, when override the shipping fee down to $0, there is NO Sales Order Line generated for the Shipping Fee.
	#
	#Scenario 2:
	#In ROE, when choosing a Free Shipping Item for the shipping method, there is NO Sales Order Line generated for the Shipping Fee.
	#
	#However, in the Community Portal Store, when choosing a Free Shipping Item for the shipping method, the Sales Order Line is generated for the Shipping Fee.
	#
	#The above behavior happen in 21Winter, 20Spring.0, and 20Spring.1
	#In 2019-R1: when the shipping fee was reduced to $0 in ROE, the shipping fee would stay on the sales order.
	#h2. Steps to Reproduce
	#Scenario 1:
	#1. Go into ROE
	#2. Add a shippable item
	#3. Go to next screen
	#4. Override the shipping amount to $0
	#5. Go to next screen and pay
	#6. Review the sales order and you will see the shipping fee is not there.
	#
	#
	#Scenario 2:
	#1. Create an Free Shipping Item:
	#    Item Name = Free Shipping
	#    Item Class = Fon-Fedex Shipping Carrier
	#    Item Price = $0.00
	#    Is Active = True
	#    Is Shipping Rate = True
	#    Shipping Region
	#    Fon-US Shipping
	#    Delivery Method: Fon-Fedex Ground
	#    Maximum Weight = 25
	#
	#2. Go into ROE
	#2. Add a shippable item
	#3. Go to next screen
	#4. Choose the above "Free Shipping" item as the Shipping Method
	#5. Go to next screen and pay
	#6. Review the sales order and you will see the shipping fee is not there.
	#h2. Expected Results
	#A Sales Order Line should still be generated even when the shipping is free, to reflect the Shipping Method being selected by the customer.
	#h2. Actual Results
	#The $0 Shipping Fee or Free Shipping Item are not showing on Sales Order.
	#h2. Business Justification
	#When the client offers free shipping to their customers, the merchandise purchased still need to be shipped to the customers.
	#But because they can't see the shipping fee item in the Sales Orders, the client had a hard time to tell which shipping method was chosen by their customers.
	@TEST_PD-29369 @REQ_PD-29117 @regression @21Winter @22Winter @ngunda
	Scenario: Test $0 Shipping Fee or Free Shipping Item are missing on Sales Order - Override Scenario
		Given User will select "Max Foxworth" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoSubItemWithTaxAndShipping" item on rapid order entry
		And User navigate to "Shipping and Tax" page for "AutoSubItemWithTaxAndShipping" item from rapid order entry
		And User Selects the shipping method "Fedex Overnight"
		And User overrides the shipping price to 0 
		And User proceeds to paymentpage
		Then User should be able to apply payment for "AutoSubItemWithTaxAndShipping" item using "Credit Card" payment on apply payment page
		And User verifies shipping SalesOrderLine item is created for the salesorder

	@TEST_PD-29370 @REQ_PD-29117 @regression @21Winter @22Winter @ngunda
	Scenario: Test $0 Shipping Fee or Free Shipping Item are missing on Sales Order - Free Shipping Method
		Given User will select "Max Foxworth" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoSubItemWithTaxAndShipping" item on rapid order entry
		And User navigate to "Shipping and Tax" page for "AutoSubItemWithTaxAndShipping" item from rapid order entry
		And User Selects the shipping method "United States Ground Shipping"
		And User proceeds to paymentpage
		Then User should be able to apply payment for "AutoSubItemWithTaxAndShipping" item using "Credit Card" payment on apply payment page
		And User verifies shipping SalesOrderLine item is created for the salesorder
