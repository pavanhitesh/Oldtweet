@REQ_PD-13899
Feature: Next Scheduled Renewal Date field on Subscription will never get updated after the first renewal, causing Scheduled Date of Scheduled Payment is a date in the past
	@TEST_PD-28837 @22Winter @21Winter @REQ_PD-13899 @raj @regression
	Scenario: Test Next Scheduled Renewal Date field on Subscription will never get updated after the first renewal, causing Scheduled Date of Scheduled Payment is a date in the past
		Given User will select "David Brown" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoTermedInvoicePlan" item on rapid order entry
		And User navigate to "apply payment" page for "AutoTermedInvoicePlan" item from rapid order entry
		And User should be able to apply payment for "AutoTermedInvoicePlan" item using "Credit Card" payment on apply payment page
		When User should renew the subscription to "AutoTermedInvoicePlan" item on backend
		And User should be able to apply payment for "AutoTermedInvoicePlan" item using "Credit Card" payment on apply payment page
		Then User verifies the next term renewed date on the previous term record
		When User should renew the subscription to "AutoTermedInvoicePlan" item on backend
		And User should be able to apply payment for "AutoTermedInvoicePlan" item using "Credit Card" payment on apply payment page
		Then User verifies the next term renewed date on the previous term record
