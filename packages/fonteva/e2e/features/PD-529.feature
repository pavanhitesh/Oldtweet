@REQ_PD-529
Feature: Renewal Paths for Subscriptions
	@TEST_PD-27680 @REQ_PD-529 @regression @21Winter @22Winter @raj
	Scenario: Test Renew Into (Renewal Workflow)
		Given User will select "David Brown" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoTermedFreeSubItem" item on rapid order entry
		And User navigate to "apply payment" page for "AutoTermedFreeSubItem" item from rapid order entry
		Then User should be able to apply payment for "AutoTermedFreeSubItem" item using "Credit Card" payment on apply payment page
		And User navigate to community Portal page with "davidbrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User will select the "Subscriptions" page in LT Portal
		Then User should be able to click on "renew" subscription purchased using "backend"
		And User should be able to select "AutoTermedInvoicePlan" renew item
		And User select assign members for subscription
			| name          | role  |
			| Daniela Brown | Admin |
		And User navigate to checkout from shopping cart page
		And User successfully pays for the order using credit card
		And User should see the "invoice" created confirmation message
		And User should be able to verify the "2" assignments created, term start and end dates on the backend
