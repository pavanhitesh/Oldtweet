@REQ_PD-29423
Feature: Manual Pass - The Due date field on the Sales Order is not updating correctly
	#h2. Details
	#
	#The Due date field on the Sales Order is updated with the current date, however, it Should be Invoice Date + Payment Term.
	#
	#h2. Steps to Reproduce
	#
	#Reproduced in  21Winter.0.15
	#Org Id: 00D5Y000001NF95 
	#Login URL: [https://eligco.lightning.force.com/lightning/page/home|https://eligco.lightning.force.com/lightning/page/home] 
	#Username: enesson-20r2b@fonteva.com 
	#Password: Fonteva703 
	#
	#1. Add an item to the cart using rapid order entry. 
	#2. Select "invoice" as a payment method and click Go. 
	#3. In the next screen, the payment term is set to "Net 30".
	#4. Click ready for payment. 
	#Sales order created with the following details:  
	#Status: Closed 
	#Posting Status: Posted 
	#Is Closed: True 
	#Is Posted: True 
	#Posting Entity: Invoice 
	#Schedule Type: Simple Invoice 
	#
	#Date, Invoice Date, Posted Date, Due Date, Closed Date fields are populated with today's date I.e., 12/8/2021 
	#
	#Sales Order: [https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000ANA3ZUAX/view|https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000ANA3ZUAX/view] 
	#
	#Screen Recording: [https://togetherwork-my.sharepoint.com/:v:/g/personal/sbangwal_fonteva_com/EbAqMRgeyAVNrC7_QSuJRAYBaigVXErCsxgx3Vg9gMXFW|https://togetherwork-my.sharepoint.com/:v:/g/personal/sbangwal_fonteva_com/EbAqMRgeyAVNrC7_QSuJRAYBaigVXErCsxgx3Vg9gMXFWA?e=JKAptV]
	#
	#[A?e=JKAptV|https://togetherwork-my.sharepoint.com/:v:/g/personal/sbangwal_fonteva_com/EbAqMRgeyAVNrC7_QSuJRAYBaigVXErCsxgx3Vg9gMXFWA?e=JKAptV]
	#
	#*T3 Notes*
	#
	#we should set {{so.Due_Date__c}} from the new payment term in [https://github.com/Fonteva/orderapi/blob/develop/src/classes/SalesOrder.cls#L489|https://github.com/Fonteva/orderapi/blob/develop/src/classes/SalesOrder.cls#L489]
	#
	#instead of assigning it to *this.invoiceDate*. for example, like in [https://github.com/Fonteva/LightningLens/pull/2295/files|https://github.com/Fonteva/LightningLens/pull/2295/files]
	#
	#h2. Expected Results
	#
	#The Due Date should be set to 30 days from the sales order creation.
	#
	#Due Date = Invoice Date + Payment Term
	#
	#h2. Actual Results
	#
	#The due date is set to current date
	#
	#h2. Business Justification
	#
	#Due Dates are impacting Customer Payments

	#Tests h2. Details
	#
	#The Due date field on the Sales Order is updated with the current date, however, it Should be Invoice Date + Payment Term.
	#
	#h2. Steps to Reproduce
	#
	#Reproduced in  21Winter.0.15
	#Org Id: 00D5Y000001NF95 
	#Login URL: [https://eligco.lightning.force.com/lightning/page/home|https://eligco.lightning.force.com/lightning/page/home] 
	#Username: enesson-20r2b@fonteva.com 
	#Password: Fonteva703 
	#
	#1. Add an item to the cart using rapid order entry. 
	#2. Select "invoice" as a payment method and click Go. 
	#3. In the next screen, the payment term is set to "Net 30".
	#4. Click ready for payment. 
	#Sales order created with the following details:  
	#Status: Closed 
	#Posting Status: Posted 
	#Is Closed: True 
	#Is Posted: True 
	#Posting Entity: Invoice 
	#Schedule Type: Simple Invoice 
	#
	#Date, Invoice Date, Posted Date, Due Date, Closed Date fields are populated with today's date I.e., 12/8/2021 
	#
	#Sales Order: [https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000ANA3ZUAX/view|https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000ANA3ZUAX/view] 
	#
	#Screen Recording: [https://togetherwork-my.sharepoint.com/:v:/g/personal/sbangwal_fonteva_com/EbAqMRgeyAVNrC7_QSuJRAYBaigVXErCsxgx3Vg9gMXFW|https://togetherwork-my.sharepoint.com/:v:/g/personal/sbangwal_fonteva_com/EbAqMRgeyAVNrC7_QSuJRAYBaigVXErCsxgx3Vg9gMXFWA?e=JKAptV]
	#
	#[A?e=JKAptV|https://togetherwork-my.sharepoint.com/:v:/g/personal/sbangwal_fonteva_com/EbAqMRgeyAVNrC7_QSuJRAYBaigVXErCsxgx3Vg9gMXFWA?e=JKAptV]
	#
	#*T3 Notes*
	#
	#we should set {{so.Due_Date__c}} from the new payment term in [https://github.com/Fonteva/orderapi/blob/develop/src/classes/SalesOrder.cls#L489|https://github.com/Fonteva/orderapi/blob/develop/src/classes/SalesOrder.cls#L489]
	#
	#instead of assigning it to *this.invoiceDate*. for example, like in [https://github.com/Fonteva/LightningLens/pull/2295/files|https://github.com/Fonteva/LightningLens/pull/2295/files]
	#
	#h2. Expected Results
	#
	#The Due Date should be set to 30 days from the sales order creation.
	#
	#Due Date = Invoice Date + Payment Term
	#
	#h2. Actual Results
	#
	#The due date is set to current date
	#
	#h2. Business Justification
	#
	#Due Dates are impacting Customer Payments
	@TEST_PD-29543 @REQ_PD-29423 @22Winter @21Winter @regression @Eswar
	Scenario: Test Manual Pass - The Due date field on the Sales Order is not updating correctly
		Given User will select "David Brown" contact
		When User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoItem6" item on rapid order entry
		And User selects "Invoice" as payment method, select payment term as "NET30" and proceeds further
		Then User verifies due to date on the sales order is populated with Invoice Date plus Payment Term

