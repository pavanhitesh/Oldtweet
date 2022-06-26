@REQ_PD-23240
Feature: Incorrect installment amount when purchasing a subscription item in the portal
	@TEST_PD-27853 @22Winter @21Winter @REQ_PD-23240 @raj @regression
	Scenario: Test Incorrect installment amount when purchasing a subscription item in the portal
		Given User navigate to community Portal page with "davidbrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User should be able to select "Auto Item CalendarScheduleTypeInvoice" item with quantity "1" on store
		And User select assign members for subscription
			| name          | role      |
			| David Brown   | Admin     |
			| Daniela Brown | Non Admin |
		And User should click on the checkout button
		And User successfully pays for the order using credit card
		And User should see the "invoice" created confirmation message
		Then User should be able to see the prorated price and assigments for the subscription "Auto Item CalendarScheduleTypeInvoice" for "portal" checkout
			| name          | role      | isActive | isPrimary |
			| David Brown   | Admin     | true     | true      |
			| Daniela Brown | Non Admin | true     | false     |

	@TEST_PD-28085 @22Winter @21Winter @REQ_PD-23240 @raj @regression
	Scenario: Test Incorrect installment amount when purchasing a subscription item in the portal (Guest user)
		Given User navigate to community Portal page
		And User should be able to select "Auto Item CalendarScheduleTypeInvoice" item with quantity "1" on store
		And User should click on the checkout button
		When User select Continue as a Guest option
		And User fills in First, Last Name and Email
		And User navigates to checkout page as guest
		And User successfully pays for the order using credit card
		And User should see the "invoice" created confirmation message
		Then User should be able to see the prorated price and assigments for the subscription "Auto Item CalendarScheduleTypeInvoice" for "portal" checkout
			| name  | role  | isActive | isPrimary |
			| Guest | Admin | true     | true      |

	@TEST_PD-28137 @22Winter @21Winter @REQ_PD-23240 @raj @regression
	Scenario: Test Incorrect installment amount when purchasing a subscription item (Backend)
		Given User will select "David Brown" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "Auto Item CalendarScheduleTypeInvoice" item on rapid order entry
		And User navigate to "apply payment" page for "Auto Item CalendarScheduleTypeInvoice" item from rapid order entry
		Then User should be able to apply payment for "Auto Item CalendarScheduleTypeInvoice" item using "Credit Card" payment on apply payment page
		And User should be able to see the prorated price and assigments for the subscription "Auto Item CalendarScheduleTypeInvoice" for "backend" checkout
			| name        | role  | isActive | isPrimary |
			| David Brown | Admin | true     | true      |
