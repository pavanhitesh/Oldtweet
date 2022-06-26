@REQ_PD-22435
Feature: Paid Proformas with Customer Entity as Account displays Contact as customer Entity in Salesforce
	#*Reproduced by* Erich Ehinger in 19.1.0.15
	#
	#*Reference Case#*[00020957|https://fonteva.my.salesforce.com/5003A00000zWAm3QAG]
	#
	#*Description:*
	#
	#When you pay a Proforma Sales Order with Entity= Account in Company Orders in the Community, the related Receipt and Transaction records have Customer Entity=Contact.
	#
	#*Steps to Reproduce:*
	#
	## Go to an account and select ROE
	## Purchase an item and select Proforma Invoice as payment type.
	### It can be any item, go with basic merchandise item like a t-shirt
	### Go ahead and send yourself an email
	## Check your email, Proforma link, and proceed with Checkout.
	## Complete the payment
	## In the staff view, locate the related receipt and transaction records.
	#
	#*Actual Results:*
	#
	#The entity on both records will be Contact, instead of Account.
	#
	#*Expected Results*
	#
	#Customer Entity type on the receipt, and receipt record should be Account.
	#
	#*PM NOTE:*
	#
	#Sales Order has a picklist called entity. The values are either contact or account. Another way to say it, the order either belongs to a person or belongs to a company.
	#
	#When this order is processed, {color:#ff5630}all the related records should get the entity value from the sales order{color} like Receipt and Transaction.
	#
	#
	#
	#Estimate
	#
	#QA: 16h

	#Tests *Reproduced by* Erich Ehinger in 19.1.0.15
	#
	#*Reference Case#*[00020957|https://fonteva.my.salesforce.com/5003A00000zWAm3QAG]
	#
	#*Description:*
	#
	#When you pay a Proforma Sales Order with Entity= Account in Company Orders in the Community, the related Receipt and Transaction records have Customer Entity=Contact.
	#
	#*Steps to Reproduce:*
	#
	## Go to an account and select ROE
	## Purchase an item and select Proforma Invoice as payment type.
	### It can be any item, go with basic merchandise item like a t-shirt
	### Go ahead and send yourself an email
	## Check your email, Proforma link, and proceed with Checkout.
	## Complete the payment
	## In the staff view, locate the related receipt and transaction records.
	#
	#*Actual Results:*
	#
	#The entity on both records will be Contact, instead of Account.
	#
	#*Expected Results*
	#
	#Customer Entity type on the receipt, and receipt record should be Account.
	#
	#*PM NOTE:*
	#
	#Sales Order has a picklist called entity. The values are either contact or account. Another way to say it, the order either belongs to a person or belongs to a company.
	#
	#When this order is processed, {color:#ff5630}all the related records should get the entity value from the sales order{color} like Receipt and Transaction.
	#
	#
	#
	#Estimate
	#
	#QA: 16h
	@TEST_PD-27626 @REQ_PD-22435 @21Winter @22Winter @regression @ngunda
	Scenario: Test Paid Proformas with Customer Entity as Account displays Contact as customer Entity in Salesforce
		Given User will select "Foxworth Household" account
		And User opens the Rapid Order Entry page from account
		And User should be able to add "AutoLTItem" item on rapid order entry
		And User selects "Proforma Invoice" as payment method and proceeds further
		And User sends email with payment link and opens the payment link
		When User logins to the portal from payment page with username "Maxfoxworth@mailinator.com" and password "705Fonteva"
		And User successfully pays for the order using credit card
		Then User goes to salesforce and verify the SalesOrder, Receipt and Transaction records entity value is populated as Account
