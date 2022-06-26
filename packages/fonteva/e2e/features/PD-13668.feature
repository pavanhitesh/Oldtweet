@REQ_PD-13668
Feature: Terms not getting deactivated while subs are. New terms on renewals not being made active.
	@REQ_PD-13668 @TEST_PD-27639 @regression @21Winter @22Winter @raj
	Scenario: Test Terms not getting deactivated while subs are. New terms on renewals not being made active.
		Given User will select "David Brown" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoTermedInvoicePlan" item on rapid order entry
		And User navigate to "apply payment" page for "AutoTermedInvoicePlan" item from rapid order entry
		Then User should be able to apply payment for "AutoTermedInvoicePlan" item using "Credit Card" payment on apply payment page
		And User expires the subscription by updating date and verifies term status
		And User navigate to community Portal page with "davidbrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User will select the "Subscriptions" page in LT Portal
		Then User should be able to renew the "expired" subscription "AutoTermedInvoicePlan"
		And User verifies the subscription renewal term is active for expired subscription
