@REQ_PD-27872
Feature: In-cart pricing not working when badge given with ticket type should be applied to price rule on schedule item
	#h2. Steps to Reproduce
	#
	#1.Set up an event with default config for contact/attendee, non-free, multi-ticket
	#
	#2.For one of the ticket types, click manage badges and select a badge
	#
	#3.Create a schedule item and add a price rule with the criteria of the badge that was given in step 2
	#
	#4.Set status to Active and open the event in the front end
	#
	#5.Add the ticket type that assigns the badgeOn the agenda page, add the schedule item that uses the badge-based price rule
	#
	#h2. Expected Results
	#
	#Badge-based price on schedule item IS applied on checkout page
	#
	#h2. Actual Results
	#
	#Badge-based price on schedule item IS NOT applied on checkout page
	#
	#h2. Business Justification
	#
	#Event goes live week of 8/16
	#
	#
	#
	#*Additional Steps from PM TEAM*
	#
	#* Open Event builder make sure you have at least 1 Ticket Type and 1 Schedule Item.
	#* Click on specific TT and 3 dots click on Manage Badges.
	#** This is how you assign a Badge to a TT (I*t means when someone registers with this ticket they will earn this badge*)
	#* Go to Agenda tab, Click on specific Scheduled Item and click manage price rules
	#** Set up a price rule with the same badge and make it cheaper than the default price (*it means whoever has this badge qualifies the get this cheaper price rule)*.
	#* Now, Go to the front end and register for this event
	#* Users should get the cheaper price since they have the ticket type in their cart which is going to give them that price rule (*Badge does not exist yet, it is called in cart pricing*)

	#Tests h2. Steps to Reproduce
	#
	#1.Set up an event with default config for contact/attendee, non-free, multi-ticket
	#
	#2.For one of the ticket types, click manage badges and select a badge
	#
	#3.Create a schedule item and add a price rule with the criteria of the badge that was given in step 2
	#
	#4.Set status to Active and open the event in the front end
	#
	#5.Add the ticket type that assigns the badgeOn the agenda page, add the schedule item that uses the badge-based price rule
	#
	#h2. Expected Results
	#
	#Badge-based price on schedule item IS applied on checkout page
	#
	#h2. Actual Results
	#
	#Badge-based price on schedule item IS NOT applied on checkout page
	#
	#h2. Business Justification
	#
	#Event goes live week of 8/16
	#
	#
	#
	#*Additional Steps from PM TEAM*
	#
	#* Open Event builder make sure you have at least 1 Ticket Type and 1 Schedule Item.
	#* Click on specific TT and 3 dots click on Manage Badges.
	#** This is how you assign a Badge to a TT (I*t means when someone registers with this ticket they will earn this badge*)
	#* Go to Agenda tab, Click on specific Scheduled Item and click manage price rules
	#** Set up a price rule with the same badge and make it cheaper than the default price (*it means whoever has this badge qualifies the get this cheaper price rule)*.
	#* Now, Go to the front end and register for this event
	#* Users should get the cheaper price since they have the ticket type in their cart which is going to give them that price rule (*Badge does not exist yet, it is called in cart pricing*)
	@TEST_PD-29536 @REQ_PD-27872 @21Winter @22Winter @regression @Pavan
	Scenario: Test In-cart pricing not working when badge given with ticket type should be applied to price rule on schedule item
		Given User navigate to community Portal page with "cdulce@mailinator.com" user and password "705Fonteva" as "authenticated" user
		When User selects event "AutoEvent1" and event type "MultiTicket" on LT portal
		And User register for "BadgeTicket" ticket with 1 quantity and navigate to "session" page as "authenticated user"
		Then User selects "BadgeSession" sessions on agenda page and validate the in-cart pricing is applied
