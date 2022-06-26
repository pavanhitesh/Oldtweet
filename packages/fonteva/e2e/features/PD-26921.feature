@REQ_PD-26921
Feature: Test When paying multiple invoices in portal from Company Orders the receipts Contact is set as one of the Sales Orders Contacts rather than the Contact who is logged in and making the payment
	#*Case Reporter* Mindy Harding
	#
	#*Customer* Construction Management Association of America
	#
	#*Reproduced by* Eli Nesson in 20Spring.0.6,20Spring.0.10
	#
	#*Reference Case#* [00026389|https://fonteva.my.salesforce.com/5004V000012wsvxQAA]
	#
	#*Description:*
	#
	#When paying multiple orders in portal from Company Orders, the receipt's Contact is set as one of the Sales Orders' Contacts rather than the Contact who is logged in and making the payment
	#
	#Screen recording:
	#
	#[https://www.screencast.com/t/YByaUgz3|https://www.screencast.com/t/YByaUgz3]
	#
	#*Steps to Reproduce:*
	#
	## Set up one account with three related contacts
	### Contact A (primary contact)
	### Contact B
	### Contact C
	## Set up the first SO
	### Open ROE from the account
	### Change the contact to Contact B
	### Add an item and select Invoice
	### Click Ready For Payment
	## Set up the second SO
	### Open ROE from the account
	### Change the contact to Contact C
	### Add an item and select Invoice
	### Click Ready for Payment
	## Log into the Community as Contact A
	## From the Profile page, open the Company Orders tab
	## Select the two invoices just created and click Pay
	## Complete the payment
	#
	#*Actual Results:*
	#
	#The contact on the Receipt is Contact B or Contact C (seemingly assigned at random)
	#
	#*Expected Results:*
	#
	#The contact on the Receipt is Contact A
	#
	#*CS Note:*
	#
	#* In 20Spring, the correct contact is assigned when paying proformas (Sales Order type receipt)
	#* The correct contact is also assigned when paying invoices in Order Summary Builder and BE Appy pay,ent page
	#* In 20Spring, the only scenario I found where the wrong contact was assigned *was from paying invoices from the portal.* This is the scenario the customer reported as well.
	#
	#*T3 Notes:*
	#I think that we need to remove this null check
	#[https://github.com/Fonteva/LightningLens/blob/20Spring/community/main/default/classes/StoreCheckoutController.cls#L943|https://github.com/Fonteva/LightningLens/blob/20Spring/community/main/default/classes/StoreCheckoutController.cls#L943]
	#in order to have payee contact on Epayment instead of SO contact.
	#
	#
	#
	#Estimate
	#
	#QA: 22h

	#Tests *Case Reporter* Mindy Harding
	#
	#*Customer* Construction Management Association of America
	#
	#*Reproduced by* Eli Nesson in 20Spring.0.6,20Spring.0.10
	#
	#*Reference Case#* [00026389|https://fonteva.my.salesforce.com/5004V000012wsvxQAA]
	#
	#*Description:*
	#
	#When paying multiple orders in portal from Company Orders, the receipt's Contact is set as one of the Sales Orders' Contacts rather than the Contact who is logged in and making the payment
	#
	#Screen recording:
	#
	#[https://www.screencast.com/t/YByaUgz3|https://www.screencast.com/t/YByaUgz3]
	#
	#*Steps to Reproduce:*
	#
	## Set up one account with three related contacts
	### Contact A (primary contact)
	### Contact B
	### Contact C
	## Set up the first SO
	### Open ROE from the account
	### Change the contact to Contact B
	### Add an item and select Invoice
	### Click Ready For Payment
	## Set up the second SO
	### Open ROE from the account
	### Change the contact to Contact C
	### Add an item and select Invoice
	### Click Ready for Payment
	## Log into the Community as Contact A
	## From the Profile page, open the Company Orders tab
	## Select the two invoices just created and click Pay
	## Complete the payment
	#
	#*Actual Results:*
	#
	#The contact on the Receipt is Contact B or Contact C (seemingly assigned at random)
	#
	#*Expected Results:*
	#
	#The contact on the Receipt is Contact A
	#
	#*CS Note:*
	#
	#* In 20Spring, the correct contact is assigned when paying proformas (Sales Order type receipt)
	#* The correct contact is also assigned when paying invoices in Order Summary Builder and BE Appy pay,ent page
	#* In 20Spring, the only scenario I found where the wrong contact was assigned *was from paying invoices from the portal.* This is the scenario the customer reported as well.
	#
	#*T3 Notes:*
	#I think that we need to remove this null check
	#[https://github.com/Fonteva/LightningLens/blob/20Spring/community/main/default/classes/StoreCheckoutController.cls#L943|https://github.com/Fonteva/LightningLens/blob/20Spring/community/main/default/classes/StoreCheckoutController.cls#L943]
	#in order to have payee contact on Epayment instead of SO contact.
	#
	#
	#
	#Estimate
	#
	#QA: 22h
	@TEST_PD-27049 @REQ_PD-26921 @regression @21Winter @22Winter @ngunda
	Scenario: Test When paying multiple invoices in portal from Company Orders the receipts Contact is set as one of the Sales Orders Contacts rather than the Contact who is logged in and making the payment
		Given All salesOrders and receipts from account "Foxworth Household" are deleted
		When User creates salesOrders from account using ROE from contacts as below:
			| Account            | Contacts       | ItemName   | PaymentType |
			| Foxworth Household | Larry Foxworth | AutoItem1  | Invoice     |
			| Foxworth Household | Eva Foxworth   | AutoLTItem | Invoice     |
		And User navigate to community Portal page with "maxfoxworth@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User opens Company Order Page and select the orders created to pay
		And User successfully pays for the account orders with credit card
		Then User verifies the payee name in Receipt is primary contact "Max Foxworth"
