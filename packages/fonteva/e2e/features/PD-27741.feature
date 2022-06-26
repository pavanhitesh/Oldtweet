@REQ_PD-27741
Feature: Apply Discount Code button Greyed Out
	#*Case Reporter* Netsanet Tefera
	#
	#*Customer* ZERO TO THREE: National Center for Infants, Toddlers and Families
	#
	#*Reproduced by* Abdalla Harun in 21Winter.0.0
	#
	#*Reference Case#* [00029645|https://fonteva.my.salesforce.com/5004V000014lRWZQA2]
	#
	#*Description:*
	#
	#It is difficult for end-users to apply source code. You have to enter the source code and then click out of the box and only then does the Apply button become available.
	#
	#*Steps to Reproduce:*
	#
	## Create a Source Code or use an existing one
	## Create a community event/ or an item
	## Add a price rule for the above item with the source code created above
	## Login to the portal or view the store as a guest user
	## Add the item to the cart and continue to checkout page
	## On the checkout page enter the above source code and verify the Apply button
	## Notice the 'Apply' button is greyed out
	#
	#*Actual Results:*
	#
	#The 'Apply' button is greyed out. See attached video.
	#
	#*NOTE - the button only becomes available after clicking somewhere out of the box. it keeps greyed out if we do not click somewhere else*
	#
	#*Expected Results:*
	#
	#The 'Apply' button should be highlighted and available as soon as the user starts entering some value into the field
	#
	#*PM Note*
	#
	#The best experience would be to remove the disabled attribute as soon as the input is 'dirty' or clicked on
	#
	#Test with Logged in guest user. Only for store, NOT for event checkout.
	#
	#*Business Justification:*
	#
	#It is difficult for end-users to apply source code. You have to enter the source code and then click out of the box and only then does the Apply button become available.
	#
	#*T3 Notes:*
	#It seems the product (Framework:InputFields) functionality in component "OrderSummary" (LTE).
	#
	#In this component there is a framework:button is using for apply the discount code, by default button in disable mode.
	#[{color:#1155cc}+https://github.com/Fonteva/LightningLens/blob/develop/community/main/default/aura/OrderSummary/OrderSummary.cmp#L3+{color}|https://github.com/Fonteva/LightningLens/blob/develop/community/main/default/aura/OrderSummary/OrderSummary.cmp#L3]
	#{color:#1155cc}+9+{color}
	#
	#++State of Apply button is changed by function 'handleFieldChangeEvent' of OrderSummaryController.js which is called when we click outside of the field.+[{color:#1155cc}+https://github.com/Fonteva/LightningLens/blob/21Winter/community/main/default/aura/OrderSummary/OrderSummaryController.js+{color}|https://github.com/Fonteva/LightningLens/blob/21Winter/community/main/default/aura/OrderSummary/OrderSummaryController.js]{color:#1155cc}#L5{color}
	#+

	#Tests *Case Reporter* Netsanet Tefera
	#
	#*Customer* ZERO TO THREE: National Center for Infants, Toddlers and Families
	#
	#*Reproduced by* Abdalla Harun in 21Winter.0.0
	#
	#*Reference Case#* [00029645|https://fonteva.my.salesforce.com/5004V000014lRWZQA2]
	#
	#*Description:*
	#
	#It is difficult for end-users to apply source code. You have to enter the source code and then click out of the box and only then does the Apply button become available.
	#
	#*Steps to Reproduce:*
	#
	## Create a Source Code or use an existing one
	## Create a community event/ or an item
	## Add a price rule for the above item with the source code created above
	## Login to the portal or view the store as a guest user
	## Add the item to the cart and continue to checkout page
	## On the checkout page enter the above source code and verify the Apply button
	## Notice the 'Apply' button is greyed out
	#
	#*Actual Results:*
	#
	#The 'Apply' button is greyed out. See attached video.
	#
	#*NOTE - the button only becomes available after clicking somewhere out of the box. it keeps greyed out if we do not click somewhere else*
	#
	#*Expected Results:*
	#
	#The 'Apply' button should be highlighted and available as soon as the user starts entering some value into the field
	#
	#*PM Note*
	#
	#The best experience would be to remove the disabled attribute as soon as the input is 'dirty' or clicked on
	#
	#Test with Logged in guest user. Only for store, NOT for event checkout.
	#
	#*Business Justification:*
	#
	#It is difficult for end-users to apply source code. You have to enter the source code and then click out of the box and only then does the Apply button become available.
	#
	#*T3 Notes:*
	#It seems the product (Framework:InputFields) functionality in component "OrderSummary" (LTE).
	#
	#In this component there is a framework:button is using for apply the discount code, by default button in disable mode.
	#[{color:#1155cc}+https://github.com/Fonteva/LightningLens/blob/develop/community/main/default/aura/OrderSummary/OrderSummary.cmp#L3+{color}|https://github.com/Fonteva/LightningLens/blob/develop/community/main/default/aura/OrderSummary/OrderSummary.cmp#L3]
	#{color:#1155cc}+9+{color}
	#
	#++State of Apply button is changed by function 'handleFieldChangeEvent' of OrderSummaryController.js which is called when we click outside of the field.+[{color:#1155cc}+https://github.com/Fonteva/LightningLens/blob/21Winter/community/main/default/aura/OrderSummary/OrderSummaryController.js+{color}|https://github.com/Fonteva/LightningLens/blob/21Winter/community/main/default/aura/OrderSummary/OrderSummaryController.js]{color:#1155cc}#L5{color}
	#+
	@REQ_PD-27741 @TEST_PD-28207 @22Winter @21winter @regression @pavan
	Scenario Outline: Scenario Outline name: Test Apply Discount Code button is not Greyed Out in portal
		Given User creates a item and adds to catalog
			| itemName              | itemPrice | catalog     |
			| priceRuleDiscountCode | 40        | Merchandise |
		And User configures source code price rule
			| ruleName      | discountprice | sourceCode   |
			| discountPrice | 20            | discountCode |
		When User navigate to community Portal page with "<userName>" user and password "<password>" as "<userType>" user
		And User should be able to select "priceRuleDiscountCode" item with quantity "1" on store
		And User should click on the checkout button
		Then User validates the apply button is clickable after applying discount code "discountCode"

		Examples:
			| userName              | password   | userType      |
			| cdulce@mailinator.com | 705Fonteva | authenticated |
			|                       |            | guest         |



