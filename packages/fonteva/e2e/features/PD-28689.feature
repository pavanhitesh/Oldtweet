@REQ_PD-28689
Feature: Price Rule are not enforced when the Rule Criteria is Subscription Plan
	#h2. Details
	#When you have a subscription item with price rules based on the selected subscription plan, and you Renew the subscription via the back end, and then change the subscription plan for the Sales Order line, the Price Rule is not enforced.
	#h2. Steps to Reproduce
	#1. Created an Item class and a subscription Item
	#Item Class: https://eligco.lightning.force.com/lightning/r/OrderApi__Item_Class__c/a135Y00000l2vEXQAY/view?0.source=alohaHeader
	#Item: https://eligco.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000ibaXfQAI/view?0.source=alohaHeader
	#
	#2. Create two subscription plan: "1 Year Calendar" "1 Year Calendar with 12 Instalments" (default)
	#Subscription Plan(1 year calendar): https://eligco.lightning.force.com/lightning/r/OrderApi__Subscription_Plan__c/a1R5Y0000063dpnUAA/view?0.source=alohaHeader
	#
	#Subscription Plan(1 Year Calendar with Instalments): https://eligco.lightning.force.com/lightning/r/OrderApi__Subscription_Plan__c/a1R5Y0000063dprUAA/view?0.source=alohaHeader
	#
	#3. Add a Price Rule to reduce the cost of the subscription to 200 if the "1 Year Calendar" subscription plan is selected.
	#4. Process an order using ROE for the newly created subscription item to a Contact using the default subscription plan ("1 year calendar with 12 instalments").
	#Sales Order: https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000AN04SUAT/view
	#
	#5. Go to the subscription record and click the "renew" button.
	#Renewal Sales order: https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000AN04TUAT/view
	#6. Edit the Sales Order Line on the renewal Sales Order and change the subscription plan from "1 Year Calendar with 12 instalments" to "1 Year Calendar".
	#SOL: https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order_Line__c/a1I5Y00000KK3dAUAT/view
	#7. Save the changes.
	#8. Price Rule on the SOL is still set to Default and is not update due to which the Price of the subscription item on Sales Order Line is not updated.
	#
	#Issue Journey: https://togetherwork-my.sharepoint.com/:v:/g/personal/sbangwal_fonteva_com/ETYKce7dFLVNuJVur1yBWLoBwADE9gDcdPaVbonut7R_1g?e=8DvYBc
	#h2. Expected Results
	#Price Rule should be enforced on the SOL once it meets the criteria.
	#h2. Actual Results
	#Price rule is not enforced even after changing the Subscription plan on the SOL to meet the criteria.
	#h2. Business Justification
	#When you have a subscription item with price rules based on the selected subscription plan, and you Renew the subscription via the back end, and then change the subscription plan for the Sales Order line, the Price Rule is not enforced.

	#Tests h2. Details
	#When you have a subscription item with price rules based on the selected subscription plan, and you Renew the subscription via the back end, and then change the subscription plan for the Sales Order line, the Price Rule is not enforced.
	#h2. Steps to Reproduce
	#1. Created an Item class and a subscription Item
	#Item Class: https://eligco.lightning.force.com/lightning/r/OrderApi__Item_Class__c/a135Y00000l2vEXQAY/view?0.source=alohaHeader
	#Item: https://eligco.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000ibaXfQAI/view?0.source=alohaHeader
	#
	#2. Create two subscription plan: "1 Year Calendar" "1 Year Calendar with 12 Instalments" (default)
	#Subscription Plan(1 year calendar): https://eligco.lightning.force.com/lightning/r/OrderApi__Subscription_Plan__c/a1R5Y0000063dpnUAA/view?0.source=alohaHeader
	#
	#Subscription Plan(1 Year Calendar with Instalments): https://eligco.lightning.force.com/lightning/r/OrderApi__Subscription_Plan__c/a1R5Y0000063dprUAA/view?0.source=alohaHeader
	#
	#3. Add a Price Rule to reduce the cost of the subscription to 200 if the "1 Year Calendar" subscription plan is selected.
	#4. Process an order using ROE for the newly created subscription item to a Contact using the default subscription plan ("1 year calendar with 12 instalments").
	#Sales Order: https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000AN04SUAT/view
	#
	#5. Go to the subscription record and click the "renew" button.
	#Renewal Sales order: https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000AN04TUAT/view
	#6. Edit the Sales Order Line on the renewal Sales Order and change the subscription plan from "1 Year Calendar with 12 instalments" to "1 Year Calendar".
	#SOL: https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order_Line__c/a1I5Y00000KK3dAUAT/view
	#7. Save the changes.
	#8. Price Rule on the SOL is still set to Default and is not update due to which the Price of the subscription item on Sales Order Line is not updated.
	#
	#Issue Journey: https://togetherwork-my.sharepoint.com/:v:/g/personal/sbangwal_fonteva_com/ETYKce7dFLVNuJVur1yBWLoBwADE9gDcdPaVbonut7R_1g?e=8DvYBc
	#h2. Expected Results
	#Price Rule should be enforced on the SOL once it meets the criteria.
	#h2. Actual Results
	#Price rule is not enforced even after changing the Subscription plan on the SOL to meet the criteria.
	#h2. Business Justification
	#When you have a subscription item with price rules based on the selected subscription plan, and you Renew the subscription via the back end, and then change the subscription plan for the Sales Order line, the Price Rule is not enforced.
	@TEST_PD-29350 @REQ_PD-28689 @21Winter @22Winter @akash @regression
	Scenario: Test Price Rule are not enforced when the Rule Criteria is Subscription Plan
		Given User will select "Daniela Brown" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoCalenderPlanWInstallment" item on rapid order entry
		And User navigate to "apply payment" page for "AutoCalenderPlanWInstallment" item from rapid order entry
		And User should be able to apply payment for "AutoCalenderPlanWInstallment" item using "Credit Card" payment on apply payment page
		And User clicks renew on subscription and update sales order line subscription plan with "AutoCalenderSubscription" plan
		Then User verifies price rule "New Price Rule For AutoCalenderPlanWInstallment" for "AutoCalenderPlanWInstallment" item is applied


