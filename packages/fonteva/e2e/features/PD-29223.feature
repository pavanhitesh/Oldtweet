@REQ_PD-29223
Feature: Receipt record has the account associated with the contact and not the sales order
	#h2. Details
	#Expected Result
	#The Account on the Receipt should match the Account on the Sales Order.
	#
	#It should not matter if the Contact and the Account are related.
	#
	#Actual Results
	#The Account on the Receipt is the Account from the Receipt's Contact.
	#h2. Steps to Reproduce
	#See video.
	#h2. Expected Results
	#The Account on the Receipt should match the Account on the Sales Order. 
	#
	#It should not matter if the Contact and the Account are related.
	#h2. Actual Results
	#The Account on the Receipt is the Account from the Receipt's Contact.
	#h2. Business Justification
	#Inaccurate financial records.

	#Tests h2. Details
	#Expected Result
	#The Account on the Receipt should match the Account on the Sales Order.
	#
	#It should not matter if the Contact and the Account are related.
	#
	#Actual Results
	#The Account on the Receipt is the Account from the Receipt's Contact.
	#h2. Steps to Reproduce
	#See video.
	#h2. Expected Results
	#The Account on the Receipt should match the Account on the Sales Order. 
	#
	#It should not matter if the Contact and the Account are related.
	#h2. Actual Results
	#The Account on the Receipt is the Account from the Receipt's Contact.
	#h2. Business Justification
	#Inaccurate financial records.
	@TEST_PD-29528 @REQ_PD-29223 @21Winter @22Winter @regression @pavan
	Scenario: Test Receipt record has the account associated with the contact and not the sales order
		Given User will select "Global Media" account
		And User opens the Rapid Order Entry page from account
		And User should be able to add "autoSubscriptionItem" item on rapid order entry
		When User exit to sales order and updates the sales order contact with contact having other account "Max Foxworth"
		And User makes the sales order ready for payment and complete the payment
		Then User verifies the account on receipt should match the account on salesOrder
