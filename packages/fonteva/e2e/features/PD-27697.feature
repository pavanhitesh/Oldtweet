@REQ_PD-27697
Feature: Price rules are not working for the package items
	#*Case Reporter* Brandi Berry-Cristofaro
	#
	#*Customer* American Society of Human Genetics
	#
	#*Reproduced by* Gavin Britto in 2019.1.0.35
	#
	#*Reference Case#* [00028617|https://fonteva.my.salesforce.com/5004V000014JJyJQAW]
	#
	#*Description:*
	#
	#Unable to have display/charge add-on prices for two-year subscription plans; undercharging members who opt into a two-year plan.
	#
	#This issue is Fixed in 20Spring but customers are not ready to go to 20 Spring yet.
	#
	#19.1.0.35 GCO For testing - [https://gcowc5gfn.my.salesforce.com|https://gcowc5gfn.my.salesforce.com/]
	#
	#Username: [4kos8dzws15@fondash.io|mailto:4kos8dzws15@fondash.io]
	#
	#Pass: Fonteva703
	#
	#Main Subscription Item: [https://gcowc5gfn.lightning.force.com/lightning/r/OrderApi\\_\\_Item\\_\\_c/a155Y00000gXZGnQAO/view|https://gcowc5gfn.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000gXZGnQAO/view]
	#
	#Addon Item: [https://gcowc5gfn.lightning.force.com/lightning/r/OrderApi\\_\\_Item\\_\\_c/a155Y00000gXZGxQAO/view|https://gcowc5gfn.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000gXZGxQAO/view]
	#
	#*Steps to Reproduce:*
	#
	#* Create a subscription item say Item A 
	#* Create two subscription plans for the above item say Plan A and Plan B
	#* Create a Price Rule for Plan B 
	#* Create another subscription item say Item B
	#* Add subscription Plans Plan A and Plan B to the above item
	#* Create a Price Rule for Plan B
	#* Add Item A as an optional package item to Item B
	#* Go to a contact
	#* Go to ROE
	#* Search for Item B
	#* Select Plan B
	#* Click Add to order
	#* Expand the item details
	#* Verify the price rule for the Optional Package Items
	#
	#
	#
	#*Actual Results:*
	#
	#Default Price Rule is applied
	#
	#
	#
	#*Expected Results:*
	#
	#The price rule must change to price rule with Plan B as criteria 
	#
	#
	#
	#*Environment*
	#
	#login URL: [http://test.salesforce.com|http://test.salesforce.com|smart-link] 
	#
	#Username: [sm21winternmc@fondash.io.sb|mailto:sm21winternmc@fondash.io.sb]
	#
	#Password Fonteva703
	#
	#Item A: [https://gcob3gzs--sb.lightning.force.com/lightning/r/OrderApi__Item__c/a187b000001Mh3lAAC/view|https://gcob3gzs--sb.lightning.force.com/lightning/r/OrderApi__Item__c/a187b000001Mh3lAAC/view]
	#
	#Item B: [https://gcob3gzs--sb.lightning.force.com/lightning/r/OrderApi__Item__c/a187b000001Mh40AAC/view|https://gcob3gzs--sb.lightning.force.com/lightning/r/OrderApi__Item__c/a187b000001Mh40AAC/view]
	#
	#
	#
	#*T3 Notes:*
	#
	#Working in 20Spring.0, no clone needed, need to backport 19R1
	#
	#Possible solution
	#
	#1 . When we execute this code , we specify param name different from apex param 
	#[https://github.com/Fonteva/RapidOrderEntry/blob/ddc92f7cc99f2152ef5df53f5c5e5a62c61b23bd/src/aura/PackageItemRow/PackageItemRowHelper.js#L75|https://github.com/Fonteva/RapidOrderEntry/blob/ddc92f7cc99f2152ef5df53f5c5e5a62c61b23bd/src/aura/PackageItemRow/PackageItemRowHelper.js#L75]
	#
	#We have to change param name from priceRule to priceRuleId here
	#
	#[https://github.com/Fonteva/RapidOrderEntry/blob/ddc92f7cc99f2152ef5df53f5c5e5a62c61b23bd/src/classes/PackageItemDetailsController.cls#L12|https://github.com/Fonteva/RapidOrderEntry/blob/ddc92f7cc99f2152ef5df53f5c5e5a62c61b23bd/src/classes/PackageItemDetailsController.cls#L12]
	#
	#2. Also when we include additional item to order we don't specify subscriptionPlan for it, so at this line we have null
	#
	#[https://github.com/Fonteva/FDServiceVersions/blob/033fced635f74ea233b8735b3b39157a881d7702/src/api/main/classes/OrderService.cls#L491|https://github.com/Fonteva/FDServiceVersions/blob/033fced635f74ea233b8735b3b39157a881d7702/src/api/main/classes/OrderService.cls#L491]
	#
	#because of this we have default price rule
	#
	#To solve this we have to fill suscriptionPlan on SOL wrapper before adding item to order. (add this code before this line [https://github.com/Fonteva/RapidOrderEntry/blob/ddc92f7cc99f2152ef5df53f5c5e5a62c61b23bd/src/classes/PackageItemDetailsController.cls#L38|https://github.com/Fonteva/RapidOrderEntry/blob/ddc92f7cc99f2152ef5df53f5c5e5a62c61b23bd/src/classes/PackageItemDetailsController.cls#L38])
	#
	#if (String.isNotEmpty(soLine.salesOrderLine)) \{
	#
	#OrderApi__Sales_Order_Line__c parentSOL = (OrderApi__Sales_Order_Line__c) new Framework.Selector(OrderApi__Sales_Order_Line__c.SObjectType)
	#
	#.fields('OrderApi__Subscription_Plan__c')
	#
	#.selectById(parentSalesOrderLine);
	#
	#soLine.subscriptionPlan = parentSOL.OrderApi__Subscription_Plan__c;
	#
	#}

	#Tests *Case Reporter* Brandi Berry-Cristofaro
	#
	#*Customer* American Society of Human Genetics
	#
	#*Reproduced by* Gavin Britto in 2019.1.0.35
	#
	#*Reference Case#* [00028617|https://fonteva.my.salesforce.com/5004V000014JJyJQAW]
	#
	#*Description:*
	#
	#Unable to have display/charge add-on prices for two-year subscription plans; undercharging members who opt into a two-year plan.
	#
	#This issue is Fixed in 20Spring but customers are not ready to go to 20 Spring yet.
	#
	#19.1.0.35 GCO For testing - [https://gcowc5gfn.my.salesforce.com|https://gcowc5gfn.my.salesforce.com/]
	#
	#Username: [4kos8dzws15@fondash.io|mailto:4kos8dzws15@fondash.io]
	#
	#Pass: Fonteva703
	#
	#Main Subscription Item: [https://gcowc5gfn.lightning.force.com/lightning/r/OrderApi\\_\\_Item\\_\\_c/a155Y00000gXZGnQAO/view|https://gcowc5gfn.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000gXZGnQAO/view]
	#
	#Addon Item: [https://gcowc5gfn.lightning.force.com/lightning/r/OrderApi\\_\\_Item\\_\\_c/a155Y00000gXZGxQAO/view|https://gcowc5gfn.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000gXZGxQAO/view]
	#
	#*Steps to Reproduce:*
	#
	#* Create a subscription item say Item A 
	#* Create two subscription plans for the above item say Plan A and Plan B
	#* Create a Price Rule for Plan B 
	#* Create another subscription item say Item B
	#* Add subscription Plans Plan A and Plan B to the above item
	#* Create a Price Rule for Plan B
	#* Add Item A as an optional package item to Item B
	#* Go to a contact
	#* Go to ROE
	#* Search for Item B
	#* Select Plan B
	#* Click Add to order
	#* Expand the item details
	#* Verify the price rule for the Optional Package Items
	#
	#
	#
	#*Actual Results:*
	#
	#Default Price Rule is applied
	#
	#
	#
	#*Expected Results:*
	#
	#The price rule must change to price rule with Plan B as criteria 
	#
	#
	#
	#*Environment*
	#
	#login URL: [http://test.salesforce.com|http://test.salesforce.com|smart-link] 
	#
	#Username: [sm21winternmc@fondash.io.sb|mailto:sm21winternmc@fondash.io.sb]
	#
	#Password Fonteva703
	#
	#Item A: [https://gcob3gzs--sb.lightning.force.com/lightning/r/OrderApi__Item__c/a187b000001Mh3lAAC/view|https://gcob3gzs--sb.lightning.force.com/lightning/r/OrderApi__Item__c/a187b000001Mh3lAAC/view]
	#
	#Item B: [https://gcob3gzs--sb.lightning.force.com/lightning/r/OrderApi__Item__c/a187b000001Mh40AAC/view|https://gcob3gzs--sb.lightning.force.com/lightning/r/OrderApi__Item__c/a187b000001Mh40AAC/view]
	#
	#
	#
	#*T3 Notes:*
	#
	#Working in 20Spring.0, no clone needed, need to backport 19R1
	#
	#Possible solution
	#
	#1 . When we execute this code , we specify param name different from apex param 
	#[https://github.com/Fonteva/RapidOrderEntry/blob/ddc92f7cc99f2152ef5df53f5c5e5a62c61b23bd/src/aura/PackageItemRow/PackageItemRowHelper.js#L75|https://github.com/Fonteva/RapidOrderEntry/blob/ddc92f7cc99f2152ef5df53f5c5e5a62c61b23bd/src/aura/PackageItemRow/PackageItemRowHelper.js#L75]
	#
	#We have to change param name from priceRule to priceRuleId here
	#
	#[https://github.com/Fonteva/RapidOrderEntry/blob/ddc92f7cc99f2152ef5df53f5c5e5a62c61b23bd/src/classes/PackageItemDetailsController.cls#L12|https://github.com/Fonteva/RapidOrderEntry/blob/ddc92f7cc99f2152ef5df53f5c5e5a62c61b23bd/src/classes/PackageItemDetailsController.cls#L12]
	#
	#2. Also when we include additional item to order we don't specify subscriptionPlan for it, so at this line we have null
	#
	#[https://github.com/Fonteva/FDServiceVersions/blob/033fced635f74ea233b8735b3b39157a881d7702/src/api/main/classes/OrderService.cls#L491|https://github.com/Fonteva/FDServiceVersions/blob/033fced635f74ea233b8735b3b39157a881d7702/src/api/main/classes/OrderService.cls#L491]
	#
	#because of this we have default price rule
	#
	#To solve this we have to fill suscriptionPlan on SOL wrapper before adding item to order. (add this code before this line [https://github.com/Fonteva/RapidOrderEntry/blob/ddc92f7cc99f2152ef5df53f5c5e5a62c61b23bd/src/classes/PackageItemDetailsController.cls#L38|https://github.com/Fonteva/RapidOrderEntry/blob/ddc92f7cc99f2152ef5df53f5c5e5a62c61b23bd/src/classes/PackageItemDetailsController.cls#L38])
	#
	#if (String.isNotEmpty(soLine.salesOrderLine)) \{
	#
	#OrderApi__Sales_Order_Line__c parentSOL = (OrderApi__Sales_Order_Line__c) new Framework.Selector(OrderApi__Sales_Order_Line__c.SObjectType)
	#
	#.fields('OrderApi__Subscription_Plan__c')
	#
	#.selectById(parentSalesOrderLine);
	#
	#soLine.subscriptionPlan = parentSOL.OrderApi__Subscription_Plan__c;
	#
	#}
	@TEST_PD-29046 @REQ_PD-27697 @21Winter @22Winter @regression @pavan
	Scenario: Test Price rules are not working for the package items
		Given User will select "Coco Dulce" contact
		And User opens the Rapid Order Entry page from contact
		When User should be able to add "<itemName>" item with "lifeTimePlan" plan on rapid order entry
		And User is able to expand the Item details of "<itemName>" and select the Additional Package item
		Then User verfies the "DiscountWithlifeTimePlan" Price Rule is applied to optional packaged item "autoSubscriptionItem"

		Examples:
			| itemName                                   |
			| autoSubcriptionWithPackagedSubcriptionItem |

