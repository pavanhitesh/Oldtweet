@REQ_PD-22510
Feature: Price Display for Price Rules inconsistent in ROE and Payment Page (In Cart Pricing)
	#*Reproduced by* Kapil Patel in 2019 R1 1.0.16
	#
	#*Reference Case#*[00021175|https://fonteva.my.salesforce.com/5003A00000zbwkEQAQ]
	#
	#*Description:*
	#
	#IF the Contact would qualify for a Badge-related Price Rule with the Badge assigned from a Fonteva Badge Workflow.
	#
	#1. The first ROE page does NOT reference the Price Rule
	#
	#2. There are two different Prices displayed during  back-office checkout
	#
	#
	#
	#*PM NOTE:*
	#
	#* The issue is reported against 19-R1 and the old VF payment page.
	#* We will validate this issue against the New apply Payment Page. (21Winter).
	#* *_Seems like in cart pricing is not working in ROE_*, we recently fixed for frontend store pages and checkout
	#* What is in cart pricing?
	#** The customer does not have the *badge yet*, but the item customer is purchasing will give them a badge.
	#** The system recognizes the item and the related badge workflow and returns the price rule which is matching with the Badge.
	#* In the grooming meeting, we were not able to reproduce this issue, but we still want an engineer to attempt to repro and understand how/where the code works for in-cart pricing.
	#** My guess is SO objected has some kind of a JSON field that gets updated when you add your item to your cart.
	#** And this JSON is likely to be used to call PriceRule Service
	#** to remember badge record is not inserted yet, so we cannot return it from the database.
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#* Configure a membership Item with a Badge workflow for "Badge A"
	#* Create a Price Rule with Subscription Plan && Badge Type "A" criteria
	#* {color:#00b8d9}*See the video about how to configure*{color}
	#* Navigate to a Contact record (with No "Badge A")
	#* Create an ROE order
	#* Add the Membership Item with the Subscription Plan referenced in the Price Rule
	#* *ISSUE 1*: The Price Rule Price is not visible on the first page (unlike other Price Rules)
	#* Click Process Payment
	#* *ISSUE 2:* Multiple Prices Display: The correct price and the default price are both visible (see attached images)
	#
	#
	#
	#*Actual Results:*
	#
	#ISSUE 1: The Price Rule Price is not visible on the first page - ROE PAGE (unlike other Price Rules)
	#
	#ERROR 2: Multiple Prices Display on final page APPLY PAYMENT PAGE: The correct price and the default price are both visible (see attached images)
	#
	#*Expected Results:*
	#
	#The expected behavior is the Subscription Plan + Badge Price rule is applied (even though the Contact does not have a Badge yet) and the discounted price is displayed without the default price

	#Tests *Reproduced by* Kapil Patel in 2019 R1 1.0.16
	#
	#*Reference Case#*[00021175|https://fonteva.my.salesforce.com/5003A00000zbwkEQAQ]
	#
	#*Description:*
	#
	#IF the Contact would qualify for a Badge-related Price Rule with the Badge assigned from a Fonteva Badge Workflow.
	#
	#1. The first ROE page does NOT reference the Price Rule
	#
	#2. There are two different Prices displayed during  back-office checkout
	#
	#
	#
	#*PM NOTE:*
	#
	#* The issue is reported against 19-R1 and the old VF payment page.
	#* We will validate this issue against the New apply Payment Page. (21Winter).
	#* *_Seems like in cart pricing is not working in ROE_*, we recently fixed for frontend store pages and checkout
	#* What is in cart pricing?
	#** The customer does not have the *badge yet*, but the item customer is purchasing will give them a badge.
	#** The system recognizes the item and the related badge workflow and returns the price rule which is matching with the Badge.
	#* In the grooming meeting, we were not able to reproduce this issue, but we still want an engineer to attempt to repro and understand how/where the code works for in-cart pricing.
	#** My guess is SO objected has some kind of a JSON field that gets updated when you add your item to your cart.
	#** And this JSON is likely to be used to call PriceRule Service
	#** to remember badge record is not inserted yet, so we cannot return it from the database.
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#* Configure a membership Item with a Badge workflow for "Badge A"
	#* Create a Price Rule with Subscription Plan && Badge Type "A" criteria
	#* {color:#00b8d9}*See the video about how to configure*{color}
	#* Navigate to a Contact record (with No "Badge A")
	#* Create an ROE order
	#* Add the Membership Item with the Subscription Plan referenced in the Price Rule
	#* *ISSUE 1*: The Price Rule Price is not visible on the first page (unlike other Price Rules)
	#* Click Process Payment
	#* *ISSUE 2:* Multiple Prices Display: The correct price and the default price are both visible (see attached images)
	#
	#
	#
	#*Actual Results:*
	#
	#ISSUE 1: The Price Rule Price is not visible on the first page - ROE PAGE (unlike other Price Rules)
	#
	#ERROR 2: Multiple Prices Display on final page APPLY PAYMENT PAGE: The correct price and the default price are both visible (see attached images)
	#
	#*Expected Results:*
	#
	#The expected behavior is the Subscription Plan + Badge Price rule is applied (even though the Contact does not have a Badge yet) and the discounted price is displayed without the default price
	@TEST_PD-28822 @REQ_PD-22510 @21Winter @22Winter @regression @pavan
	Scenario Outline: Test Price Display for Price Rules inconsistent in ROE and Payment Page (In Cart Pricing) when item "<itemA>" added first
		Given User will select "Coco Dulce" contact
		And User opens the Rapid Order Entry page from contact
		When User should be able to add "<ItemA>" item with "lifeTimePlan" plan on rapid order entry
		And User should be able to add "<ItemB>" item with "lifeTimePlan" plan on rapid order entry
		Then User verfies the "discountPricewithBadge" Price Rule is applied to item "itemMembershipwithPriceRuleBadge"
		And User selects "Invoice" as payment method and verifies Badge Price Rule is applied to item "itemMembershipwithPriceRuleBadge" in payment page
		And User navigate back to ROE page and delete the item "itemMembershipwithBadgeWorkflow"
		Then User verfies the "DEFAULT" Price Rule is applied to item "itemMembershipwithPriceRuleBadge"

		Examples:
			| ItemA                            | ItemB                            |
			| itemMembershipwithBadgeWorkflow  | itemMembershipwithPriceRuleBadge |
			| itemMembershipwithPriceRuleBadge | itemMembershipwithBadgeWorkflow  |


