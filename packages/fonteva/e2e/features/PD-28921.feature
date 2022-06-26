@REQ_PD-28921
Feature: Quantity restriction for Subscriptions

	@TEST_PD-28923 @REQ_PD-28921 @regression @21Winter @22Winter @akash
	Scenario: Test Quantity restriction for Subscriptions
		Given User navigate to community Portal page with "danielabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		When User selects event "AutoEvent1" and event type "MultiTicket" on LT portal
		And User register for "PITicket2" ticket with 1 quantity and navigate to "session" page as "authenticated user"
		And User selects "NA" sessions on agenda page and navigate to "packageItems" page
		Then User add "AutoCalenderSubscription" package item and verifies quantity restriction is not displayed



