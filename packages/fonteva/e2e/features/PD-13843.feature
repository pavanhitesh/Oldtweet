@REQ_PD-13843
Feature: When Restrict Assignment Visibility = True, we are still able to see other contacts and able to assign membership to other contacts in the account.
	@REQ_PD-13843 @TEST_PD-27604 @regression @21Winter @22Winter @raj
	Scenario: Test When Restrict Assignment Visibility = True, we are still able to see other contacts and able to assign membership to other contacts in the account.
		Given User can update the assignment visibility to "true" for "Foxworth Household" account
		When User navigate to community Portal page with "evafoxworth@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User should be able to select "AutoCalenderPlan" item with quantity "1" on store
		And User should not see other contacts from account on assign members page
