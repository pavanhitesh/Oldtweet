@REQ_PD-27857
Feature: Gateway Transaction ID's on Refund E-payments are missing.
	#*Case Reporter* Michael Jetter
	#
	#*Customer* AO Foundation
	#
	#*Reproduced by* Prathyusha Pamudoorthi in 2019.1.0.30
	#
	#*Reference Case#* [00026043|https://fonteva.my.salesforce.com/5004V000012QxfEQAS]
	#
	#*Description:*
	#
	#For purchase receipts, Gateway Transaction Id on Epayment is getting populated(See Screenshot) But for the Refund receipts, Gateway Transaction Id on Epayment is not getting populated. When I pulled the transcript from Spreedly, I see the Gateway Transaction Id is coming from the gateway and I believe it is not populating on the epayment record. I see the same behavior in 19 R1 and 20 Spring demo org.
	#
	#I can confirm this used to work in early versions of 19 R1 since we have records that show us the Id on epayment. However the ID is not populating on epayment in 2019 R1 latest versions or 20 Spring.
	#
	#*Steps to Reproduce:*
	#
	## Purchase an item on the backend
	## Navigate to the receipt record 
	## Select the epayment record from the receipt
	## Verify gateway transaction Id is populated on the epayment record
	## Click on the Create Refund button on the receipt record 
	## Click on Process Refund button on the receipt created for the refund
	## Navigate to the epayment record created for the refund record 
	## Verify gateway transaction Id is populated on the epayment record
	#
	#*Note: However If we pull the transcript from Spreedly, I see the Gateway Transaction Id is coming from the gateway.*
	#
	#
	#
	#*Actual Results:*
	#
	#Gateway transaction Id not being populated on refund E-payment record.
	#
	#*Expected Results:*
	#
	#Gateway transaction Id should populate on refund E-payment record.
	#
	#
	#
	#*PM NOTE:*
	#
	#the ticket scope is only the process refund button which is exists in 21winter. we are not going to validate the. new refund process which has been developed for 21summer branch

	#Tests *Case Reporter* Michael Jetter
	#
	#*Customer* AO Foundation
	#
	#*Reproduced by* Prathyusha Pamudoorthi in 2019.1.0.30
	#
	#*Reference Case#* [00026043|https://fonteva.my.salesforce.com/5004V000012QxfEQAS]
	#
	#*Description:*
	#
	#For purchase receipts, Gateway Transaction Id on Epayment is getting populated(See Screenshot) But for the Refund receipts, Gateway Transaction Id on Epayment is not getting populated. When I pulled the transcript from Spreedly, I see the Gateway Transaction Id is coming from the gateway and I believe it is not populating on the epayment record. I see the same behavior in 19 R1 and 20 Spring demo org.
	#
	#I can confirm this used to work in early versions of 19 R1 since we have records that show us the Id on epayment. However the ID is not populating on epayment in 2019 R1 latest versions or 20 Spring.
	#
	#*Steps to Reproduce:*
	#
	## Purchase an item on the backend
	## Navigate to the receipt record 
	## Select the epayment record from the receipt
	## Verify gateway transaction Id is populated on the epayment record
	## Click on the Create Refund button on the receipt record 
	## Click on Process Refund button on the receipt created for the refund
	## Navigate to the epayment record created for the refund record 
	## Verify gateway transaction Id is populated on the epayment record
	#
	#*Note: However If we pull the transcript from Spreedly, I see the Gateway Transaction Id is coming from the gateway.*
	#
	#
	#
	#*Actual Results:*
	#
	#Gateway transaction Id not being populated on refund E-payment record.
	#
	#*Expected Results:*
	#
	#Gateway transaction Id should populate on refund E-payment record.
	#
	#
	#
	#*PM NOTE:*
	#
	#the ticket scope is only the process refund button which is exists in 21winter. we are not going to validate the. new refund process which has been developed for 21summer branch
	@TEST_PD-28250 @REQ_PD-27857 @22Winter @21winter @regression @pavan
	Scenario: Test Gateway Transaction ID's on Refund E-payments are missing.
		Given User will select "Coco Dulce" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoItem1" item on rapid order entry
		And User navigate to "apply payment" page for "AutoItem1" item from rapid order entry
		When User should be able to apply payment for "AutoItem1" item using "Credit Card" payment on apply payment page
		Then User verifies the Gateway Transaction ID is populated for the refund e-payments receipt

