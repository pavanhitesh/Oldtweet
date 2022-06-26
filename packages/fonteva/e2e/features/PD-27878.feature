@REQ_PD-27878
Feature: BALANCE DUE 3 - Creating a Credit Memo because of an over payment to an Invoice does not update Balance Due on the Sales Order correctly, though Sales Order Adjustment line is created
	#h2. Steps to Reproduce
	#
	#1) Go to a Contact Record
	#2) Press Rapid Order Entry
	#3) Add any item
	#4) Change picklist to Invoice and press go
	#5) Press Ready for Payment
	#6) Return to the Sales Order and click “Apply Payment”
	#7) Pay an amount so there is an overpayment
	#8) Return to the Sales Order and click the “Create Credit Memo” Button
	#9) Review the Sales Order ‘Balance Due’ Field which should be zero
	#
	#
	#
	#Validated in this GCO [https://fonteva.lightning.force.com/lightning/r/EnvironmentHubMember/0J14V0000004GacSAE/view|https://fonteva.lightning.force.com/lightning/r/EnvironmentHubMember/0J14V0000004GacSAE/view]
	#21Winter.0.07 – Same as 20Spring1.15
	#
	#Refer to the attached screenshot in the case.
	#
	#h2. Expected Results
	#
	#Balance Due on SO should be 0
	#
	#And adjustment line should be posted (check this first this may be the root cause)
	#
	#h2. Actual Results
	#
	#Balance due will not change so will still show as a negative
	#
	#h2. Business Justification
	#
	#Creating a Credit Memo because of an overpayment to an Invoice does not update Balance Due on the Sales Order correctly, though Sales Order Adjustment line is created.

	#Tests h2. Steps to Reproduce
	#
	#1) Go to a Contact Record
	#2) Press Rapid Order Entry
	#3) Add any item
	#4) Change picklist to Invoice and press go
	#5) Press Ready for Payment
	#6) Return to the Sales Order and click “Apply Payment”
	#7) Pay an amount so there is an overpayment
	#8) Return to the Sales Order and click the “Create Credit Memo” Button
	#9) Review the Sales Order ‘Balance Due’ Field which should be zero
	#
	#
	#
	#Validated in this GCO [https://fonteva.lightning.force.com/lightning/r/EnvironmentHubMember/0J14V0000004GacSAE/view|https://fonteva.lightning.force.com/lightning/r/EnvironmentHubMember/0J14V0000004GacSAE/view]
	#21Winter.0.07 – Same as 20Spring1.15
	#
	#Refer to the attached screenshot in the case.
	#
	#h2. Expected Results
	#
	#Balance Due on SO should be 0
	#
	#And adjustment line should be posted (check this first this may be the root cause)
	#
	#h2. Actual Results
	#
	#Balance due will not change so will still show as a negative
	#
	#h2. Business Justification
	#
	#Creating a Credit Memo because of an overpayment to an Invoice does not update Balance Due on the Sales Order correctly, though Sales Order Adjustment line is created.
	@TEST_PD-28519 @REQ_PD-27878 @22Winter @21Winter @regression @ngunda
	Scenario: Test BALANCE DUE 3 - Creating a Credit Memo because of an over payment to an Invoice does not update Balance Due on the Sales Order correctly, though Sales Order Adjustment line is created
		Given User will select "Max Foxworth" contact
		And User opens the Rapid Order Entry page from contact
		When User should be able to add "AutoItem6" item on rapid order entry
		And User selects "Invoice" as payment method and proceeds further
		When User "Max Foxworth" makes "Extra" payment for the created order
		And User creates Credit Memo for the order
		Then User verifies there is no Balance Due on SalesOrder
