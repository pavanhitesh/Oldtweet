@REQ_PD-22625
Feature: Test Monthly Proration for Calendar subscription with Grace period is not working
	@TEST_PD-28268 @22Winter @21Winter @REQ_PD-22625 @raj @regression
	Scenario: Test Test Monthly Proration for Calendar subscription with Grace period is not working
		Given User will select "David Brown" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoCalendarPlanWithBadgeWorkFlow" item on rapid order entry
		And User navigate to "apply payment" page for "AutoCalendarPlanWithBadgeWorkFlow" item from rapid order entry
		And User should be able to apply payment for "AutoCalendarPlanWithBadgeWorkFlow" item using "Credit Card" payment on apply payment page
		And User should update the term end date to the past date and renew the subscription
		And User should be able to apply payment for "AutoCalendarPlanWithBadgeWorkFlow" item using "Credit Card" payment on apply payment page
		Then User should be able to verify new term date is active and old term date is inactive
		And User verifies the schedule payments dates and amounts for "AutoCalendarPlanWithBadgeWorkFlow" renewal
