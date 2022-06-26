@REQ_PD-8944
Feature: Create a Type of External URL with an External URL value of null

	@TEST_PD-28787 @REQ_PD-8944 @regression @21Winter @22Winter @akash
	Scenario: Test Create a Type of External URL with an External URL value of null
		Given User should navigate to "LTCommunitySite" Community Site
		And User creates new menu item with external url as "null" and verifies the validation message


