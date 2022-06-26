@REQ_PD-27914
Feature: The header on Billing Contact & Shipping Contact is not appropriate
	#*Case Reporter* Ethan Larson
	#
	#*Customer* Institute for Operations Research and the Management Sciences
	#
	#*Reproduced by* Sandeep Bangwal in 2019.1.0.42,2019.1.0.44
	#
	#*Reference Case#* [00031141|https://fonteva.my.salesforce.com/5004V000017II49QAG]
	#
	#*Description:*
	#
	#*_The Billing Contact & Shipping Contact on the Sales order is always set to contact even though the Entity on the Sales order is Account_* which isn't correct because as per the Helper text on both the fields the value of this field will be updated to Account or Contact based on the "Entity".
	#
	#*Steps to Reproduce:*
	#
	#Created Sales order a new Sales order with Account Entity.
	#
	#Process the order.
	#
	#The Billing Contact & Shipping Contact on the Sales order is set to the contact instead of the account, which isn't correct as per the helper text on both the fields.
	#
	#
	#
	#*Actual Results:*
	#
	#The entity on the Sales Order is set to Account but the Billing Contact & Shipping Contact on the Sales order is set to the contact.
	#
	#*Expected Results:*
	#
	#If the entity on the Sales order is set to account then the Billing Contact & Shipping Contact on the Sales order should be Account.
	#
	#If the entity is account bring account addresses.
	#
	#*CS Note:*
	#GCO URL: [https://gco3xa6w.lightning.force.com/lightning/page/home|https://gco3xa6w.lightning.force.com/lightning/page/home] Username: enesson-19r1b@fonteva.com Password: Fonteva703

	#Tests *Case Reporter* Ethan Larson
	#
	#*Customer* Institute for Operations Research and the Management Sciences
	#
	#*Reproduced by* Sandeep Bangwal in 2019.1.0.42,2019.1.0.44
	#
	#*Reference Case#* [00031141|https://fonteva.my.salesforce.com/5004V000017II49QAG]
	#
	#*Description:*
	#
	#*_The Billing Contact & Shipping Contact on the Sales order is always set to contact even though the Entity on the Sales order is Account_* which isn't correct because as per the Helper text on both the fields the value of this field will be updated to Account or Contact based on the "Entity".
	#
	#*Steps to Reproduce:*
	#
	#Created Sales order a new Sales order with Account Entity.
	#
	#Process the order.
	#
	#The Billing Contact & Shipping Contact on the Sales order is set to the contact instead of the account, which isn't correct as per the helper text on both the fields.
	#
	#
	#
	#*Actual Results:*
	#
	#The entity on the Sales Order is set to Account but the Billing Contact & Shipping Contact on the Sales order is set to the contact.
	#
	#*Expected Results:*
	#
	#If the entity on the Sales order is set to account then the Billing Contact & Shipping Contact on the Sales order should be Account.
	#
	#If the entity is account bring account addresses.
	#
	#*CS Note:*
	#GCO URL: [https://gco3xa6w.lightning.force.com/lightning/page/home|https://gco3xa6w.lightning.force.com/lightning/page/home] Username: enesson-19r1b@fonteva.com Password: Fonteva703
	@TEST_PD-28340 @REQ_PD-27914 @regression @21Winter @22Winter @ngunda
	Scenario: Test The header on Billing Contact & Shipping Contact is not appropriate
		Given User creates salesOrders with information provided below:
			| Contact      | Account            | BusinessGroup | Entity  | PostingEntity | ScheduleType   | ItemName  | Qty |
			| Max Foxworth | Foxworth Household | Foundation    | Account | Invoice       | Simple Invoice | AutoItem6 | 1   |
		Then User verifies the Billing and Shipping address populated on Sales Order is from Account

