@REQ_PD-28943
Feature: (21Winter) "Expired" Status no longer getting set on previous year membership Subscriptions
	#h2. Details
	#
	#When "back-selling" a previous year subscription (example, a 2020 National Active membership subscription), paying or posting the Sales Order used to create a subscription with a past term (1/1/2020 - 12/31/2020 in this example), and it would set the Status of the Subscription to "Expired". After applying patch 0.11, this no longer happens – the Status of the Subscription is blank.
	#
	#h2. Steps to Reproduce
	#
	#Replicated in: 21Winter.0.11
	#Org ID: 00D5Y000001NF952
	#URL: [https://eligco.lightning.force.com/lightning/page/home|https://eligco.lightning.force.com/lightning/page/home]
	#Username: enesson-20r2b@fonteva.com
	#Password: Fonteva703
	#
	#Replication Steps:-
	#
	#1. Created a similar Subscription Plan, Item, and Item Class in the GCO
	#Subscription Plan: [https://eligco.lightning.force.com/lightning/r/OrderApi__Subscription_Plan__c/a1R5Y0000063fiNUAQ/view|https://eligco.lightning.force.com/lightning/r/OrderApi__Subscription_Plan__c/a1R5Y0000063fiNUAQ/view]
	#
	#Type: Calendar
	#Enable Proration: True
	#Proration Rule: Monthly
	#Auto Renew Option: Disabled
	#
	#Item: [https://eligco.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000icx5YQAQ/view|https://eligco.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000icx5YQAQ/view]
	#
	#Is Subscription: True
	#Defer Revenue: True
	#Revenue Recognition Rule: Over Time
	#Revenue Recognition Term Rule: No Partial Credit
	#Deferred Revenue Term (In Months): 12
	#
	#Item Class: [https://eligco.lightning.force.com/lightning/r/OrderApi__Item_Class__c/a135Y00000l3kovQAA/view|https://eligco.lightning.force.com/lightning/r/OrderApi__Item_Class__c/a135Y00000l3kovQAA/view]
	#
	#Is Subscription: True
	#
	#2. Created a sales order for the above item using ROE and exit the Sales Order before processing the Sales Order.
	#[https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000AN3qpUAD/view|https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000AN3qpUAD/view]
	#
	#3. Edit the Sales Order Line and change the Subscription Start Date, Activation Date to 1/1/2020, and End Date to 12/31/2020.
	#[https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order_Line__c/a1I5Y00000KK4ENUA1/view|https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order_Line__c/a1I5Y00000KK4ENUA1/view]
	#
	#4. Complete the Sales Order using Apply Payment Button.
	#5. The Status Field is left empty on the membership record which should be Expired.
	#[https://eligco.lightning.force.com/lightning/r/OrderApi__Subscription__c/a1S5Y000006uqfKUAQ/view|https://eligco.lightning.force.com/lightning/r/OrderApi__Subscription__c/a1S5Y000006uqfKUAQ/view]
	#Also, the Status, Term Start Date and Term End Date fields on the Highlights panel are blank.
	#
	#6. The Term Start Date and Term End Date on the Term record has the correct dates on it.
	#[https://eligco.lightning.force.com/lightning/r/OrderApi__Renewal__c/a1H5Y00000BFm1LUAT/view|https://eligco.lightning.force.com/lightning/r/OrderApi__Renewal__c/a1H5Y00000BFm1LUAT/view]
	#
	#Screenshot of the Membership record: [https://togetherwork-my.sharepoint.com/:i:/g/personal/sbangwal_fonteva_com/Ec1hY88qQwZGnpqb1N6L1c4BE9eP7CEvm7p7iJS2bfN9YA?e=f06NTi|https://togetherwork-my.sharepoint.com/:i:/g/personal/sbangwal_fonteva_com/Ec1hY88qQwZGnpqb1N6L1c4BE9eP7CEvm7p7iJS2bfN9YA?e=f06NTi]
	#
	#h2. Expected Results
	#
	#The Status field on the membership record should have been updated to expired and the Term Start and End Dates on the Highlights panel should be updated based on the SOL dates
	#
	#h2. Actual Results
	#
	#The Status field on the membership record is left blank
	#
	#h2. Business Justification
	#
	#for a former member with a lapsed membership, we sell the previous year(s), the member pays, then we Renew that membership into the next year until we have brought their membership up to date.
	#
	#
	#
	#*T3 Notes:*
	#
	#Needs to set {{sub.Status__c = SubscriptionStatus.Expired.name();}} in OrderApi.SubscriptionService.{{setStatus}}

	#Tests h2. Details
	#
	#When "back-selling" a previous year subscription (example, a 2020 National Active membership subscription), paying or posting the Sales Order used to create a subscription with a past term (1/1/2020 - 12/31/2020 in this example), and it would set the Status of the Subscription to "Expired". After applying patch 0.11, this no longer happens – the Status of the Subscription is blank.
	#
	#h2. Steps to Reproduce
	#
	#Replicated in: 21Winter.0.11
	#Org ID: 00D5Y000001NF952
	#URL: [https://eligco.lightning.force.com/lightning/page/home|https://eligco.lightning.force.com/lightning/page/home]
	#Username: enesson-20r2b@fonteva.com
	#Password: Fonteva703
	#
	#Replication Steps:-
	#
	#1. Created a similar Subscription Plan, Item, and Item Class in the GCO
	#Subscription Plan: [https://eligco.lightning.force.com/lightning/r/OrderApi__Subscription_Plan__c/a1R5Y0000063fiNUAQ/view|https://eligco.lightning.force.com/lightning/r/OrderApi__Subscription_Plan__c/a1R5Y0000063fiNUAQ/view]
	#
	#Type: Calendar
	#Enable Proration: True
	#Proration Rule: Monthly
	#Auto Renew Option: Disabled
	#
	#Item: [https://eligco.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000icx5YQAQ/view|https://eligco.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000icx5YQAQ/view]
	#
	#Is Subscription: True
	#Defer Revenue: True
	#Revenue Recognition Rule: Over Time
	#Revenue Recognition Term Rule: No Partial Credit
	#Deferred Revenue Term (In Months): 12
	#
	#Item Class: [https://eligco.lightning.force.com/lightning/r/OrderApi__Item_Class__c/a135Y00000l3kovQAA/view|https://eligco.lightning.force.com/lightning/r/OrderApi__Item_Class__c/a135Y00000l3kovQAA/view]
	#
	#Is Subscription: True
	#
	#2. Created a sales order for the above item using ROE and exit the Sales Order before processing the Sales Order.
	#[https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000AN3qpUAD/view|https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000AN3qpUAD/view]
	#
	#3. Edit the Sales Order Line and change the Subscription Start Date, Activation Date to 1/1/2020, and End Date to 12/31/2020.
	#[https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order_Line__c/a1I5Y00000KK4ENUA1/view|https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order_Line__c/a1I5Y00000KK4ENUA1/view]
	#
	#4. Complete the Sales Order using Apply Payment Button.
	#5. The Status Field is left empty on the membership record which should be Expired.
	#[https://eligco.lightning.force.com/lightning/r/OrderApi__Subscription__c/a1S5Y000006uqfKUAQ/view|https://eligco.lightning.force.com/lightning/r/OrderApi__Subscription__c/a1S5Y000006uqfKUAQ/view]
	#Also, the Status, Term Start Date and Term End Date fields on the Highlights panel are blank.
	#
	#6. The Term Start Date and Term End Date on the Term record has the correct dates on it.
	#[https://eligco.lightning.force.com/lightning/r/OrderApi__Renewal__c/a1H5Y00000BFm1LUAT/view|https://eligco.lightning.force.com/lightning/r/OrderApi__Renewal__c/a1H5Y00000BFm1LUAT/view]
	#
	#Screenshot of the Membership record: [https://togetherwork-my.sharepoint.com/:i:/g/personal/sbangwal_fonteva_com/Ec1hY88qQwZGnpqb1N6L1c4BE9eP7CEvm7p7iJS2bfN9YA?e=f06NTi|https://togetherwork-my.sharepoint.com/:i:/g/personal/sbangwal_fonteva_com/Ec1hY88qQwZGnpqb1N6L1c4BE9eP7CEvm7p7iJS2bfN9YA?e=f06NTi]
	#
	#h2. Expected Results
	#
	#The Status field on the membership record should have been updated to expired and the Term Start and End Dates on the Highlights panel should be updated based on the SOL dates
	#
	#h2. Actual Results
	#
	#The Status field on the membership record is left blank
	#
	#h2. Business Justification
	#
	#for a former member with a lapsed membership, we sell the previous year(s), the member pays, then we Renew that membership into the next year until we have brought their membership up to date.
	#
	#
	#
	#*T3 Notes:*
	#
	#Needs to set {{sub.Status__c = SubscriptionStatus.Expired.name();}} in OrderApi.SubscriptionService.{{setStatus}}
	@TEST_PD-29075 @REQ_PD-28943 @21Winter @22Winter @pavan @regression
	Scenario: Test (21Winter) "Expired" Status no longer getting set on previous year membership Subscriptions
		Given User will select "Coco Dulce" contact
		And User opens the Rapid Order Entry page from contact
		When User should be able to add "AutoMonthlyProrationDeferRevenue" item on rapid order entry
		And User selects "Process Payment" as payment method and proceeds further
		And User navigate back to sales order and updated the sol with Subscription Start Date,Activation Date and End Date to "2020" year
		And User makes the sales order ready for payment and complete the payment
		Then User validates the Status Field as Expired in the sales order

