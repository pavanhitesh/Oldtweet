@REQ_PD-27993
Feature: The "Primary Attendee's Ticket" modal does not display available Tickets during registration when Ticket Types are Grouped in Manage Inventory
	@TEST_PD-29213 @REQ_PD-27993 @regression @21Winter @22Winter @raj
	Scenario: Test The "Primary Attendee's Ticket" modal does not display available Tickets during registration when Ticket Types are Grouped in Manage Inventory
		Given User should be able to create an attendee of "Invited" status for "Auto Ticket Block Event" event with "David Brown" contact
		And User should be able to navigate to "community" event invitation url for "Auto Ticket Block Event" event
		Then User selects 1 ticket of each "Ticket1" "Ticket2" and verify the tickets are displayed on invitee modal
