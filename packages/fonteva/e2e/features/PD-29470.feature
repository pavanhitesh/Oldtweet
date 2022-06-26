@REQ_PD-29470
Feature: Adjustment field on Sales orders not populating for positive adjustment.
	#h2. Details
	#Adjustment field on Sales orders not populating for positive adjustment.
	#h2. Steps to Reproduce
	#1. Open any contact and select ROE.
	#2. Add an item, select type "Invoice" and click on the "Go" button.
	#3. Click on Ready For Payment.
	#4. In the "Sales Order Line" related list, click New.
	#5. Select an Item for Adjustment, its price, check "Is Adjustment" and "Is Posted" checkbox. Save.
	#6. Adjustment transaction gets created, but the "Credit Notes/Adjustments" field on Sales Order is not populated.
	#
	#GCO details: 3vvovotg449@fondash.io, FontevaWin21
	#Sales Order: https://gco80g64k.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5f000002F0hMEAS/view
	#
	#Recording: https://fonteva.zoom.us/rec/share/KfSAKPuWdukBE7W6lrM9MPGydTgr6hJgIpzklb8WUNn7XhrzXhrDMpg0a3x9y8uu.06TvIqltY-dg2q0Y
	#h2. Expected Results
	#Adjustment field on Sales orders should populate for positive adjustment.
	#h2. Actual Results
	#Adjustment field on Sales orders not populating for positive adjustment.
	#h2. Business Justification
	#Adjustment field on Sales orders should populate for positive adjustment.

	#Tests h2. Details
	#Adjustment field on Sales orders not populating for positive adjustment.
	#h2. Steps to Reproduce
	#1. Open any contact and select ROE.
	#2. Add an item, select type "Invoice" and click on the "Go" button.
	#3. Click on Ready For Payment.
	#4. In the "Sales Order Line" related list, click New.
	#5. Select an Item for Adjustment, its price, check "Is Adjustment" and "Is Posted" checkbox. Save.
	#6. Adjustment transaction gets created, but the "Credit Notes/Adjustments" field on Sales Order is not populated.
	#
	#GCO details: 3vvovotg449@fondash.io, FontevaWin21
	#Sales Order: https://gco80g64k.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5f000002F0hMEAS/view
	#
	#Recording: https://fonteva.zoom.us/rec/share/KfSAKPuWdukBE7W6lrM9MPGydTgr6hJgIpzklb8WUNn7XhrzXhrDMpg0a3x9y8uu.06TvIqltY-dg2q0Y
	#h2. Expected Results
	#Adjustment field on Sales orders should populate for positive adjustment.
	#h2. Actual Results
	#Adjustment field on Sales orders not populating for positive adjustment.
	#h2. Business Justification
	#Adjustment field on Sales orders should populate for positive adjustment.
	@REQ_PD-29470 @TEST_PD-29549 @21Winter @22Winter @regression @ngunda
	Scenario: Test Adjustment field on Sales orders not populating for positive adjustment.
		Given User will select "Max Foxworth" contact
		And User opens the Rapid Order Entry page from contact
		When User should be able to add "AutoLTItem" item on rapid order entry
		And User selects "Invoice" as payment method and proceeds further
		And User creates salesOrder lines with information provided below:
			| ItemName  | Qty |
			| AutoItem6 | 1   |
		And User posts the SalesOrderline created
		Then User verifies there is no change in Adjustment and SO overall Total and Balance due is updated as per adjustment created
