@REQ_PD-28710
Feature: Correct Price Rule is not showing in ROE when selecting a Subscription Plan at the very first time.
	#h2. Details
	#Correct Price Rule is not showing in ROE when selecting a Subscription Plan at the very first time.
	#h2. Steps to Reproduce
	#1. Create an Item (Subscription type) with Deferred Revenue.
	#2. Create at least 2 Subscription Plans and attach them to the Item.
	#3. Create a Price Rule for each Subscription Plan.
	#4. Open a test contact (Bob Kelley) and Click on Rapid Order Entry.
	#5. Select that item in "Item Quick Add" and choose Plan, which is not associated with the "Default" Price Rule. Click Add.
	#6. Click on the Item details Dropdown button.
	#7. At first, you will see the Default Price.
	#8. Change the plan in the "Select Plan" option 2-3 times till it shows the correct amount.
	#Video Recording of issue:
	#https://fonteva.zoom.us/rec/share/Ql0TmG-mhSyLPPaHPT09dQ5wxVJT8dNmmz6UeKk7RnDMezWv-WnPNSe6liNEGu8_._3rDDEuiKbUW6JQs?startTime=1632241869000
	#Working in 21Winter.0.10
	#
	#GCO Details: enesson-20r1b@fonteva.com, Fonteva703
	#
	#Item: https://gcolirwql.lightning.force.com/lightning/r/OrderApi__Item__c/a154x000001hlyWAAQ/view
	#Subscription Plan: https://gcolirwql.lightning.force.com/lightning/r/OrderApi__Subscription_Plan__c/a1R4x000000ReByEAK/view
	#https://gcolirwql.lightning.force.com/lightning/r/OrderApi__Subscription_Plan__c/a1R4x000000ReC8EAK/view
	#h2. Expected Results
	#Correct Price Rule needs to show in ROE when selecting a Subscription Plan at the very first time.
	#h2. Actual Results
	#Correct Price Rule is not showing in ROE when selecting a Subscription Plan at the very first time.
	#h2. Business Justification
	#Correct Price Rule of any Item is necessary for correct payments and transactions. So to avoid wrong payments, it needs to be correct at the very first time.

	#Tests h2. Details
	#Correct Price Rule is not showing in ROE when selecting a Subscription Plan at the very first time.
	#h2. Steps to Reproduce
	#1. Create an Item (Subscription type) with Deferred Revenue.
	#2. Create at least 2 Subscription Plans and attach them to the Item.
	#3. Create a Price Rule for each Subscription Plan.
	#4. Open a test contact (Bob Kelley) and Click on Rapid Order Entry.
	#5. Select that item in "Item Quick Add" and choose Plan, which is not associated with the "Default" Price Rule. Click Add.
	#6. Click on the Item details Dropdown button.
	#7. At first, you will see the Default Price.
	#8. Change the plan in the "Select Plan" option 2-3 times till it shows the correct amount.
	#Video Recording of issue:
	#https://fonteva.zoom.us/rec/share/Ql0TmG-mhSyLPPaHPT09dQ5wxVJT8dNmmz6UeKk7RnDMezWv-WnPNSe6liNEGu8_._3rDDEuiKbUW6JQs?startTime=1632241869000
	#Working in 21Winter.0.10
	#
	#GCO Details: enesson-20r1b@fonteva.com, Fonteva703
	#
	#Item: https://gcolirwql.lightning.force.com/lightning/r/OrderApi__Item__c/a154x000001hlyWAAQ/view
	#Subscription Plan: https://gcolirwql.lightning.force.com/lightning/r/OrderApi__Subscription_Plan__c/a1R4x000000ReByEAK/view
	#https://gcolirwql.lightning.force.com/lightning/r/OrderApi__Subscription_Plan__c/a1R4x000000ReC8EAK/view
	#h2. Expected Results
	#Correct Price Rule needs to show in ROE when selecting a Subscription Plan at the very first time.
	#h2. Actual Results
	#Correct Price Rule is not showing in ROE when selecting a Subscription Plan at the very first time.
	#h2. Business Justification
	#Correct Price Rule of any Item is necessary for correct payments and transactions. So to avoid wrong payments, it needs to be correct at the very first time.
	@TEST_PD-29347 @REQ_PD-28710 @regression @pavan @21Winter @22Winter
	Scenario: Test Correct Price Rule is not showing in ROE when selecting a Subscription Plan at the very first time.
		Given User will select "Coco Dulce" contact
		And User opens the Rapid Order Entry page from contact
		When User should be able to add "Auto SubItem Deferred Revenue" item with "AutoCalenderDailyProrationPlan" plan on rapid order entry
		Then User verfies the "PriceRuleAutoCalenderDailyProrationPlan" Price Rule is applied to item "Auto SubItem Deferred Revenue"

