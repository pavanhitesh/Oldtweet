@REQ_PD-10530
Feature: Attempt to use the same Community ID on the same Community Site

	@TEST_PD-28729 @REQ_PD-10530 @regression @21Winter @22Winter @akash
	Scenario: Test Attempt to use the same Community ID on the same Community Site
		Given User should navigate to "LTCommunitySite" Community Site
		Then User clones the community site and verifies the validation message



