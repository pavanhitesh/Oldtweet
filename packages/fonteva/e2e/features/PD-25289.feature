@REQ_PD-25289
Feature: Extra Transaction Lines Created for 1 Year Membership Purchase
	@TEST_PD-28459 @22Winter @21Winter @REQ_PD-25289 @raj @regression
	Scenario: Test Extra Transaction Lines Created for 1 Year Membership Purchase
		Given User navigate to community Portal page with "davidbrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User should be able to select "Auto SubItem Deferred Revenue" item with quantity "1" on store
		And User select assign members for subscription
			| name          | role      |
			| David Brown   | Admin     |
		And User should click on the checkout button
		And User successfully pays for the order using credit card
		And User should see the "receipt" created confirmation message
		Then User verifies the revenue recognition type transactions created
