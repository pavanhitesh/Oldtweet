@REQ_PD-27847
Feature: Price Rule does not update the Sales Order Line's Sale Price field
	#*Case Reporter* Beth Jennings
	#
	#*Customer* Canadian Association of Emergency Physicians
	#
	#*Reproduced by* John Herrera in 20Spring.1.15,2019.1.0.31
	#
	#*Reference Case#* [00025897|https://fonteva.my.salesforce.com/5004V000012Q3NXQA0]
	#
	#*Description:*
	#
	#Recording:
	#
	#[https://www.screencast.com/t/n3eartIvCxq|https://www.screencast.com/t/n3eartIvCxq]
	#
	#* Business User manually create Sales Order Line when the Subscription Start Date/Activation Date needs to be in the future and not the day the Sales Order is created
	#* The Sales Order Line includes a Subscription Item with a price override and a date in the future for the Subscription Start Date and Activation Date
	#
	#*Steps to Reproduce:*
	#
	#1) Create a Sales Order
	#
	#2) Add any Item (eg Jacket)
	#
	#3) Exit the Sales Order
	#
	#4) Manually create a Sales Order Line in Salesforce
	#
	#5) Update the following fields:
	#
	#Item: CAEP Partner Community Member
	#
	#Price Rule: Package 1 CAEP Partnership Community Member
	#
	#-Price Override: \[Check]- {color:#00b8d9}_PM NOTE: THIS STEP IS WRONG - IF PRICE OVERRIDE IS CHECK, THE SYSTEM DOES NOT UPDATE THE PRICE AT ALL_ {color}
	#
	#Subscription Plan: FON-1 Year Anniversary
	#
	#Subscription Start Date: Any date in the future
	#
	#Activation Date: Any date in the future
	#
	#6) Select Save
	#
	#_Error is found here: The record does not recognize the price rule and no value is applied to the Sale Price field._
	#
	#GCO SO example: [https://gco44ea4v.my.salesforce.com/a1J4W00000EG7Tc|https://gco44ea4v.my.salesforce.com/a1J4W00000EG7Tc]
	#
	#*Actual Results:*
	#
	#* When the Sales Order Line. is manually created, the Sale Price field on the Sales Order Line remains at $0.00
	#* If the Sales Order is paid, the manually created Sales Order Line does not generate a Receipt Line
	#* When the Sales Order Line is created in ROE and then edited, the Sale Price field remains the default price (Note - Replication steps remain exactly the same as above)
	#
	#*Expected Results:*
	#
	#* The Sale Price field on the Sales Order Line recognizes the price rule and updates its price.
	#
	#*Business Justification:*
	#
	#Clayton: CAEP has flagged this as a priority
	#
	#*CS Note:*
	#GCO Org ID (20Spring.1): 00D4W0000092BSp GCO Org ID (19R1): 00D5Y000001M3PW

	#Tests *Case Reporter* Beth Jennings
	#
	#*Customer* Canadian Association of Emergency Physicians
	#
	#*Reproduced by* John Herrera in 20Spring.1.15,2019.1.0.31
	#
	#*Reference Case#* [00025897|https://fonteva.my.salesforce.com/5004V000012Q3NXQA0]
	#
	#*Description:*
	#
	#Recording:
	#
	#[https://www.screencast.com/t/n3eartIvCxq|https://www.screencast.com/t/n3eartIvCxq]
	#
	#* Business User manually create Sales Order Line when the Subscription Start Date/Activation Date needs to be in the future and not the day the Sales Order is created
	#* The Sales Order Line includes a Subscription Item with a price override and a date in the future for the Subscription Start Date and Activation Date
	#
	#*Steps to Reproduce:*
	#
	#1) Create a Sales Order
	#
	#2) Add any Item (eg Jacket)
	#
	#3) Exit the Sales Order
	#
	#4) Manually create a Sales Order Line in Salesforce
	#
	#5) Update the following fields:
	#
	#Item: CAEP Partner Community Member
	#
	#Price Rule: Package 1 CAEP Partnership Community Member
	#
	#-Price Override: \[Check]- {color:#00b8d9}_PM NOTE: THIS STEP IS WRONG - IF PRICE OVERRIDE IS CHECK, THE SYSTEM DOES NOT UPDATE THE PRICE AT ALL_ {color}
	#
	#Subscription Plan: FON-1 Year Anniversary
	#
	#Subscription Start Date: Any date in the future
	#
	#Activation Date: Any date in the future
	#
	#6) Select Save
	#
	#_Error is found here: The record does not recognize the price rule and no value is applied to the Sale Price field._
	#
	#GCO SO example: [https://gco44ea4v.my.salesforce.com/a1J4W00000EG7Tc|https://gco44ea4v.my.salesforce.com/a1J4W00000EG7Tc]
	#
	#*Actual Results:*
	#
	#* When the Sales Order Line. is manually created, the Sale Price field on the Sales Order Line remains at $0.00
	#* If the Sales Order is paid, the manually created Sales Order Line does not generate a Receipt Line
	#* When the Sales Order Line is created in ROE and then edited, the Sale Price field remains the default price (Note - Replication steps remain exactly the same as above)
	#
	#*Expected Results:*
	#
	#* The Sale Price field on the Sales Order Line recognizes the price rule and updates its price.
	#
	#*Business Justification:*
	#
	#Clayton: CAEP has flagged this as a priority
	#
	#*CS Note:*
	#GCO Org ID (20Spring.1): 00D4W0000092BSp GCO Org ID (19R1): 00D5Y000001M3PW
	@TEST_PD-29378 @REQ_PD-27847 @21Winter @22Winter @regression @pavan
	Scenario: Test Price Rule does not update the Sales Order Line's Sale Price field
		Given User will select "Coco Dulce" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoItem1" item on rapid order entry
		And User exit to sales order page and navigate to sales order line details page
		When User create a manual subscription sale order line with following details
			| itemClass          | itemName             | businessGroup | priceRule                | subscriptionPlan |
			| Subscription Class | autoSubscriptionItem | Foundation    | DiscountWithlifeTimePlan | lifeTimePlan     |
		Then User validates the sale price is populated with price rule "DiscountWithlifeTimePlan" for the item "autoSubscriptionItem"	

