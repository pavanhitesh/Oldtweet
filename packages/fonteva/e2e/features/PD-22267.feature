@REQ_PD-22267
Feature: RESEARCH: The Renewed Terms Start./End are not being generating correctly and honoring the dates from the sales order line.
	@TEST_PD-28793 @22Winter @21Winter @REQ_PD-22267 @raj @regression
	Scenario: Test RESEARCH: The Renewed Terms Start./End are not being generating correctly and honoring the dates from the sales order line.
		Given User will select "David Brown" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoCalenderSubscription2" item on rapid order entry
		When User updates the subscription start date and end date to "2018" year on "original" sales order line
		And User navigate to "apply payment" page for "AutoCalenderSubscription2" item from rapid order entry
		And User should be able to apply payment for "AutoCalenderSubscription2" item using "Credit Card" payment on apply payment page
		Then User verifies the updated term start and end dates
		And User should renew the subscription to "AutoCalenderSubscription" item on backend
		When User updates the subscription start date and end date to "2019" year on "renewal" sales order line
		And User should be able to apply payment for "AutoCalenderSubscription" item using "Credit Card" payment on apply payment page
		Then User verifies the updated term start and end dates
