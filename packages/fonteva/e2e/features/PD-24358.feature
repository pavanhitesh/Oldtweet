@REQ_PD-24358
Feature: ROE is Picking Up Price Rules for Packaged Items but displaying default Price Rule.
	#*Case Reporter* Erika Tomatore
	#
	#*Customer* Water Environment Federation
	#
	#*Reproduced by* Abdalla Harun in 20Spring.0.4
	#
	#*Reference Case#* [00024539|https://fonteva.my.salesforce.com/5004V000011RksNQAS]
	#
	#*Description:*
	#
	#* A Staff User who is adding a membership with packaged items through ROE, and whose packaged items have price rules based on Contact criteria, noticed that even though the Contact criteria are met when they add the item, the default price rule is displayed.
	#
	#*Steps to Reproduce:*
	#
	#* Make sure you have a membership item with packaged items
	#* Make sure the packaged item has a price rule which looks at criteria on the Contact record
	#* Then make sure the criteria is met on the Contact
	#* Go to ROE
	#* Select the membership
	#* View the Packaged Items
	#
	#*Actual Results:*
	#
	#Staff user is seeing the default price for the packaged item, although the price rule is being picked up when the item is added to the shopping cart
	#
	#*Expected Results:*
	#
	#When a staff user launches ROE from the Contact or Account & ROE knows ID of the SO Contact, Staff user see a relevant price rule for the packaged item. Similar to the front-end experience.
	#
	#*T3 Notes:*
	#
	#The problem arises from [https://github.com/Fonteva/RapidOrderEntry/blob/develop/src/classes/PackageItemDetailsController.cls#L88] when instantiating new instances of _PackageItem_ object.
	#
	#In _PackageItem_, [https://github.com/Fonteva/RapidOrderEntry/blob/develop/src/classes/PackageItem.cls#L51] , it then just iterates through all available price rules of current item and just assign default price rule, if found, or any non-default price rule and then break out of loop immediately.
	#
	#Instead, it needs to utilize current IDs of contact, account, and item and figure out which price rule is currently available to be applied.
	#
	#For example, create a function such as,
	#
	#{noformat}
	#private Id getPriceRule(Id conId, Id accId) {
	# FDService.ItemPriceRule ItemPriceRule = FDService.ItemPriceRule._getInstance_();
	#ItemPriceRule.account = accId;
	#ItemPriceRule.contact = conId;
	#ItemPriceRule.item = this.itemId;
	#ItemPriceRule.quantity = 1;
	#FDService.ItemPriceRule priceRuleObj =
	# FDService.ItemPriceService._getInstance_().getPrice(new List<FDService.ItemPriceRule>{itemPriceRule})[0];
	#
	# return priceRuleObj.priceRule.id;
	#}
	#{noformat}
	#
	#Then
	#
	#{noformat}
	#this.priceRule = this.getPriceRule(conId, accId);
	#if (this.priceRule != null) {
	#for (OrderApi __Price_Rule__ c prObj : item.OrderApi __Price_Rules__ r) {
	#if (prObj.Id == this.priceRule) {
	#this.priceRule = prObj.Id;
	# this.priceRuleObj = new PriceRule(prObj);
	# break;
	#}
	# }
	#}
	#{noformat}

	#Tests *Case Reporter* Erika Tomatore
	#
	#*Customer* Water Environment Federation
	#
	#*Reproduced by* Abdalla Harun in 20Spring.0.4
	#
	#*Reference Case#* [00024539|https://fonteva.my.salesforce.com/5004V000011RksNQAS]
	#
	#*Description:*
	#
	#* A Staff User who is adding a membership with packaged items through ROE, and whose packaged items have price rules based on Contact criteria, noticed that even though the Contact criteria are met when they add the item, the default price rule is displayed.
	#
	#*Steps to Reproduce:*
	#
	#* Make sure you have a membership item with packaged items
	#* Make sure the packaged item has a price rule which looks at criteria on the Contact record
	#* Then make sure the criteria is met on the Contact
	#* Go to ROE
	#* Select the membership
	#* View the Packaged Items
	#
	#*Actual Results:*
	#
	#Staff user is seeing the default price for the packaged item, although the price rule is being picked up when the item is added to the shopping cart
	#
	#*Expected Results:*
	#
	#When a staff user launches ROE from the Contact or Account & ROE knows ID of the SO Contact, Staff user see a relevant price rule for the packaged item. Similar to the front-end experience.
	#
	#*T3 Notes:*
	#
	#The problem arises from [https://github.com/Fonteva/RapidOrderEntry/blob/develop/src/classes/PackageItemDetailsController.cls#L88] when instantiating new instances of _PackageItem_ object.
	#
	#In _PackageItem_, [https://github.com/Fonteva/RapidOrderEntry/blob/develop/src/classes/PackageItem.cls#L51] , it then just iterates through all available price rules of current item and just assign default price rule, if found, or any non-default price rule and then break out of loop immediately.
	#
	#Instead, it needs to utilize current IDs of contact, account, and item and figure out which price rule is currently available to be applied.
	#
	#For example, create a function such as,
	#
	#{noformat}
	#private Id getPriceRule(Id conId, Id accId) {
	# FDService.ItemPriceRule ItemPriceRule = FDService.ItemPriceRule._getInstance_();
	#ItemPriceRule.account = accId;
	#ItemPriceRule.contact = conId;
	#ItemPriceRule.item = this.itemId;
	#ItemPriceRule.quantity = 1;
	#FDService.ItemPriceRule priceRuleObj =
	# FDService.ItemPriceService._getInstance_().getPrice(new List<FDService.ItemPriceRule>{itemPriceRule})[0];
	#
	# return priceRuleObj.priceRule.id;
	#}
	#{noformat}
	#
	#Then
	#
	#{noformat}
	#this.priceRule = this.getPriceRule(conId, accId);
	#if (this.priceRule != null) {
	#for (OrderApi __Price_Rule__ c prObj : item.OrderApi __Price_Rules__ r) {
	#if (prObj.Id == this.priceRule) {
	#this.priceRule = prObj.Id;
	# this.priceRuleObj = new PriceRule(prObj);
	# break;
	#}
	# }
	#}
	#{noformat}
	@REQ_PD-24358 @TEST_PD-28274 @21winter @22Winter @regression @pavan
	Scenario Outline: Test ROE is Picking Up Price Rules for Packaged Items but displaying default Price Rule.
		Given User creates a sub packaged item and configure the price rule
			| subItemName   | subItemPrice | discountPrice   |
			| <subItemName> | <itemPrice>  | <discountPrice> |
		And User creates a packaged item with sub packaged item
			| PackageItemName | packagedItemPrice |
			| <itemName>      | <itemPrice>       |
		And User will select "Coco Dulce" contact
		And User opens the Rapid Order Entry page from contact
		When User should be able to add "<itemName>" item on rapid order entry
		And User is able to expand the Item details of "<itemName>" and select the Additional Package item
		Then User verifies Additional Package item price is displayed as "<discountPrice>"

		Examples:
			| itemName                    | subItemName                     | itemPrice | discountPrice |
			| autoPackagedSubcriptionItem | autosubPackagedSubscriptionItem | 100       | $65.00        |
