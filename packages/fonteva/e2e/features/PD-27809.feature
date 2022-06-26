@REQ_PD-27809
Feature: Price Override is automatically populated on sales order line when purchasing a membership item
	#h2. Steps to Reproduce
	#
	#* Access ROE on a contact record, sell a membership record to the contact (do not do price override)
	#* *Notice that 'Price Override' is automatically populated on the SOL*.
	#* Try to renew the membership but do not pay for it yet.
	#* View the associated renewal SOL change the Item to a separate membership item.
	#* Notice that the Sale Price and Total price are not updated.
	#
	#h2. Expected Results
	#
	#*Price Override should not be checked if there is not override that took place.*
	#
	#Changing the item on the SOL and unchecking the price override checkbox should recalculate the price
	#
	#h2. Actual Results
	#
	#Price Override is automatically checked without an actual price override occurring on the SOL.
	#
	#The sale price and total are not updated on the renewal SOL when the Item is changed.
	#
	#The partner working for the client (Himali) has spoken with Ulas and he mentioned that: Changing the item on the SOL and unchecking the price override checkbox should recalculate the price
	#
	#h2. Business Justification
	#
	#The client is purchasing a membership Item and the SOL price override is automatically populated even though there is no price override during the payment processing. This is blocking the client Go-Live timeline and they also need a feasible workaround.
	#
	#
	#
	#h2. *PM NOTE:*
	#
	#The issue might have been fixed with [+￼PD-27730: Price Override is automatically populated on sales order line when purchasing a membership ite+|https://fonteva.atlassian.net/browse/PD-27730][*CLOSED*|https://fonteva.atlassian.net/browse/PD-27730]
	#
	#BUT I NEED ENGINEERS TO SEE HOW IT GOT FIXED and what was the issue.
	#
	#h2. QA Scenario to test:
	#
	#* Add Membership item to cart and then change the item lookup to see the price is getting updated.
	#* Test the same scenario with renewal SO too

	#Tests h2. Steps to Reproduce
	#
	#* Access ROE on a contact record, sell a membership record to the contact (do not do price override)
	#* *Notice that 'Price Override' is automatically populated on the SOL*.
	#* Try to renew the membership but do not pay for it yet.
	#* View the associated renewal SOL change the Item to a separate membership item.
	#* Notice that the Sale Price and Total price are not updated.
	#
	#h2. Expected Results
	#
	#*Price Override should not be checked if there is not override that took place.*
	#
	#Changing the item on the SOL and unchecking the price override checkbox should recalculate the price
	#
	#h2. Actual Results
	#
	#Price Override is automatically checked without an actual price override occurring on the SOL.
	#
	#The sale price and total are not updated on the renewal SOL when the Item is changed.
	#
	#The partner working for the client (Himali) has spoken with Ulas and he mentioned that: Changing the item on the SOL and unchecking the price override checkbox should recalculate the price
	#
	#h2. Business Justification
	#
	#The client is purchasing a membership Item and the SOL price override is automatically populated even though there is no price override during the payment processing. This is blocking the client Go-Live timeline and they also need a feasible workaround.
	#
	#
	#
	#h2. *PM NOTE:*
	#
	#The issue might have been fixed with [+￼PD-27730: Price Override is automatically populated on sales order line when purchasing a membership ite+|https://fonteva.atlassian.net/browse/PD-27730][*CLOSED*|https://fonteva.atlassian.net/browse/PD-27730]
	#
	#BUT I NEED ENGINEERS TO SEE HOW IT GOT FIXED and what was the issue.
	#
	#h2. QA Scenario to test:
	#
	#* Add Membership item to cart and then change the item lookup to see the price is getting updated.
	#* Test the same scenario with renewal SO too
	@TEST_PD-28528 @REQ_PD-27809 @21Winter @22Winter @ngunda @regression
	Scenario: Test Price Override is automatically populated on sales order line when purchasing a membership item
		Given User will select "Etta Brown" contact
		When User opens the Rapid Order Entry page from contact
		And User should be able to add "CalSubNoProrationAndSchPayments" item on rapid order entry
		And User selects "Process Payment" as payment method and proceeds further
		And User should be able to apply payment for "CalSubNoProrationAndSchPayments" item using "Credit Card" payment on apply payment page
		Then User verifies the Price Override option is disabled in sales order line
		And User opens the subscription record created and clicks renew
		Then User verifies the sale price and total price are updated on renewal sales order line when the item is changed to "AutoMembershipwithForm"
