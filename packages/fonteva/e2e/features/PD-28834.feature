@REQ_PD-8962
Feature: Apply Access Permissions to a Menu Item - and attempt to view as an Unauthenticated User

	@TEST_PD-28834 @REQ_PD-8962 @regression @22Winter @21Winter @akash
	Scenario: Test Apply Access Permissions to a Menu Item - and attempt to view as an Unauthenticated User
		Given User creates menuItem for "LTCommunitySite" Community Site
		And User updates menuItem publicly available and Enable Access Permissions field to true
		And User navigate to community Portal page
		Then User verifies menuItem is not displayed for guest user


