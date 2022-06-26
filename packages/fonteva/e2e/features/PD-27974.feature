@REQ_PD-27974
Feature: During checkout, an inactive price rule with an active source code is reducing the price of a subscription item
	#*Case Reporter* Hiral Shah
	#
	#*Customer* University of Michigan - Alumni Association
	#
	#*Reproduced by* John Herrera in 2019.1.0.42,21Winter.0.4
	#
	#*Reference Case#* [00030806|https://fonteva.my.salesforce.com/5004V000016NXGuQAO]
	#
	#*Description:*
	#
	#The price is being reduced by applying a source code at checkout when the Item does not have a Price Rule configured to reduce the price.
	#
	#The source code is active for other items and deactivated price rules.
	#
	#_A workaround is to remove the Source Code from the deactivated Price Rules on the affected Item._
	#
	#*Steps to Reproduce:*
	#
	#1)Create any item
	#
	#4) Create Price Rules for the Item
	#
	#* One Price rule is default
	#* Second/Third Price Rules are inactive, with a lower price than the default, and have a source code
	#
	#5) Create a Catalog for the Item, so that it's published to the eStore
	#
	#6) Navigate to the eStore and add the item to the Cart
	#
	#7) Select checkout
	#
	#8) *Apply the Souce Code for the inactive Price Rule*
	#
	#
	#
	#*Actual Results:*
	#
	#User is getting inactive price rule eventho the price rule is not active
	#
	#*Expected Results:*
	#
	#The system recognizes the price rule is inactive. There is no price reduction, and the End User is notified the price rule is inactive.
	#
	#*T3 Notes:*
	#
	#Currently, we are only checking if the source code is active in [https://github.com/Fonteva/LightningLens/blob/21Winter/community/main/default/classes/SalesOrder.cls#L731-L732|https://github.com/Fonteva/LightningLens/blob/21Winter/community/main/default/classes/SalesOrder.cls#L731-L732]. Instead, we need to check both whether the source code is active AND the price rule for which it is applied against is active as well
	#
	#*Businesss Justification:*
	#
	#* The customer runs various promotions using Source Codes
	#* The Marketing team tracks customer activity by Source Code usage
	#* Currently, an unconfigured and active Source code can be used on a Subscription Item (Lifetime w/ installments (5)) at the eStore checkout
	#* The technical team is hesitant to deactivate Source Codes as it will affect Marketing
	#
	#*CS Note:*
	#GCO Org ID (19R1): 00D5Y000001M3PW This is reproducible in a 21Winter GCO, however, the calculation at checkout differs ([https://www.screencast.com/t/RbmtAg0G)|https://www.screencast.com/t/RbmtAg0G)]. GCO Org ID (21Winter): 00D5Y000001NF95

	#Tests *Case Reporter* Hiral Shah
	#
	#*Customer* University of Michigan - Alumni Association
	#
	#*Reproduced by* John Herrera in 2019.1.0.42,21Winter.0.4
	#
	#*Reference Case#* [00030806|https://fonteva.my.salesforce.com/5004V000016NXGuQAO]
	#
	#*Description:*
	#
	#The price is being reduced by applying a source code at checkout when the Item does not have a Price Rule configured to reduce the price.
	#
	#The source code is active for other items and deactivated price rules.
	#
	#_A workaround is to remove the Source Code from the deactivated Price Rules on the affected Item._
	#
	#*Steps to Reproduce:*
	#
	#1)Create any item
	#
	#4) Create Price Rules for the Item
	#
	#* One Price rule is default
	#* Second/Third Price Rules are inactive, with a lower price than the default, and have a source code
	#
	#5) Create a Catalog for the Item, so that it's published to the eStore
	#
	#6) Navigate to the eStore and add the item to the Cart
	#
	#7) Select checkout
	#
	#8) *Apply the Souce Code for the inactive Price Rule*
	#
	#
	#
	#*Actual Results:*
	#
	#User is getting inactive price rule eventho the price rule is not active
	#
	#*Expected Results:*
	#
	#The system recognizes the price rule is inactive. There is no price reduction, and the End User is notified the price rule is inactive.
	#
	#*T3 Notes:*
	#
	#Currently, we are only checking if the source code is active in [https://github.com/Fonteva/LightningLens/blob/21Winter/community/main/default/classes/SalesOrder.cls#L731-L732|https://github.com/Fonteva/LightningLens/blob/21Winter/community/main/default/classes/SalesOrder.cls#L731-L732]. Instead, we need to check both whether the source code is active AND the price rule for which it is applied against is active as well
	#
	#*Businesss Justification:*
	#
	#* The customer runs various promotions using Source Codes
	#* The Marketing team tracks customer activity by Source Code usage
	#* Currently, an unconfigured and active Source code can be used on a Subscription Item (Lifetime w/ installments (5)) at the eStore checkout
	#* The technical team is hesitant to deactivate Source Codes as it will affect Marketing
	#
	#*CS Note:*
	#GCO Org ID (19R1): 00D5Y000001M3PW This is reproducible in a 21Winter GCO, however, the calculation at checkout differs ([https://www.screencast.com/t/RbmtAg0G)|https://www.screencast.com/t/RbmtAg0G)]. GCO Org ID (21Winter): 00D5Y000001NF95
	@TEST_PD-28260 @REQ_PD-27974 @22Winter @21winter @regression @pavan
	Scenario: Test During checkout, an inactive price rule with an active source code is reducing the price of a subscription item
		Given User creates a item and configure the catalog
			| itemName                      | itemPrice | catalog     |
			| priceRuleInactiveDiscountCode | 40        | Merchandise |
		And User configures inactive price rule with source codes as below
			| ruleName      | discountprice | sourceCode   |
			| halfPrice     | 20            | HALFOff      |
			| discountPrice | 15            | discountCode |
		When User navigate to community Portal page with "cdulce@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User should be able to select "priceRuleInactiveDiscountCode" item with quantity "1" on store
		Then User verifies the item price as after applying the discount Codes
			| sourceCodes  | itemPrice |
			| HALFOff      | $40.00    |
			| discountCode | $40.00    |
