@REQ_PD-27172
Feature: When there is a credit memo created because of an overpayment to an invoice that has adjustment(s), duplicate credit memo's are created.
	#*Case Reporter* Diego Alzugaray
	#
	#*Customer* The Association For Manufacturing Technology
	#
	#*Reproduced by* Diego Alzugaray in 21Winter.0.2
	#
	#*Reference Case#* [00030529|https://fonteva.my.salesforce.com/5004V000016LfBAQA0]
	#
	#*Description:*
	#
	#Creating a credit memo because of an overpayment to an invoice that has adjustment(s).
	#
	#*Steps to Reproduce:*
	#
	#1) Go to a contact record
	#
	#2) Press Rapid Order Entry
	#
	#3) Add any item
	#
	#4) Change picklist to Invoice and press go
	#
	#5) Press Ready for Payment
	#
	#6) Go to related Sales Order Lines
	#
	#7) Click on checkbox next to Sales Order Line and press Create Credit Note
	#
	#8) Edit related adjustment Sales Order Line
	#
	#9) Change Sale Price to a negative value that will still leave a balance on the invoice (I.E. if the Invoice was for $100, change Sales Price to -$80)
	#
	#10) Post the Credit Note
	#
	#11) Go back to Sales Order
	#
	#12) Press Apply payment
	#
	#13) Overpay the invoice by $50
	#
	#14) Go back to Sales Order
	#
	#15) Press "Create Credit Memo"
	#
	#*Expected Results:*
	#
	#1) Balance Due on S/O should be 0
	#
	#2) Only one Credit Memo should be created
	#
	#3) There should only be one set of transactions related to the credit memo creation
	#
	#*Actual Results:*
	#
	#1) Balance due is not 0
	#
	#2) 2 Credit memo's are created
	#
	#3) Duplicate transactions are created per credit memo (4 transactions)
	#
	#*Business Justification:*
	#
	#Financial data will be incorrect, duplicate credit memo's and duplicate transaction lines created.
	#
	#*Dev Notes*
	#
	#[~accountid:557058:fb8f97f1-b4ed-4c05-98e8-04370d1ee764] to add notes
	#
	#
	#
	#
	#
	#
	#
	#*FIX SCENARIOS:*
	#
	#*SIMPLEST SCENARIO: #1*
	#
	#* The invoice with only 1 item overpay and the create credit memo
	#** FIX 1 = On the adjustment line. do not show the negative balance due (We do not care the balance due on the child adjustment SOLs)
	#** FIX 2=  On the Parent SOL (main item we invoiced) is getting the “Adjustment“ field populated wrong. Seems like the value is doubled. (eg. we made $15 adjustment so Child adj SOL is 15 USD but it got rolled up to parent as $30)
	#** FIX 2 should fix the balance due issue on the Sales Order itself, bc SO is rolling up values from SOLs
	#
	#*SCENARIO: #2 (HOW MANY CM or Adjustment lines to create?)*
	#
	#* SHORT ANSWER IS: The system may create more than one Credit Memo if you have more than 1 overpaid SOL. So as a result you may get more than one Adjustment SOLs.
	#* IMPORTANT: Adjustment SOLs should only be created against the overpaid lines.
	#** So If I have 2 overpaid lines --> I will get 2 CM and 2 Adjustment SOL
	#** Having an existing Adjustment SOL (Before the CM) should {color:#ff5630}*NOT*{color} impact the CM creation, we should only create CM and Adjustment SOL for MAIN SOLs which are overpaid.
	#* *EXAMPLE:*
	#** SO
	#*** SOL#1 (Main) 10 USD
	#**** Overall Total 10 USD
	#**** Adjustment 2 USD
	#**** Amount Paid 0 USD
	#**** Balance Due 8 USD
	#*** SOL#2 (Adjustment before payment) -2 USD
	#**** Overall Total -2 USD (Sale Price and Total Price is also -2 USD)
	#**** Adjustment 0 USD
	#**** Amount Paid 0 USD
	#**** Balance Due 0 USD
	#*** {color:#00b8d9}*BEFORE PAYMENT Now the balance due is 8 USD on the main SOL and also on the SO*{color}
	#*** Customer Over Pays, 10 USD
	#**** SOL#1
	#***** Overall Total 10 USD
	#***** Adjustment 2 USD
	#***** Amount Paid 10 USD
	#***** Balance Due -2 USD
	#**** SOL #2
	#***** Remains the same payment won't get applied to adjustment lines
	#*** {color:#00b8d9}*CUSTOMER CREATES CREDIT MEMO (Since Order is paid and has a negative  balance due)*{color}
	#**** The expectation is the system will create only one Adjustment line for overpaid SOL (SOL#1)
	#***** SOL#1
	#****** Overall Total 10 USD
	#****** Adjustment 2+2 = 4 USD (1 from SOL#1 and SOL #2)
	#****** Amount Paid 10 USD
	#****** Balance Due 0 USD
	#***** SOL #2 (_Adjustment_)
	#****** *_Remains the same. Credit Memo has nothing to do with this one_*
	#***** SOL #3 (NEW Adjustment LineCredit bc of a Credit Memo)
	#****** Overall Total -2 USD (Sale Price and Total Price is also -2 USD)
	#****** Adjustment 0 USD
	#****** Amount Paid 0 USD
	#****** Balance Due 0 USD

	#Tests *Case Reporter* Diego Alzugaray
	#
	#*Customer* The Association For Manufacturing Technology
	#
	#*Reproduced by* Diego Alzugaray in 21Winter.0.2
	#
	#*Reference Case#* [00030529|https://fonteva.my.salesforce.com/5004V000016LfBAQA0]
	#
	#*Description:*
	#
	#Creating a credit memo because of an overpayment to an invoice that has adjustment(s).
	#
	#*Steps to Reproduce:*
	#
	#1) Go to a contact record
	#
	#2) Press Rapid Order Entry
	#
	#3) Add any item
	#
	#4) Change picklist to Invoice and press go
	#
	#5) Press Ready for Payment
	#
	#6) Go to related Sales Order Lines
	#
	#7) Click on checkbox next to Sales Order Line and press Create Credit Note
	#
	#8) Edit related adjustment Sales Order Line
	#
	#9) Change Sale Price to a negative value that will still leave a balance on the invoice (I.E. if the Invoice was for $100, change Sales Price to -$80)
	#
	#10) Post the Credit Note
	#
	#11) Go back to Sales Order
	#
	#12) Press Apply payment
	#
	#13) Overpay the invoice by $50
	#
	#14) Go back to Sales Order
	#
	#15) Press "Create Credit Memo"
	#
	#*Expected Results:*
	#
	#1) Balance Due on S/O should be 0
	#
	#2) Only one Credit Memo should be created
	#
	#3) There should only be one set of transactions related to the credit memo creation
	#
	#*Actual Results:*
	#
	#1) Balance due is not 0
	#
	#2) 2 Credit memo's are created
	#
	#3) Duplicate transactions are created per credit memo (4 transactions)
	#
	#*Business Justification:*
	#
	#Financial data will be incorrect, duplicate credit memo's and duplicate transaction lines created.
	#
	#*Dev Notes*
	#
	#[~accountid:557058:fb8f97f1-b4ed-4c05-98e8-04370d1ee764] to add notes
	@TEST_PD-27733 @REQ_PD-27172 @21Winter @22Winter @regression @ngunda
	Scenario: Test When there is a credit memo created because of an overpayment to an invoice that has adjustment(s), duplicate credit memo's are created.
		Given User will select "Max Foxworth" contact
		And User opens the Rapid Order Entry page from contact
		When User should be able to add "AutoItem6" item on rapid order entry
		And User selects "Invoice" as payment method and proceeds further
		And User creates creditNotes for the sales order Line item created using "ROE"
		And User updates the Adjustment line Item sales Price such that Balance due is "negative"
		And User Posts the Credit Note
		When User "Max Foxworth" makes "Extra" payment for the created order
		And User creates Credit Memo for the order
		Then User verifies the Balance Due on SalesOrder is zero
		And User Verifies only one transaction created for credit memo and SalesOrder line is populated on Transaction lines
