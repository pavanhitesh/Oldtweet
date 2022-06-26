@REQ_PD-29506
Feature: Default pricing is applied if you apply a discount code first then login for checkout
	#h2. Details
	#- If the End User creates the Sales Order from the Store, applies a discount code to verify pricing, and then decides to login, the default price is reapplied to the item
	#- The End User would have to remove and reapply the Discount Code after logging in to use the discount
	#
	#GCO Org ID (21Winter): 
	#00D5Y000002Vp4H
	#h2. Steps to Reproduce
	#Screen recording:
	#https://www.screencast.com/t/RryBGbnJ3i
	#
	#1) Create an Item and create a price rule for this item that uses a Source Code
	#2) Navigate to the Store as a Guest User
	#3) Add an Item to the Cart and proceed to checkout
	#4) Apply the Discount Code in the Order Summary component
	#5) Select Login and type in the credential (Bob Kelley: Username:bkelley@mailinator.com/Password:Start123!)
	#6) Review the Order Summary component
	#h2. Expected Results
	#The discounted price is applied after inputting the source code once.
	#h2. Actual Results
	#The default price is applied after inputting the source code once.
	#h2. Business Justification
	#The customer reports this is causing them to issue refunds for the difference.

	#Tests h2. Details
	#- If the End User creates the Sales Order from the Store, applies a discount code to verify pricing, and then decides to login, the default price is reapplied to the item
	#- The End User would have to remove and reapply the Discount Code after logging in to use the discount
	#
	#GCO Org ID (21Winter): 
	#00D5Y000002Vp4H
	#h2. Steps to Reproduce
	#Screen recording:
	#https://www.screencast.com/t/RryBGbnJ3i
	#
	#1) Create an Item and create a price rule for this item that uses a Source Code
	#2) Navigate to the Store as a Guest User
	#3) Add an Item to the Cart and proceed to checkout
	#4) Apply the Discount Code in the Order Summary component
	#5) Select Login and type in the credential (Bob Kelley: Username:bkelley@mailinator.com/Password:Start123!)
	#6) Review the Order Summary component
	#h2. Expected Results
	#The discounted price is applied after inputting the source code once.
	#h2. Actual Results
	#The default price is applied after inputting the source code once.
	#h2. Business Justification
	#The customer reports this is causing them to issue refunds for the difference.
	@TEST_PD-29542 @REQ_PD-29506 @21Winter @22Winter @regression @Pavan
	Scenario: Test Default pricing is applied if you apply a discount code first then login for checkout
		Given User navigate to community Portal page 
		And User should be able to select "AutoItem2" item with quantity "1" on store
		And User should click on the checkout button
		When User enter the discount code "AutoDiscount" in the order summary page
		Then User verfies the price rule "discountAutoItem2" discount price is applied for the item "AutoItem2"
		And User navigate to community Portal page with "cdulce@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User should click on the checkout button
		And User verfies the price rule "discountAutoItem2" discount price is applied for the item "AutoItem2"



