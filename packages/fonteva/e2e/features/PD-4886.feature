@REQ_PD-4886
Feature: Deferred revenue transactions for Term Rule = Daily should be adjusted to match original amount
	@TEST_PD-28908 @22Winter @21Winter @REQ_PD-4886 @raj @regression
	Scenario: Test Deferred revenue transactions for Term Rule = Daily should be adjusted to match original amount
		Given User will select "David Brown" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "Auto SubItem Deferred Revenue" item with "AutoCalenderDailyProrationPlan" plan on rapid order entry
		When User navigate to "apply payment" page for "Auto SubItem Deferred Revenue" item from rapid order entry
		And User should be able to apply payment for "Auto SubItem Deferred Revenue" item using "Credit Card" payment on apply payment page
		Then User verifies the deferred transactions should equal the prorated price
