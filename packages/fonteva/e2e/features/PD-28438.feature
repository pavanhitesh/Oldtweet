@REQ_PD-28438
Feature: Deposit Account on Receipt is not referencing the Deposit Account on the Apply Payment page
	#h2. Details
	#
	#*Screen recording:*
	#[https://www.screencast.com/t/6E2a4F0g|https://www.screencast.com/t/6E2a4F0g]
	#
	#
	#
	#h2. Org to Reproduce
	#
	#The Receipt is not showing the Deposit Account assigned in ROE by the batch.
	#
	#* GCO (20Spring.0.26) Org ID: 00D4x000000JXuG
	#* GCO (21Winter.0.9) Org ID: 00D5Y000002Vp4H
	#
	#21Winter GCO Receipt example:
	#[https://gco3rswln.my.salesforce.com/a1E5Y00000AloYkUAJ|https://gco3rswln.my.salesforce.com/a1E5Y00000AloYkUAJ]
	#
	#20Spring.0.26 GCO Receipt example:
	#[https://gcomlvez.my.salesforce.com/a1E4x000000u4twEAA|https://gcomlvez.my.salesforce.com/a1E4x000000u4twEAA]
	#
	#h2. Steps to Reproduce
	#
	#Create a batch (steps to create a new batch [https://docs.fonteva.com/user/Creating-a-Batch.1579712553.html|https://docs.fonteva.com/user/Creating-a-Batch.1579712553.html|smart-link] )
	#
	#* Navigate to Batch object and select New
	#* Enter the following:
	#* Batch Name = anything
	#* Opened Date = TODAY
	#* Expected Count = 1 or >1
	#* Expected Amount = 10000.00
	#* Deposit Account = 1060-Merchant Account Services (CASBO)
	#**  Use a GL account that is different from the default deposit account setup in eBusiness User/Profile Preferences
	#** To find the default deposit account navigate to Spark Admin > Apps > Charge > eBusiness User/Profile Preferences > Verify the Deposit Account
	#** Use a GL account from the same Business Group
	#* Business Group = FON-International Association
	#* Default Date = TODAY
	#* Select Save
	#* Navigate to a Contact
	#* Create a sales order in rapid order entry
	#* Add an item to the order
	#* Select Proforma Invoice
	#* Select Go and Select Send Email and Select Close
	#* Select Apply Payment on the Sales Order record
	#* Enter the following on the Apply Payment page
	#* Payment Type = Offline - Check
	#* Reference Number = Any number
	#* Batch = Cash 08312021
	#** Validate that the Deposit account field is updated with the deposit account value configured on the batch
	#* Select Apply Payment
	#* Verify the Receipt's Deposit Account field
	#
	#
	#*EXPECTED RESULTS*
	#
	#The Receipt's Deposit Account reflects the Deposit Account from the Apply Payment page
	#
	#
	#
	#*ACTUAL RESULTS*
	#
	#The Receipt's Deposit Account does not reflect the Deposit Account from the Apply Payment page instead uses the default account setup under the eBusiness User/Profile Preferences
	#
	#
	#
	#*BUSINESS JUSTIFICATION*
	#
	#CASBO staff has to devote a significant amount of time to manually fix this issue. Increased labor cost.
	#
	#
	#
	#*DEV NOTE:*
	#
	#Check e-payment record since receipt gets created via payment.
	#
	#ReceiptlineServices.
	#
	#
	#
	#*PM / QA NOTE:*
	#
	#Test Offline and Credit Card payments

	#Tests h2. Details
	#
	#*Screen recording:*
	#[https://www.screencast.com/t/6E2a4F0g|https://www.screencast.com/t/6E2a4F0g]
	#
	#
	#
	#h2. Org to Reproduce
	#
	#The Receipt is not showing the Deposit Account assigned in ROE by the batch.
	#
	#* GCO (20Spring.0.26) Org ID: 00D4x000000JXuG
	#* GCO (21Winter.0.9) Org ID: 00D5Y000002Vp4H
	#
	#21Winter GCO Receipt example:
	#[https://gco3rswln.my.salesforce.com/a1E5Y00000AloYkUAJ|https://gco3rswln.my.salesforce.com/a1E5Y00000AloYkUAJ]
	#
	#20Spring.0.26 GCO Receipt example:
	#[https://gcomlvez.my.salesforce.com/a1E4x000000u4twEAA|https://gcomlvez.my.salesforce.com/a1E4x000000u4twEAA]
	#
	#h2. Steps to Reproduce
	#
	#Create a batch (steps to create a new batch [https://docs.fonteva.com/user/Creating-a-Batch.1579712553.html|https://docs.fonteva.com/user/Creating-a-Batch.1579712553.html|smart-link] )
	#
	#* Navigate to Batch object and select New
	#* Enter the following:
	#* Batch Name = anything
	#* Opened Date = TODAY
	#* Expected Count = 1 or >1
	#* Expected Amount = 10000.00
	#* Deposit Account = 1060-Merchant Account Services (CASBO)
	#**  Use a GL account that is different from the default deposit account setup in eBusiness User/Profile Preferences
	#** To find the default deposit account navigate to Spark Admin > Apps > Charge > eBusiness User/Profile Preferences > Verify the Deposit Account
	#** Use a GL account from the same Business Group
	#* Business Group = FON-International Association
	#* Default Date = TODAY
	#* Select Save
	#* Navigate to a Contact
	#* Create a sales order in rapid order entry
	#* Add an item to the order
	#* Select Proforma Invoice
	#* Select Go and Select Send Email and Select Close
	#* Select Apply Payment on the Sales Order record
	#* Enter the following on the Apply Payment page
	#* Payment Type = Offline - Check
	#* Reference Number = Any number
	#* Batch = Cash 08312021
	#** Validate that the Deposit account field is updated with the deposit account value configured on the batch
	#* Select Apply Payment
	#* Verify the Receipt's Deposit Account field
	#
	#
	#*EXPECTED RESULTS*
	#
	#The Receipt's Deposit Account reflects the Deposit Account from the Apply Payment page
	#
	#
	#
	#*ACTUAL RESULTS*
	#
	#The Receipt's Deposit Account does not reflect the Deposit Account from the Apply Payment page instead uses the default account setup under the eBusiness User/Profile Preferences
	#
	#
	#
	#*BUSINESS JUSTIFICATION*
	#
	#CASBO staff has to devote a significant amount of time to manually fix this issue. Increased labor cost.
	#
	#
	#
	#*DEV NOTE:*
	#
	#Check e-payment record since receipt gets created via payment.
	#
	#ReceiptlineServices.
	#
	#
	#
	#*PM / QA NOTE:*
	#
	#Test Offline and Credit Card payments
	@TEST_PD-28808 @REQ_PD-28438 @21Winter @22Winter @regression @ngunda
	Scenario Outline: Test Deposit Account on Receipt is not referencing the Deposit Account on the Apply Payment page
		Given User creates batch with the following information:
			| BusinessGroup | DefaultDate | DepositAccount                           | ExpectedAmount | ExpectedCount | OpenedDate  |
			| Foundation    | CurrentDate | 1100-01 - Foundation Accounts Recievable | 10000          | 2             | CurrentDate |
		When User will select "<ContactName>" contact
		And User opens the Rapid Order Entry page from contact
		When User should be able to add "<ItemName>" item on rapid order entry
		And User selects "<InvoiceType>" as payment method and proceeds further
		And User sends Proforma Invoice email
		And User navigates to apply payment page from SalesOrder
		And User updates the batch and verifies the Deposit Account is updated
		Then User completes the payment using "<PaymentType>" and verifies the deposit account on Receipt

		Examples:
			| PaymentType     | ContactName  | ItemName   | InvoiceType      |
			| Offline - Check | Max Foxworth | AutoItem6  | Proforma Invoice |
			| Credit Card     | Max Foxworth | AutoLTItem | Proforma Invoice |
