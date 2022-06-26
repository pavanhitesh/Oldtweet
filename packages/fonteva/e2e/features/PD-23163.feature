@REQ_PD-23163
Feature: Error when attempting to update an additional item when renewing a subscriprion
	#h2. Steps to Reproduce
	# * Configure a subscription item (say sub A) with a
	# ## subscription item (say sub B) as an additional item
	# ## subscription item C (say sub C) as an included item
	# * Purchase the sub A with sub B
	# * Verify the subscription record created in the backend
	# * Subscription record should have three subscription lines, one for sub A, one for sub B and one for sub C
	# * Remove the item sub C as a package item from sub A
	# * Add a new included item that is a subscription item (say D)
	# * Add a new additional item which is a subscription item (say Sub E)
	# * Navigate to the portal subscriptions page
	# * Select to renew Subs A
	# * Verify the Additional assignments section
	# * Sub B should be highlighted in the additional items section
	# * Sub B should be added as a SOL, and appears in the Order Summary
	# * Sub C should *NOT* be added as a SOL and does *NOT* appear in the Order Summary
	# * On the Shopping cart click Edit next to the Sub A
	# * Click on Change next to Additional Items section
	# * Remove Sub B
	# * Add Sub E to the cart
	# * Click Continue
	#
	#h2. Expected Result
	#
	#User should be able to update the additional item
	#h2. Actual Result
	#
	#Error appears on the page
	#
	#See screenshot
	#
	#
	#
	#Subscription:
	#
	#[https://bugbashes22nu.my.salesforce.com/a1X6g0000007ypj]
	#
	#
	#
	#Cred:
	#[kate2019r2bugs@mailinator.com|mailto:kate2019r2bugs@mailinator.com]
	#Fonteva703@

	#Tests h2. Steps to Reproduce
	# * Configure a subscription item (say sub A) with a
	# ## subscription item (say sub B) as an additional item
	# ## subscription item C (say sub C) as an included item
	# * Purchase the sub A with sub B
	# * Verify the subscription record created in the backend
	# * Subscription record should have three subscription lines, one for sub A, one for sub B and one for sub C
	# * Remove the item sub C as a package item from sub A
	# * Add a new included item that is a subscription item (say D)
	# * Add a new additional item which is a subscription item (say Sub E)
	# * Navigate to the portal subscriptions page
	# * Select to renew Subs A
	# * Verify the Additional assignments section
	# * Sub B should be highlighted in the additional items section
	# * Sub B should be added as a SOL, and appears in the Order Summary
	# * Sub C should *NOT* be added as a SOL and does *NOT* appear in the Order Summary
	# * On the Shopping cart click Edit next to the Sub A
	# * Click on Change next to Additional Items section
	# * Remove Sub B
	# * Add Sub E to the cart
	# * Click Continue
	#
	#h2. Expected Result
	#
	#User should be able to update the additional item
	#h2. Actual Result
	#
	#Error appears on the page
	#
	#See screenshot
	#
	#
	#
	#Subscription:
	#
	#[https://bugbashes22nu.my.salesforce.com/a1X6g0000007ypj]
	#
	#
	#
	#Cred:
	#[kate2019r2bugs@mailinator.com|mailto:kate2019r2bugs@mailinator.com]
	#Fonteva703@
	@TEST_PD-28907 @REQ_PD-23163 @regression @21Winter @22Winter @akash
	Scenario: Test Error when attempting to update an additional item when renewing a subscription
		Given User adds "IncludedItem1" item as included item to "ParentSubscriptionItem" item
		When User will select "Daniela Brown" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "ParentSubscriptionItem" item on rapid order entry
		And User is able to expand the Item details of "ParentSubscriptionItem" and select the Additional Package item
		And User navigate to "apply payment" page for "ParentSubscriptionItem" item from rapid order entry
		And User should be able to apply payment for "ParentSubscriptionItem" item using "Credit Card" payment on apply payment page
		Then User verifies the "3" subscription lines is created after "payment"
		And User removes included item and adds "IncludedItem2" item and "AdditionalItem2" item on backend
		And User navigate to community Portal page with "danielabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User will select the "Subscriptions" page in LT Portal
		And User should be able to click on "renew" subscription purchased using "backend"
		And User should be able to select "ParentSubscriptionItem" renew item
		And User removes "AdditionalItem1" item and select "AdditionalItem2" item
		And User navigate to checkout from shopping cart page
		And User successfully pays for the order using credit card
		And User should see the "invoice" created confirmation message
		Then User verifies the "6" subscription lines is created after "renew"

