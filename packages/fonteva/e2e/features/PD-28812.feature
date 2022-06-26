@REQ_PD-8947
Feature: Create a page where Publicly Available = FALSE

	@TEST_PD-28812 @REQ_PD-8947 @regression @22Winter @21Winter @akash
	Scenario: Test Create a page where Publicly Available = FALSE
		Given User creates menuItem for "LTCommunitySite" Community Site
		And User updates menuItem publicly available field to false
		And User navigate to community Portal page
		Then User verifies menuItem is not displayed for guest user
