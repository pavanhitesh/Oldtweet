@REQ_PD-9864
Feature: (UI) 09. Renewal Flow
	@TEST_PD-28951 @regression @21Winter @22Winter @REQ_PD-9864 @raj
	Scenario: Test (UI) 09. Renewal Flow
		Given User will select "Rose Brixton" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoAssignmentMembership" item on rapid order entry
		And User navigate to "apply payment" page for "AutoAssignmentMembership" item from rapid order entry
		Then User should be able to apply payment for "AutoAssignmentMembership" item using "Credit Card" payment on apply payment page
		And User navigate to community Portal page with "rosebrixton@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User will select the "Subscriptions" page in LT Portal
		Then User should be able to click on "renew" subscription purchased using "backend"
		And User should be able to enter the renewal form response
		And User should be able to select "AutoAssignmentMembership" renew item
		And User should be able to select additional items
			| name                |
			| AutoChildMembership |
		And User select assign members for subscription
			| name         | role      |
			| Rose Brixton | Admin     |
			| Rose Grant   | Non Admin |
			| Diana Grant  | Admin     |
		And User should be able to enter the form response and navigate to shopping cart page
		And User updates the form responses, assign members and additional item "AutoMembershipChild" for "AutoAssignmentMembership" item
			| name        |
			| Diana Grant |
			| Devon Howe  |
		And User navigate to checkout from shopping cart page
		And User successfully pays for the order using credit card
		And User should see the "invoice" created confirmation message
		Then User verifies the renewal form, item form responses and the assignments selected on the backend
			| name         |
			| Rose Brixton |
			| Rose Grant   |
			| Devon Howe   |
