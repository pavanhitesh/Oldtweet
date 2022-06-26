@REQ_PD-27173
Feature: Advanced Item Settings - The End User is forced to add an Additional Item to the cart to proceed to checkout.
	#*Case Reporter* Steven Henry
	#
	#*Customer* Council on Tall Buildings and Urban Habitat
	#
	#*Reproduced by* John Herrera in 2019.1.0.35,20Spring.1.4
	#
	#*Reference Case#* [00028349|https://fonteva.my.salesforce.com/5004V000013bf3AQAQ]
	#
	#
	#
	#*PM NOTE:*
	#
	#Additional Items are OPTIONAL, we should not force users to select.
	#
	#
	#
	#*Screen Recording:*
	#
	#[https://www.screencast.com/t/5Gc7aR61gTVo|https://www.screencast.com/t/5Gc7aR61gTVo]
	#
	#
	#
	#*Org to Reproduce:*
	#
	#GCO Org ID (19R1): 00D4T000000DJ73
	#
	#GCO Org ID (20Spring.1): 00D4W0000092BSp
	#
	#19R1 - Item: "Another Publication"
	#
	#[https://gco1k6wlf.my.salesforce.com/a154T0000006Pfs|https://gco1k6wlf.my.salesforce.com/a154T0000006Pfs]
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#Configuration:
	#
	## Create an Item (eg Publication Item called "Another Publication") and relate it to a catalog (ie Publications)
	#
	## On the new Item (ie Another Publication), create a Package Item by selecting "Advanced Item Settings"
	#
	## Configure an "Additional Item"
	#
	#Quantity Settings:
	#
	#a. Minimum Quantity Per Group = 0
	#
	#b. Maximum Quantity Per Group = 3
	#
	#c. Maximum Quantity Per Item = 1
	#
	## Save
	#
	#
	#
	#End-User replication steps:
	#
	#1) Go to Store and select item (eg "Another Publication")
	#
	#2) Add to cart
	#
	#3) Select "Add to Cart" to proceed
	#
	#Note - The End User cannot proceed without first adding an Additional Item and then removing it.
	#
	#
	#
	#*Actual Results:*
	#
	#The End User cannot proceed to the checkout page without adding an additional item to the cart.
	#
	#*Expected Results:*
	#
	#The End User can proceed to the checkout page without adding an additional item to the cart.
	#
	#
	#*T3 Notes:*
	#To solve the issue we have to add additional code to SubscriptionsAdditionalItemsHelper.js ( after this line\[[https://github.com/Fonteva/LightningLens/blob/7c53881c0c926055f827185b33a57f335fb5|https://github.com/Fonteva/LightningLens/blob/7c53881c0c926055f827185b33a57f335fb5]\[…]scriptionsAdditionalItems/SubscriptionsAdditionalItemsHelper.js|[https://github.com/Fonteva/LightningLens/blob/7c53881c0c926055f827185b33a57f335fb5f49e/community/main/default/aura/SubscriptionsAdditionalItems/SubscriptionsAdditionalItemsHelper.js#L17|https://github.com/Fonteva/LightningLens/blob/7c53881c0c926055f827185b33a57f335fb5f49e/community/main/default/aura/SubscriptionsAdditionalItems/SubscriptionsAdditionalItemsHelper.js#L17]] )
	#code to be added:
	#if (g.minimumQuantity == 0) \{
	#cmp.set('v.disableNext', false);
	#}

	#Tests *Case Reporter* Steven Henry
	#
	#*Customer* Council on Tall Buildings and Urban Habitat
	#
	#*Reproduced by* John Herrera in 2019.1.0.35,20Spring.1.4
	#
	#*Reference Case#* [00028349|https://fonteva.my.salesforce.com/5004V000013bf3AQAQ]
	#
	#
	#
	#*PM NOTE:*
	#
	#Additional Items are OPTIONAL, we should not force users to select.
	#
	#
	#
	#*Screen Recording:*
	#
	#[https://www.screencast.com/t/5Gc7aR61gTVo|https://www.screencast.com/t/5Gc7aR61gTVo]
	#
	#
	#
	#*Org to Reproduce:*
	#
	#GCO Org ID (19R1): 00D4T000000DJ73
	#
	#GCO Org ID (20Spring.1): 00D4W0000092BSp
	#
	#19R1 - Item: "Another Publication"
	#
	#[https://gco1k6wlf.my.salesforce.com/a154T0000006Pfs|https://gco1k6wlf.my.salesforce.com/a154T0000006Pfs]
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#Configuration:
	#
	## Create an Item (eg Publication Item called "Another Publication") and relate it to a catalog (ie Publications)
	#
	## On the new Item (ie Another Publication), create a Package Item by selecting "Advanced Item Settings"
	#
	## Configure an "Additional Item"
	#
	#Quantity Settings:
	#
	#a. Minimum Quantity Per Group = 0
	#
	#b. Maximum Quantity Per Group = 3
	#
	#c. Maximum Quantity Per Item = 1
	#
	## Save
	#
	#
	#
	#End-User replication steps:
	#
	#1) Go to Store and select item (eg "Another Publication")
	#
	#2) Add to cart
	#
	#3) Select "Add to Cart" to proceed
	#
	#Note - The End User cannot proceed without first adding an Additional Item and then removing it.
	#
	#
	#
	#*Actual Results:*
	#
	#The End User cannot proceed to the checkout page without adding an additional item to the cart.
	#
	#*Expected Results:*
	#
	#The End User can proceed to the checkout page without adding an additional item to the cart.
	#
	#
	#*T3 Notes:*
	#To solve the issue we have to add additional code to SubscriptionsAdditionalItemsHelper.js ( after this line\[[https://github.com/Fonteva/LightningLens/blob/7c53881c0c926055f827185b33a57f335fb5|https://github.com/Fonteva/LightningLens/blob/7c53881c0c926055f827185b33a57f335fb5]\[…]scriptionsAdditionalItems/SubscriptionsAdditionalItemsHelper.js|[https://github.com/Fonteva/LightningLens/blob/7c53881c0c926055f827185b33a57f335fb5f49e/community/main/default/aura/SubscriptionsAdditionalItems/SubscriptionsAdditionalItemsHelper.js#L17|https://github.com/Fonteva/LightningLens/blob/7c53881c0c926055f827185b33a57f335fb5f49e/community/main/default/aura/SubscriptionsAdditionalItems/SubscriptionsAdditionalItemsHelper.js#L17]] )
	#code to be added:
	#if (g.minimumQuantity == 0) \{
	#cmp.set('v.disableNext', false);
	#}
	@REQ_PD-27173 @TEST_PD-27798 @regression @22Winter @21Winter @svinjamuri
	Scenario: Test Advanced Item Settings - The End User is forced to add an Additional Item to the cart to proceed to checkout.
		Given User navigate to community Portal page with "ettabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		When User should be able to select "AutoAdditionalItem" item with quantity "1" on store
		And User selects Add to Cart from Additional items page without selecting additional item
		Then User should click on the checkout button
		And User verifies the cart is having only "AutoAdditionalItem" item
		And User successfully pays for the order using credit card
