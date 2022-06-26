@REQ_PD-27902
Feature: 21Winter Passed - Events collecting payment twice via Saved Payment Method (clicked the "process payment " button once only)
	#*Case Reporter* Graham Bamford
	#
	#*Customer* The Worshipful Company of Farmers
	#
	#*Reproduced by* Prudhvi Raj in 21Winter.0.3
	#
	#*Reference Case#* [00030840|https://fonteva.my.salesforce.com/5004V000016NyskQAC]
	#
	#*Description:*
	#Events have started collecting card payments twice within less than a second of each other.
	#Probably since loading latest patch (see screen shot of transaction with same transaction codes with -1 added
	#Org ID 00D24000000ZocR Access granted
	#
	#h4. *Steps to Repro for QA/Dev*
	#
	#* Create an LT event, multi ticket event, event configuration does not matter
	#* Make sure the contact has a saved payment method already
	#* Log in as the contact and use the existing saved payment method to pay
	#** Note that Process Payment will be greyed out so you cannot double click
	#* Dupe payment occurs. We see 2 ePayments and 2 Receipts for the same SO
	#
	#*Steps to Reproduce:*
	#
	#Production Org ID – 00D24000000ZocR
	#
	#Login into "Graham Bamford" account – [https://wcof.lightning.force.com/lightning/r/Contact/00324000005KJMoAAO/view?0.source=alohaHeader|https://wcof.lightning.force.com/lightning/r/Contact/00324000005KJMoAAO/view?0.source=alohaHeader]
	#
	#Login into User experience.
	#
	#Add any item from store or register to any lightning Event to cart and on the checkout page
	#
	#select the save payment method.
	#
	#and make the payment.
	#
	#Even if the "process payment" button is clicked once only, the sales order is charging twice.
	#
	#Sample sales order created by customer on call – [https://wcof.lightning.force.com/lightning/r/OrderApi\\_\\_Sales\\_Order\\_\\_c/a1A0800000ENPB6EAP/view?0.source=alohaHeader|https://wcof.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1A0800000ENPB6EAP/view?0.source=alohaHeader]
	#
	#( Customer doesn't want to share the recording as it contains card details)
	#
	#another sample sales order created by customer on call.
	#
	#[https://wcof.lightning.force.com/lightning/r/OrderApi\\_\\_Sales\\_Order\\_\\_c/a1A0800000ENPB1EAP/view?0.source=alohaHeader|https://wcof.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1A0800000ENPB1EAP/view?0.source=alohaHeader]
	#
	#Demo Org details:
	#
	#I have reproduced the issue in the demo org link – [https://fonteva.lightning.force.com/lightning/r/EnvironmentHubMember/0J14V0000004IMNSA2/view|https://fonteva.lightning.force.com/lightning/r/EnvironmentHubMember/0J14V0000004IMNSA2/view]
	#
	#Sample sales order created by selecting credit card (unsaved payment method) –
	#
	#[https://gcon4qrsd.lightning.force.com/lightning/r/OrderApi\\_\\_Sales\\_Order\\_\\_c/a1J5Y00000AKGf2UAH/view|https://gcon4qrsd.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000AKGf2UAH/view]
	#
	#Only one receipt has been created – [0000001285|https://gcon4qrsd.lightning.force.com/lightning/r/a1E5Y00000Biq9nUAB/view]
	#
	#Sample sales order created by selecting saved payment method – [https://gcon4qrsd.lightning.force.com/lightning/r/OrderApi\\_\\_Sales\\_Order\\_\\_c/a1J5Y00000AKGb5UAH/view|https://gcon4qrsd.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000AKGb5UAH/view]
	#
	#2 receipts – [0000001283|https://gcon4qrsd.lightning.force.com/lightning/r/a1E5Y00000Biq3uUAB/view] , [0000001284|https://gcon4qrsd.lightning.force.com/lightning/r/a1E5Y00000Biq3vUAB/view] are created.
	#
	#*Actual Results:*
	#
	#When payment is made using saved payment method, it is charging twice and 2 receipts are being generated. ( clicked the "process payment " button once only)
	#
	#*Expected Results:*
	#
	#When the payment is made using saved payment method, it should charge the user only once.

	#Tests *Case Reporter* Graham Bamford
	#
	#*Customer* The Worshipful Company of Farmers
	#
	#*Reproduced by* Prudhvi Raj in 21Winter.0.3
	#
	#*Reference Case#* [00030840|https://fonteva.my.salesforce.com/5004V000016NyskQAC]
	#
	#*Description:*
	#Events have started collecting card payments twice within less than a second of each other.
	#Probably since loading latest patch (see screen shot of transaction with same transaction codes with -1 added
	#Org ID 00D24000000ZocR Access granted
	#
	#h4. *Steps to Repro for QA/Dev*
	#
	#* Create an LT event, multi ticket event, event configuration does not matter
	#* Make sure the contact has a saved payment method already
	#* Log in as the contact and use the existing saved payment method to pay
	#** Note that Process Payment will be greyed out so you cannot double click
	#* Dupe payment occurs. We see 2 ePayments and 2 Receipts for the same SO
	#
	#*Steps to Reproduce:*
	#
	#Production Org ID – 00D24000000ZocR
	#
	#Login into "Graham Bamford" account – [https://wcof.lightning.force.com/lightning/r/Contact/00324000005KJMoAAO/view?0.source=alohaHeader|https://wcof.lightning.force.com/lightning/r/Contact/00324000005KJMoAAO/view?0.source=alohaHeader]
	#
	#Login into User experience.
	#
	#Add any item from store or register to any lightning Event to cart and on the checkout page
	#
	#select the save payment method.
	#
	#and make the payment.
	#
	#Even if the "process payment" button is clicked once only, the sales order is charging twice.
	#
	#Sample sales order created by customer on call – [https://wcof.lightning.force.com/lightning/r/OrderApi\\_\\_Sales\\_Order\\_\\_c/a1A0800000ENPB6EAP/view?0.source=alohaHeader|https://wcof.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1A0800000ENPB6EAP/view?0.source=alohaHeader]
	#
	#( Customer doesn't want to share the recording as it contains card details)
	#
	#another sample sales order created by customer on call.
	#
	#[https://wcof.lightning.force.com/lightning/r/OrderApi\\_\\_Sales\\_Order\\_\\_c/a1A0800000ENPB1EAP/view?0.source=alohaHeader|https://wcof.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1A0800000ENPB1EAP/view?0.source=alohaHeader]
	#
	#Demo Org details:
	#
	#I have reproduced the issue in the demo org link – [https://fonteva.lightning.force.com/lightning/r/EnvironmentHubMember/0J14V0000004IMNSA2/view|https://fonteva.lightning.force.com/lightning/r/EnvironmentHubMember/0J14V0000004IMNSA2/view]
	#
	#Sample sales order created by selecting credit card (unsaved payment method) –
	#
	#[https://gcon4qrsd.lightning.force.com/lightning/r/OrderApi\\_\\_Sales\\_Order\\_\\_c/a1J5Y00000AKGf2UAH/view|https://gcon4qrsd.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000AKGf2UAH/view]
	#
	#Only one receipt has been created – [0000001285|https://gcon4qrsd.lightning.force.com/lightning/r/a1E5Y00000Biq9nUAB/view]
	#
	#Sample sales order created by selecting saved payment method – [https://gcon4qrsd.lightning.force.com/lightning/r/OrderApi\\_\\_Sales\\_Order\\_\\_c/a1J5Y00000AKGb5UAH/view|https://gcon4qrsd.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000AKGb5UAH/view]
	#
	#2 receipts – [0000001283|https://gcon4qrsd.lightning.force.com/lightning/r/a1E5Y00000Biq3uUAB/view] , [0000001284|https://gcon4qrsd.lightning.force.com/lightning/r/a1E5Y00000Biq3vUAB/view] are created.
	#
	#*Actual Results:*
	#
	#When payment is made using saved payment method, it is charging twice and 2 receipts are being generated. ( clicked the "process payment " button once only)
	#
	#*Expected Results:*
	#
	#When the payment is made using saved payment method, it should charge the user only once.
	@REQ_PD-27902 @TEST_PD-29241 @regression @21Winter @22Winter @sophiya
	Scenario: Test 21Winter Passed - Events collecting payment twice via Saved Payment Method (clicked the "process payment " button once only)
		Given User navigate to community Portal page with "danielabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		When User selects event "AutoEvent1" and event type "MultiTicket" on LT portal
		And User register for "AutoTicket" ticket with 1 quantity and navigate to "session" page as "authenticated user"
		Then User "Daniela Brown" selects no session and completes the event payment process using saved payment
		And User verifies that the system created only one receipt
