@REQ_PD-23215
Feature: Grace Period End Date field is not updated on subscription and term
	#h2. Steps to Reproduce
	# * Create a subscription item and Add a subscription plan with grace period
	# * Purchase this subscription on FE or BE
	# * Check the grace period end date
	#
	#h2. Expected Result
	#
	#Grace period end date should be displayed
	#h2. Actual Result
	#
	#Field is blank (when you edit the subscription and save, the field is updated but the field on term is still blank)

	#Tests h2. Steps to Reproduce
	# * Create a subscription item and Add a subscription plan with grace period
	# * Purchase this subscription on FE or BE
	# * Check the grace period end date
	#
	#h2. Expected Result
	#
	#Grace period end date should be displayed
	#h2. Actual Result
	#
	#Field is blank (when you edit the subscription and save, the field is updated but the field on term is still blank)
	@TEST_PD-28357 @REQ_PD-23215 @regression @21Winter @22Winter @akash
	Scenario: Test Grace Period End Date field is not updated on subscription and term (authenticated user)
		Given User navigate to community Portal page with "danielabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User should be able to select "AutoCalenderGracePeriodPlan" item with quantity "1" on store
		And User select assign members for subscription
			| name          | role      |
			| Daniela Brown | Admin     |
			| David Brown   | Non Admin |
		And User should click on the checkout button
		And User successfully pays for the order using credit card
		And User should see the "invoice" created confirmation message
		Then User verifies salesOrder, salesOrderLine, receipt and epayment total for "portal" checkout
		And User verifies term start date, term end date and grace period end date on term and subscription

	@TEST_PD-28360 @REQ_PD-23215 @regression @21Winter @22Winter @akash
	Scenario: Test Grace Period End Date field is not updated on subscription and term (guest user)
		Given User navigate to community Portal page
		And User should be able to select "AutoCalenderGracePeriodPlan" item with quantity "1" on store
		And User should click on the checkout button
		When User select Continue as a Guest option
		And User fills in First, Last Name and Email
		And User navigates to checkout page as guest
		And User successfully pays for the order using credit card
		And User should see the "invoice" created confirmation message
		Then User verifies salesOrder, salesOrderLine, receipt and epayment total for "portal" checkout
		And User verifies term start date, term end date and grace period end date on term and subscription

	@TEST_PD-28361 @REQ_PD-23215 @regression @21Winter @22Winter @akash
	Scenario: Test Grace Period End Date field is not updated on subscription and term (backend user)
		Given User will select "Daniela Brown" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoCalenderGracePeriodPlan" item on rapid order entry
		And User navigate to "apply payment" page for "AutoCalenderGracePeriodPlan" item from rapid order entry
		Then User should be able to apply payment for "AutoCalenderGracePeriodPlan" item using "Credit Card" payment on apply payment page
		And User verifies salesOrder, salesOrderLine, receipt and epayment total for "backend" checkout
		And User verifies term start date, term end date and grace period end date on term and subscription

