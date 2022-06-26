@REQ_PD-8950
Feature: Add, Edit and Remove a Menu label

	@TEST_PD-29068 @REQ_PD-8950 @regression @22Winter @21Winter @anitha
	Scenario: Add, Edit and Remove a Menu label
		Given User creates menuItem for "LTCommunitySite" Community Site
		And User navigate to community Portal page with "ettabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User verifies created menuItem is displayed
		And User updates menuItem name field
		And User verifies updated menuItem name is displayed
		Then User deletes the menuItem and verifies the menuItem is deleted


