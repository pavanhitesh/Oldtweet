@REQ_PD-10581
Feature: Form response is not being deleted when Item is changed during renewal flow

	@TEST_PD-28405 @regression @21Winter @22Winter @REQ_PD-10581 @raj
	Scenario: Test Form response is not being deleted when Item is changed during renewal flow
		Given User will select "David Brown" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoPlanWithForm" item on rapid order entry
		And User navigate to "apply payment" page for "AutoPlanWithForm" item from rapid order entry
		Then User should be able to apply payment for "AutoPlanWithForm" item using "Credit Card" payment on apply payment page
		And User navigate to community Portal page with "davidbrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User will select the "Subscriptions" page in LT Portal
		Then User should be able to click on "renew" subscription purchased using "backend"
		And User should be able to select "AutoPlanWithForm" renew item
		And User select assign members for subscription
			| name        | role  |
			| David Brown | Admin |
		Then User enters the form response and navigate to shopping cart page
		And User updates the renewal item "AutoPlanWithAssignments" and verifies the form response is deleted

