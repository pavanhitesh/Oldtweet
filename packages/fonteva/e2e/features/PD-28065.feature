@REQ_PD-28065
Feature: Refunding a Receipt-type Sales Order results in the Sales Order Line having a Balance Due when it shouldn't
	#*Case Reporter* Diego Alzugaray
	#
	#*Customer* Association for the Advancement of Medical Instrumentation
	#
	#*Reproduced by* Eli Nesson in 20Spring.0.5
	#
	#*Reference Case#* [00024992|https://fonteva.my.salesforce.com/5004V000011shunQAA]
	#
	#*Description:*
	#
	#Refunding a Receipt-type Sales Order results in the Sales Order Line having a Balance Due when it shouldn't
	#
	#Screen recording: [https://www.screencast.com/t/4sF4s9iTL|https://www.screencast.com/t/4sF4s9iTL]
	#
	#*Steps to Reproduce:*
	#
	## Open ROE from a contact
	## Add an item (not free)
	## Process Payment (tested true for CC and check)
	## From the resulting receipt, create a refund
	## Process the refund
	#
	#*Actual Results:*
	#
	#The Sales Order Line has Overall Total, Amount Paid, Amount Refunded, and BALANCE DUE all equal to the Subtotal.
	#
	#_(The Sales Order record has the correct Overall Total, Amount Paid and Amount Refunded all equal to cumulative Subtotals, and Balance Due correctly equals $0)_
	#
	#*Expected Results:*
	#
	#The Sales Order Line has Overall Total, Amount Paid, and Amount Refunded equal to the Subtotal. Balance Due equals $0.
	#
	#*Business Justification:*
	#
	#This affects any customer on 20Spring who uses refunds and relies on accurate SOL data.
	#
	#
	#
	#*PM NOTE:*
	#
	#SO is right SOL needs to be fixed. Fix goes into Services.

	#Tests *Case Reporter* Diego Alzugaray
	#
	#*Customer* Association for the Advancement of Medical Instrumentation
	#
	#*Reproduced by* Eli Nesson in 20Spring.0.5
	#
	#*Reference Case#* [00024992|https://fonteva.my.salesforce.com/5004V000011shunQAA]
	#
	#*Description:*
	#
	#Refunding a Receipt-type Sales Order results in the Sales Order Line having a Balance Due when it shouldn't
	#
	#Screen recording: [https://www.screencast.com/t/4sF4s9iTL|https://www.screencast.com/t/4sF4s9iTL]
	#
	#*Steps to Reproduce:*
	#
	## Open ROE from a contact
	## Add an item (not free)
	## Process Payment (tested true for CC and check)
	## From the resulting receipt, create a refund
	## Process the refund
	#
	#*Actual Results:*
	#
	#The Sales Order Line has Overall Total, Amount Paid, Amount Refunded, and BALANCE DUE all equal to the Subtotal.
	#
	#_(The Sales Order record has the correct Overall Total, Amount Paid and Amount Refunded all equal to cumulative Subtotals, and Balance Due correctly equals $0)_
	#
	#*Expected Results:*
	#
	#The Sales Order Line has Overall Total, Amount Paid, and Amount Refunded equal to the Subtotal. Balance Due equals $0.
	#
	#*Business Justification:*
	#
	#This affects any customer on 20Spring who uses refunds and relies on accurate SOL data.
	#
	#
	#
	#*PM NOTE:*
	#
	#SO is right SOL needs to be fixed. Fix goes into Services.
	@REQ_PD-28065 @TEST_PD-28726 @regression @21Winter @22winter @sophiya
	Scenario: Test Refunding a Receipt-type Sales Order results in the Sales Order Line having a Balance Due when it shouldn't
		Given User will select "Daniela Brown" contact
		When User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoItem1" item on rapid order entry
		And User navigate to "apply payment" page for "AutoItem1" item from rapid order entry
		And User should be able to apply payment for "AutoItem1" item using "Credit Card" payment on apply payment page
		And User should be able to process refund successfully
		Then User verifies the Overall Total, Amount Paid, Amount Refunded and Balance Due in sales order line

