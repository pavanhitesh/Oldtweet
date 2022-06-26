@REQ_PD-29512
Feature: The Due Date is doubled after converting and posting a Receipt Type Sales Order to an Invoice Type Sales Order
	#h2. Details
	#Make sure the default Payment Term has a Variable configured (e.g. 30).
	#
	#From a Receipt Type Sales Order (draft or unpaid), click the "Convert to Invoice" button, and then click the "Ready for Payment" button, the Due date is calculated by adding the Payment Term variable twice
	#e.g. Invoice Date + 60
	#but it should be Invoice Date +30
	#
	#
	#The issue is slightly different on two different Sales Order statues:
	#
	#For example:
	#the Date of the Sales Order is 12/21/2021.
	#
	#(1) from a Receipt type Sales Order where:
	#Status = Open, Sales Order Status = Draft, Due Date = Blank
	#
	#click "Convert to Invoice": Due Date is populated by adding 30 days (1/20/2022)
	#then click "Ready for Payment": another 30 days has been added to the Due Date (2/19/2022)
	#
	#Recording:
	#https://fonteva.zoom.us/rec/share/uKfXt6T0SJ7oP2xI08vqL7aCVE9KM91RGo1wf_tq_6tB8er5FtuyrRacJHxa277s.8L6a985VGXLrmHCU
	#
	#
	#(2) from a Receipt type Sales Order where:
	#Status = Closed, Sales Order Status = Unpaid, Due Date = 1/20/2022
	#
	#click "Convert to Invoice": the Status becomes Open, the Due Date doesn't change
	#click "Ready for Payment": Due Date = 2/19/2022
	#
	#Recording:
	#https://fonteva.zoom.us/rec/share/Qm0V6vgFUzPvLpe1pA2aajC5iynU-f4JSAQlR6DEA8O9xeIpazhvbpkaPgWR8EHj.4j5r0vxH7Vf6JUOv
	#
	#
	#This has been reproduced in 21Winter.0.15
	#
	#Screenshots also attached.
	#h2. Steps to Reproduce
	#1. create a receipt type sales order and don't pay for it yet.
	#2. click "Convert to Invoice"
	#3. click "Ready for Payment"
	#h2. Expected Results
	#the due date should be calculated by adding the Payment Term variable once.
	#h2. Actual Results
	#the due date is calculated by adding the Payment Term variable twice.
	#h2. Business Justification
	#This is having an impact as payments are not coming in on time as it should be 30 days not 60 days.

	#Tests h2. Details
	#Make sure the default Payment Term has a Variable configured (e.g. 30).
	#
	#From a Receipt Type Sales Order (draft or unpaid), click the "Convert to Invoice" button, and then click the "Ready for Payment" button, the Due date is calculated by adding the Payment Term variable twice
	#e.g. Invoice Date + 60
	#but it should be Invoice Date +30
	#
	#
	#The issue is slightly different on two different Sales Order statues:
	#
	#For example:
	#the Date of the Sales Order is 12/21/2021.
	#
	#(1) from a Receipt type Sales Order where:
	#Status = Open, Sales Order Status = Draft, Due Date = Blank
	#
	#click "Convert to Invoice": Due Date is populated by adding 30 days (1/20/2022)
	#then click "Ready for Payment": another 30 days has been added to the Due Date (2/19/2022)
	#
	#Recording:
	#https://fonteva.zoom.us/rec/share/uKfXt6T0SJ7oP2xI08vqL7aCVE9KM91RGo1wf_tq_6tB8er5FtuyrRacJHxa277s.8L6a985VGXLrmHCU
	#
	#
	#(2) from a Receipt type Sales Order where:
	#Status = Closed, Sales Order Status = Unpaid, Due Date = 1/20/2022
	#
	#click "Convert to Invoice": the Status becomes Open, the Due Date doesn't change
	#click "Ready for Payment": Due Date = 2/19/2022
	#
	#Recording:
	#https://fonteva.zoom.us/rec/share/Qm0V6vgFUzPvLpe1pA2aajC5iynU-f4JSAQlR6DEA8O9xeIpazhvbpkaPgWR8EHj.4j5r0vxH7Vf6JUOv
	#
	#
	#This has been reproduced in 21Winter.0.15
	#
	#Screenshots also attached.
	#h2. Steps to Reproduce
	#1. create a receipt type sales order and don't pay for it yet.
	#2. click "Convert to Invoice"
	#3. click "Ready for Payment"
	#h2. Expected Results
	#the due date should be calculated by adding the Payment Term variable once.
	#h2. Actual Results
	#the due date is calculated by adding the Payment Term variable twice.
	#h2. Business Justification
	#This is having an impact as payments are not coming in on time as it should be 30 days not 60 days.
	@TEST_PD-29588 @REQ_PD-29512 @21Winter @22Winter @regression @ngunda @OrderCreation
	Scenario: SO Status Open - The Due Date is doubled after converting and posting a Receipt Type Sales Order to an Invoice Type Sales Order
		Given User will select "Max Foxworth" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoItem6" item on rapid order entry
		When User exits to sales order page from "roe" page
		And User converts the created sales order to Invoice and validates due date
		Then User makes the sales order Ready for payment and validates the due date

	@TEST_PD-29589 @REQ_PD-29512 @21Winter @22Winter @regression @ngunda @OrderCreation
	Scenario: SO Status Closed - The Due Date is doubled after converting and posting a Receipt Type Sales Order to an Invoice Type Sales Order
		Given User will select "Max Foxworth" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoItem6" item on rapid order entry
		And User selects "Process Payment" as payment method and proceeds further
		When User exits to sales order page from "payment" page
		And User converts the created sales order to Invoice and validates due date
		Then User makes the sales order Ready for payment and validates the due date
