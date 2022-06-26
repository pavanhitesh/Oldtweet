@REQ_PD-27894
Feature: Contact on the receipt is different from the Sales Order, Sales Order lines, and Receipt lines.
	#h2. Steps to Reproduce
	#
	#* Process an order using ROE under an account,
	#* Change the contact on the order from Bob Kelley (Primary) to Someone else (Contact B) under the same account
	#* Process the order using apply payment page.
	#** you can pay via CC or offline does not matter
	#* The contact on the Sales order, sales order lines, and receipt lines is set to Contact B, but the contact on the Receipt defaults to the primary contact on the Account i.e., Bob Kelley.Link
	#
	#
	#
	#h2. Expected Results
	#
	#
	#
	#The contact on the Receipt should not default to the Primary Contact on the account and should be the same as we have on the Sales Order, Sales Order lines, and Receipt lines. 
	#
	#
	#
	#h2. *Quick PM NOTE:* 
	#
	#See when the user landed to apply payment page which contacts populated on the top right section of the page. BC we should be using that account and contact to populate on the receipt. 
	#
	#Sample Scenario would be. The accounting department is paying company orders.
	#
	#We have addressed this issue for offline payments with this ticket, [https://fonteva.atlassian.net/browse/PD-28029|https://fonteva.atlassian.net/browse/PD-28029|smart-link] 
	#
	#let;'s’s go ahead and test CC payment as well and apply the same fix if it is not working. 
	#
	#
	#
	#h2. Actual Results
	#
	#
	#
	#We have changed the contact from Bob Kelley (Primary) to Caroline Qureshi while placing an order using ROE, but upon completing the processing the contact on Receipt defaults to the primary contact on the account i.e., Bob Kelley, however, the contact on the Sales Order, Sales Order lines, and Receipt lines is set to Caroline Qureshi.
	#
	#h2. Business Justification
	#
	#unknown

	#Tests h2. Steps to Reproduce
	#
	#* Process an order using ROE under an account,
	#* Change the contact on the order from Bob Kelley (Primary) to Someone else (Contact B) under the same account
	#* Process the order using apply payment page.
	#** you can pay via CC or offline does not matter
	#* The contact on the Sales order, sales order lines, and receipt lines is set to Contact B, but the contact on the Receipt defaults to the primary contact on the Account i.e., Bob Kelley.Link
	#
	#
	#
	#h2. Expected Results
	#
	#
	#
	#The contact on the Receipt should not default to the Primary Contact on the account and should be the same as we have on the Sales Order, Sales Order lines, and Receipt lines. 
	#
	#
	#
	#h2. *Quick PM NOTE:* 
	#
	#See when the user landed to apply payment page which contacts populated on the top right section of the page. BC we should be using that account and contact to populate on the receipt. 
	#
	#Sample Scenario would be. The accounting department is paying company orders.
	#
	#We have addressed this issue for offline payments with this ticket, [https://fonteva.atlassian.net/browse/PD-28029|https://fonteva.atlassian.net/browse/PD-28029|smart-link] 
	#
	#let;'s’s go ahead and test CC payment as well and apply the same fix if it is not working. 
	#
	#
	#
	#h2. Actual Results
	#
	#
	#
	#We have changed the contact from Bob Kelley (Primary) to Caroline Qureshi while placing an order using ROE, but upon completing the processing the contact on Receipt defaults to the primary contact on the account i.e., Bob Kelley, however, the contact on the Sales Order, Sales Order lines, and Receipt lines is set to Caroline Qureshi.
	#
	#h2. Business Justification
	#
	#unknown
	@TEST_PD-28727 @REQ_PD-27894 @21winter @22winter @regression @pavan
	Scenario: Test Contact on the receipt is different from the Sales Order, Sales Order lines, and Receipt lines.
		Given User will select "Global Media" account
		And User opens the Rapid Order Entry page from account
		And User changes the order contact to non-primary contact "Coco Dulce"
		When User should be able to add "AutoItem1" item on rapid order entry
		And User navigate to "apply payment" page for "AutoItem1" item from rapid order entry
		And User should be able to apply payment for "AutoItem1" item using "Credit Card" payment on apply payment page
		Then User verfies the non-primary contact is displayed in receipt,receipt line item,salesorder and salesorder line item


