@REQ_PD-22710
Feature: Test A/R account on Tax line on invoice does not match Tax item
	#Tests *Reproduced by* Ewa Imtiaz in 2019.1.0.5
	#
	#*Reference Case#*[00017886|https://fonteva.my.salesforce.com/5003A00000xY9wtQAC]
	#
	#*Description:*
	#
	#null
	#
	#*Steps to Reproduce:*
	#
	#1.Create a Tax rate and populate an A/R account different from the default (ex: 4400-Event Income)
	#
	#2. Select another item like Book and enable for taxes
	#
	#3. Create an order for any contact
	#
	#4. Add item previously configured
	#
	#5. Process this as an invoice
	#
	#6. Make the invoice Ready for Payment
	#
	#7. Open the Sales Order
	#
	#8. View the Tax sales order line
	#
	#*Actual Results:*
	#
	#The AR accounts are not the same . See attached screenshots
	#
	#*Expected Results:*
	#
	#{color:#3e3e3c}The AR accounts should be the same{color}

	#Tests Tests *Reproduced by* Ewa Imtiaz in 2019.1.0.5
	#
	#*Reference Case#*[00017886|https://fonteva.my.salesforce.com/5003A00000xY9wtQAC]
	#
	#*Description:*
	#
	#null
	#
	#*Steps to Reproduce:*
	#
	#1.Create a Tax rate and populate an A/R account different from the default (ex: 4400-Event Income)
	#
	#2. Select another item like Book and enable for taxes
	#
	#3. Create an order for any contact
	#
	#4. Add item previously configured
	#
	#5. Process this as an invoice
	#
	#6. Make the invoice Ready for Payment
	#
	#7. Open the Sales Order
	#
	#8. View the Tax sales order line
	#
	#*Actual Results:*
	#
	#The AR accounts are not the same . See attached screenshots
	#
	#*Expected Results:*
	#
	#{color:#3e3e3c}The AR accounts should be the same{color}
	@TEST_PD-28282 @REQ_PD-22710 @regression @21Winter @22Winter @ngunda
	Scenario: Test Test A/R account on Tax line on invoice does not match Tax item
		Given User will select "Max Foxworth" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "TaxInclusiveItem" item on rapid order entry
		And User selects "Invoice" as payment method and proceeds further
		Then User verifies the Tax Item line AR account is "4000 - Income"
