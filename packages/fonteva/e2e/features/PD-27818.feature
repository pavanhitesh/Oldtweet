@REQ_PD-27818
Feature: Paying multiple proforma Sales Orders in the portal does not generate a receipt or epayment record
	#*Case Reporter* Gaurav Juneja
	#
	#*Customer* International Institute of Business Analysis
	#
	#*Reproduced by* John Herrera in 20Spring.1.8,21Winter.0.5
	#
	#*Reference Case#* [00030701|https://fonteva.my.salesforce.com/5004V000016Mhn0QAC]
	#
	#*Description:*
	#
	#Recording:
	#
	#[https://www.screencast.com/t/Uh2NrAeF5|https://www.screencast.com/t/Uh2NrAeF5]
	#
	#* GCO did not generate a receipt
	#* Customer Org generated one receipt but it is only linked to one Sales Order
	#
	#
	#
	#*PM NOTE:*
	#
	#See this ticket [+PD-28052+|https://fonteva.atlassian.net/browse/PD-28052], fix that one first and test this ticket afterwards:
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#Create two Sales Orders in Backend (SO type receipt and check the checkbox called Is Proforma and Click ready for Payment)
	#
	#* Go to an Account
	#* Open ROE
	#* Create a Sales Order for one Item
	#** Type = Proforma
	#* Repeat steps for another Sales Order
	#
	#Process the Sales Orders
	#
	#* Login to the Experience as the Account's Primary Contact
	#* Select Company Orders
	#* Click checkbox next to the two proforma Sales Orders
	#* Click Pay Now
	#* Enter Payment Method (ie CC) and select Process Payment
	#
	#Navigate to Backend and verify if Receipt records are created
	#
	#*Actual Results:*
	#
	#* No Receipt record(s) created
	#* No ePayment record(s) created
	#
	#*Expected Results:*
	#
	#{color:#ff5630}-There is one receipt created per Sales Order.  NOT CORRECT-{color}
	#
	#{color:#00b8d9}*PM UPDATED THE EXPECTED RESULT HERE:* {color}
	#
	#* I should have EPayment. andReceipt records generated.
	#* THE RECEIPT HAS A LOOKUP TO SO, SO IF YOU PAY MULTIPLE SO AT A TIME, THE SYSTEM, WILL NOT POPULATE THE SO LOOKUP ON THE RECEIPT.
	#* INSTEAD, CUSTOMER WILL HAVE THEIR RECEIPT LINES WITH SOL LOOKUPS POPULATED.
	#
	#*Business Justification:*
	#
	#* Causes incorrect revenue reporting
	#* The finance team needs to relate the Sales Orders and Receipts without interrupting the Accounting
	#
	#*CS Note:*
	#GCO (20Spring.1.8) Org ID: 00D4W0000092BSp GCO (21Winter.0.5) Org ID: 00D5Y000001NF95

	#Tests *Case Reporter* Gaurav Juneja
	#
	#*Customer* International Institute of Business Analysis
	#
	#*Reproduced by* John Herrera in 20Spring.1.8,21Winter.0.5
	#
	#*Reference Case#* [00030701|https://fonteva.my.salesforce.com/5004V000016Mhn0QAC]
	#
	#*Description:*
	#
	#Recording:
	#
	#[https://www.screencast.com/t/Uh2NrAeF5|https://www.screencast.com/t/Uh2NrAeF5]
	#
	#* GCO did not generate a receipt
	#* Customer Org generated one receipt but it is only linked to one Sales Order
	#
	#
	#
	#*PM NOTE:*
	#
	#See this ticket [+PD-28052+|https://fonteva.atlassian.net/browse/PD-28052], fix that one first and test this ticket afterwards:
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#Create two Sales Orders in Backend (SO type receipt and check the checkbox called Is Proforma and Click ready for Payment)
	#
	#* Go to an Account
	#* Open ROE
	#* Create a Sales Order for one Item
	#** Type = Proforma
	#* Repeat steps for another Sales Order
	#
	#Process the Sales Orders
	#
	#* Login to the Experience as the Account's Primary Contact
	#* Select Company Orders
	#* Click checkbox next to the two proforma Sales Orders
	#* Click Pay Now
	#* Enter Payment Method (ie CC) and select Process Payment
	#
	#Navigate to Backend and verify if Receipt records are created
	#
	#*Actual Results:*
	#
	#* No Receipt record(s) created
	#* No ePayment record(s) created
	#
	#*Expected Results:*
	#
	#{color:#ff5630}-There is one receipt created per Sales Order.  NOT CORRECT-{color}
	#
	#{color:#00b8d9}*PM UPDATED THE EXPECTED RESULT HERE:* {color}
	#
	#* I should have EPayment. andReceipt records generated.
	#* THE RECEIPT HAS A LOOKUP TO SO, SO IF YOU PAY MULTIPLE SO AT A TIME, THE SYSTEM, WILL NOT POPULATE THE SO LOOKUP ON THE RECEIPT.
	#* INSTEAD, CUSTOMER WILL HAVE THEIR RECEIPT LINES WITH SOL LOOKUPS POPULATED.
	#
	#*Business Justification:*
	#
	#* Causes incorrect revenue reporting
	#* The finance team needs to relate the Sales Orders and Receipts without interrupting the Accounting
	#
	#*CS Note:*
	#GCO (20Spring.1.8) Org ID: 00D4W0000092BSp GCO (21Winter.0.5) Org ID: 00D5Y000001NF95
	@TEST_PD-28541 @REQ_PD-27818 @regression @21Winter @22Winter @ngunda
	Scenario: Test Paying multiple proforma Sales Orders in the portal does not generate a receipt or epayment record
		When User creates salesOrders using ROE from account with below information:
			| Account            | ItemName  | PaymentType      |
			| Foxworth Household | AutoItem1 | Proforma Invoice |
			| Foxworth Household | AutoItem6 | Proforma Invoice |
		And User navigate to community Portal page with "maxfoxworth@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User opens the checkout page for the orders created
		When User successfully pays for the orders using credit card
		Then User verifies the Receipt and ePayment record is created for the paid orders
