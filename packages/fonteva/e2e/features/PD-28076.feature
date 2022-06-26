@REQ_PD-28076
Feature: Membership has wrong entity when Staff user applies the source code on the Sales Order level
	#*Case Reporter* Hiral Shah
	#
	#*Customer* University of Michigan - Alumni Association
	#
	#*Reproduced by* Ewa Imtiaz in 2019.1.0.27,2019.1.0.28
	#
	#*Reference Case#* [00024050|https://fonteva.my.salesforce.com/5004V000011Pkg0QAC]
	#
	#*Description:*
	#
	#Membership has the wrong entity when the Staff user applies the source code on the Sales Order level. 
	#
	#AAUM has a use case to create new SO (entity = Contact) from the Contact record first, with a Source Code filled. 
	#
	#Then enter ROE from the SO to purchase a membership item. 
	#
	#Once the purchase is completed, we see the wrong entity (Account instead of Contact) on SOL and the new membership created
	#
	#*Steps to Reproduce:*
	#
	#Go to Contact >> Sales Order >> New
	#
	#* Posting Entity=Receipt
	#* Schedule Type=Simple Receipt (select)
	#* add Source Code (may nor may not be required)
	#
	#>> Save >> on SO record, 
	#
	#Click ROE >> add a membership, process the payment.
	#
	#*Actual Results:*
	#
	#The Entity is displayed as an Account in SOL and Subscription. Even though the SO has entity Contact
	#
	#*Expected Results:*
	#
	#The entity is displayed as Contact
	#
	#*Note*: Ewa has verified with Ulas and confirmed this is a minor bug
	#
	#
	#
	#*PM NOTE:*
	#
	#SOL should inherit from SO and Subscription should inherit from the SOL

	#Tests *Case Reporter* Hiral Shah
	#
	#*Customer* University of Michigan - Alumni Association
	#
	#*Reproduced by* Ewa Imtiaz in 2019.1.0.27,2019.1.0.28
	#
	#*Reference Case#* [00024050|https://fonteva.my.salesforce.com/5004V000011Pkg0QAC]
	#
	#*Description:*
	#
	#Membership has the wrong entity when the Staff user applies the source code on the Sales Order level. 
	#
	#AAUM has a use case to create new SO (entity = Contact) from the Contact record first, with a Source Code filled. 
	#
	#Then enter ROE from the SO to purchase a membership item. 
	#
	#Once the purchase is completed, we see the wrong entity (Account instead of Contact) on SOL and the new membership created
	#
	#*Steps to Reproduce:*
	#
	#Go to Contact >> Sales Order >> New
	#
	#* Posting Entity=Receipt
	#* Schedule Type=Simple Receipt (select)
	#* add Source Code (may nor may not be required)
	#
	#>> Save >> on SO record, 
	#
	#Click ROE >> add a membership, process the payment.
	#
	#*Actual Results:*
	#
	#The Entity is displayed as an Account in SOL and Subscription. Even though the SO has entity Contact
	#
	#*Expected Results:*
	#
	#The entity is displayed as Contact
	#
	#*Note*: Ewa has verified with Ulas and confirmed this is a minor bug
	#
	#
	#
	#*PM NOTE:*
	#
	#SOL should inherit from SO and Subscription should inherit from the SOL
	@REQ_PD-28076 @TEST_PD-28762 @regression @21Winter @22Winter @sophiya
	Scenario: Test Membership has wrong entity when Staff user applies the source code on the Sales Order level
		Given User creates New Sales Order with contact as "David Brown" & opens the sales order
		When User opens the Rapid Order Entry page from sales order
		And User should be able to add "AutoCalenderPlan_NoTax" item on rapid order entry
		And User navigate to "apply payment" page for "AutoCalenderPlan_NoTax" item from rapid order entry
		And User should be able to apply payment for "AutoCalenderPlan_NoTax" item using "Credit Card" payment on apply payment page
		Then User verifies the enity type value in Sales order line and Subscription is contact
