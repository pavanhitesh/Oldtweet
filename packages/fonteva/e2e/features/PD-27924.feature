@REQ_PD-27924
Feature: Additional Items result in 0.00 balance during renewal.
	#*Case Reporter* Byron Smith
	#
	#*Customer* National Association for Music Education
	#
	#*Reproduced by* Aaron Gremillion in 20Spring.1.13,21Winter.0.6,20Spring.0.22
	#
	#*Reference Case#* [00031467|https://fonteva.my.salesforce.com/5004V000017Kf86QAC]
	#
	#*Description:*
	#
	#Customer with an existing subscription with child subscription lines (advanced items > Additional Items)
	#
	#& Additional items on renewal
	#
	#Do not add to the balance when renewing from the front or back end.
	#
	#
	#
	#*PM NOTE:*
	#
	#If you purchase this item the first time (not a renewal order) both prices on the main SOL and Child SOL are getting poppulated.
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#* Create a Subscription Item with the additional item being a subscription item. (paid)
	#** Remember Additional package items are always paid
	#** Sub Item A = 100USD
	#** Additional Child Merchandise Item B 50USD (from Advanced Item Settings)
	#* Buy the subscription created in the prereqs.
	#** SO Total is 150USD
	#* When a subscription is created
	#** you can find it under the main SOL
	#* Click renew button (Sub has Renew button)
	#** this will create Renewal SO and you will land on the SO
	#** in the back end, renew (LT/Classic)
	#* Review the resulting renewal sales order.
	#** The sales order line for the packaged item is a balance of 0.
	#
	#
	#
	#*Actual Results:*
	#
	#Balance/Overall total of zero on renewal additional item on SOL.
	#
	#
	#
	#*Expected Results:*
	#
	#Balance and the overall total should reflect what the SOL's subtotal should be.
	#
	#
	#
	#*Business Justification:*
	#
	#Customers will lose additional revenue without additional items not charging during renewal
	#
	#*CS Note:*
	#w21 Org Credentials (also repro'd in 20spring.0 20sp.1 gremw21@fondash.io 1Emm@3089

	#Tests *Case Reporter* Byron Smith
	#
	#*Customer* National Association for Music Education
	#
	#*Reproduced by* Aaron Gremillion in 20Spring.1.13,21Winter.0.6,20Spring.0.22
	#
	#*Reference Case#* [00031467|https://fonteva.my.salesforce.com/5004V000017Kf86QAC]
	#
	#*Description:*
	#
	#Customer with an existing subscription with child subscription lines (advanced items > Additional Items)
	#
	#& Additional items on renewal
	#
	#Do not add to the balance when renewing from the front or back end.
	#
	#
	#
	#*PM NOTE:*
	#
	#If you purchase this item the first time (not a renewal order) both prices on the main SOL and Child SOL are getting poppulated.
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#* Create a Subscription Item with the additional item being a subscription or merchandise item. (paid)
	#** Remember Additional package items are always paid
	#** Sub Item A = 100USD
	#** Additional Child Merchandise Item B 50USD (from Advanced Item Settings)
	#* Buy the subscription created in the prereqs.
	#** SO Total is 150USD
	#* When a subscription is created
	#** you can find it under the main SOL
	#* Click renew button (Sub has Renew button)
	#** this will create Renewal SO and you will land on the SO
	#** in the back end, renew (LT/Classic)
	#* Review the resulting renewal sales order.
	#** The sales order line for the packaged item is a balance of 0.
	#
	#
	#
	#*Actual Results:*
	#
	#Balance/Overall total of zero on renewal additional item on SOL.
	#
	#
	#
	#*Expected Results:*
	#
	#Balance and the overall total should reflect what the SOL's subtotal should be.
	#
	#
	#
	#*Business Justification:*
	#
	#Customers will lose additional revenue without additional items not charging during renewal
	#
	#*CS Note:*
	#w21 Org Credentials (also repro'd in 20spring.0 20sp.1 gremw21@fondash.io 1Emm@3089
	@TEST_PD-28426 @REQ_PD-27924 @22winter @21winter @regression @pavan
	Scenario: Test Additional Items result in 0.00 balance during renewal.
		Given User will select "Coco Dulce" contact
		And User opens the Rapid Order Entry page from contact
		When User should be able to add "<itemName>" item on rapid order entry
		And User is able to expand the Item details of "<itemName>" and select the Additional Package item
		And User navigate to "apply payment" page for "<itemName>" item from rapid order entry
		And User should be able to apply payment for "<itemName>" item using "Credit Card" payment on apply payment page
		Then User renews the subscription and verifies the balanceDue,overall total should reflected in the SOL

		Examples:
			| itemName                                   |
			| autoSubcriptionWithPackagedSubcriptionItem |

