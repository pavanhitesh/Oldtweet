@REQ_PD-7362
Feature: Proration is calculated incorrectly when purchasing subscription on the last day of the month
	@TEST_PD-28518 @22Winter @21Winter @REQ_PD-7362 @raj @regression
	Scenario: Test Proration is calculated incorrectly when purchasing subscription on the last day of the month
		Given User will select "David Brown" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoCalenderSubscription2" item on rapid order entry
		When User updates the subscription date and activation date to last day of the current month on sales order line
		And User navigate to "apply payment" page for "AutoCalenderSubscription2" item from rapid order entry
		And User should be able to apply payment for "AutoCalenderSubscription2" item using "Credit Card" payment on apply payment page
		Then User verifies the number of schedule payments created and price of first installment
