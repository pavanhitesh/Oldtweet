@REQ_PD-27976
Feature: Paid orders with adjustments show balance due in portal.
	#*Case Reporter* Himali Shah
	#
	#*Customer* Material Handling Industry
	#
	#*Reproduced by* Linda Diemer in 20Spring.1.11,20Spring.1.12
	#
	#*Reference Case#* [00030223|https://fonteva.my.salesforce.com/5004V000015hL71QAE]
	#
	#*Description:*
	#
	#This is a major functionality that is used daily were adjustments are made to invoices and it is important for customers to be able to view the order document and have it show paid instead of causing confusion and showing a balance due. This is preventing system launch.
	#
	#*Org To repro*
	#
	#in GCO
	#
	#[20spring.1@fondash.io|mailto:20spring.1@fondash.io] / Fonteva703
	#
	#*Steps to Reproduce:*
	#
	## Go to Bob Kelley and do ROE for any item
	## Set as Invoice and make ready for payment
	## Add a new Sales Order line with any item following steps in this article: [https://docs.fonteva.com/user/Positive-Adjustments-towards-Invoices.1470595586.html|https://docs.fonteva.com/user/Positive-Adjustments-towards-Invoices.1470595586.html]
	### This is a positive adjustment = adding a new item to this invoice. 
	### *_Do not get confused with Credit Note = Negative adjustment - NOT RELATED TO THIS TICKET_*
	### *_Do not get confused with Credit Memo (which happens after overpayment) - NOT RELATED TO THIS TICKET_*
	## Then proceed to pay the invoice and verify there is no balance due.
	## Login as Bob Kelley to the portal, go in orders, and view all
	## You will see that the order shows paid but when you select to view the document there is still a balance due of the adjustment amount.
	#
	#*Actual Results:*
	#
	#When viewing the document of a paid Sales order where a positive adjustment was made there is still a balance showing due.
	#
	#*Expected Results:*
	#
	#For the document to reflect zero balance since it was paid in full.
	#
	#*PM NOTE:*
	#
	#The Source of truth is balance due field on the SO.
	#
	#*Business Justification:*
	#
	#Customers may get confused as they paid the sales order and there is still a balance due. May also cause upset customers.
	#
	#*T3 Notes:*
	#
	#Balance due are cleared on SO, and all SOLs. Looks like orders page in portal is calculating Balance Due = Order - Receipt + Other Adjustments which caused the difference

	#Tests *Case Reporter* Himali Shah
	#
	#*Customer* Material Handling Industry
	#
	#*Reproduced by* Linda Diemer in 20Spring.1.11,20Spring.1.12
	#
	#*Reference Case#* [00030223|https://fonteva.my.salesforce.com/5004V000015hL71QAE]
	#
	#*Description:*
	#
	#This is a major functionality that is used daily were adjustments are made to invoices and it is important for customers to be able to view the order document and have it show paid instead of causing confusion and showing a balance due. This is preventing system launch.
	#
	#*Org To repro*
	#
	#in GCO
	#
	#[20spring.1@fondash.io|mailto:20spring.1@fondash.io] / Fonteva703
	#
	#*Steps to Reproduce:*
	#
	## Go to Bob Kelley and do ROE for any item
	## Set as Invoice and make ready for payment
	## Add a new Sales Order line with any item following steps in this article: [https://docs.fonteva.com/user/Positive-Adjustments-towards-Invoices.1470595586.html|https://docs.fonteva.com/user/Positive-Adjustments-towards-Invoices.1470595586.html]
	### This is a positive adjustment = adding a new item to this invoice. 
	### *_Do not get confused with Credit Note = Negative adjustment - NOT RELATED TO THIS TICKET_*
	### *_Do not get confused with Credit Memo (which happens after overpayment) - NOT RELATED TO THIS TICKET_*
	## Then proceed to pay the invoice and verify there is no balance due.
	## Login as Bob Kelley to the portal, go in orders, and view all
	## You will see that the order shows paid but when you select to view the document there is still a balance due of the adjustment amount.
	#
	#*Actual Results:*
	#
	#When viewing the document of a paid Sales order where a positive adjustment was made there is still a balance showing due.
	#
	#*Expected Results:*
	#
	#For the document to reflect zero balance since it was paid in full.
	#
	#*PM NOTE:*
	#
	#The Source of truth is balance due field on the SO.
	#
	#*Business Justification:*
	#
	#Customers may get confused as they paid the sales order and there is still a balance due. May also cause upset customers.
	#
	#*T3 Notes:*
	#
	#Balance due are cleared on SO, and all SOLs. Looks like orders page in portal is calculating Balance Due = Order - Receipt + Other Adjustments which caused the difference
	@TEST_PD-28535 @REQ_PD-27976 @21Winter @22winter @regression @Pavan
	Scenario: Test Paid orders with adjustments show balance due in portal.
		Given User will select "Coco Dulce" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoItem1" item on rapid order entry
		And User selects "Invoice" as payment method and proceeds further
		When User creates a new SOL with "AutoItem2" and proceed for payment
		Then User verify there is no balance due on the receipt 
		And  User navigate to community Portal page with "cdulce@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User navigate to All Orders Tab
		And User verifies no balance due displayed for the sales order and in the document

