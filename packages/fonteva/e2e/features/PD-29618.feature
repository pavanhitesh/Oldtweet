@REQ_PD-29618
Feature: Manual Pass - CLONE - Encrypted field not consistently populated on receipt record
	#h2. Details
	#The encrypted ID field on the receipt record does not populate for every record.
	#h2. Steps to Reproduce
	#1. Open a contact and Click on Rapid Order Entry.
	#2. Select any item in "Item Quick Add" and Click Add.
	#3. Process payment of that Item using any payment method.
	#4. The receipt generated does not have "Encrypted ID" populated, but Sales Order has encrypted ID.
	#
	#This is happening randomly in most of the receipts created using ROE or Portal.
	#No system logs were generated.
	#Production org ID: 00D3z000002KFcS
	#Here is the report of receipt: https://myplsa.lightning.force.com/lightning/r/Report/00O3z0000094yPNEAY/view
	#h2. Expected Results
	#The encrypted field should populate on the receipt record
	#h2. Actual Results
	#The encrypted field is not consistently populating on the receipt record
	#h2. Business Justification
	#The encrypted ID is used in an email template to go out to the members, so it is important.

	#Tests h2. Details
	#The encrypted ID field on the receipt record does not populate for every record.
	#h2. Steps to Reproduce
	#1. Open a contact and Click on Rapid Order Entry.
	#2. Select any item in "Item Quick Add" and Click Add.
	#3. Process payment of that Item using any payment method.
	#4. The receipt generated does not have "Encrypted ID" populated, but Sales Order has encrypted ID.
	#
	#This is happening randomly in most of the receipts created using ROE or Portal.
	#No system logs were generated.
	#Production org ID: 00D3z000002KFcS
	#Here is the report of receipt: https://myplsa.lightning.force.com/lightning/r/Report/00O3z0000094yPNEAY/view
	#h2. Expected Results
	#The encrypted field should populate on the receipt record
	#h2. Actual Results
	#The encrypted field is not consistently populating on the receipt record
	#h2. Business Justification
	#The encrypted ID is used in an email template to go out to the members, so it is important.
	@TEST_PD-29773 @REQ_PD-29618 @regression @21Winter @22Winter @snayini
	Scenario: Test Manual Pass - CLONE - Encrypted field not consistently populated on receipt record
		Given User will select "Bob Kelley" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoItem1" item on rapid order entry
		And User navigate to "apply payment" page for "AutoItem1" item from rapid order entry
		And User should be able to apply payment for "AutoItem1" item using "Credit Card" payment on apply payment page
		Then User verifies encrypted field is populated on Receipt

