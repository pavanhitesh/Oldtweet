@REQ_PD-27915
Feature: Cannot Add recommended items to the selected attendee when registering multiple people
	#*Case Reporter* Eight Cloud
	#
	#*Customer* ZERO TO THREE: National Center for Infants, Toddlers and Families
	#
	#*Reproduced by* Sandeep Bangwal in 21Winter.0.4
	#
	#*Reference Case#* [00030626|https://fonteva.my.salesforce.com/5004V000016MMCbQAO]
	#
	#*Description:*
	#
	#If we set the ticket quantity to 3 and register for the event with 3 attendees, once we get redirected to the recommended item page, we don't get the option to add the recommended items for the attendees.
	#
	#*Steps to Reproduce:*
	#
	#Created an event similar to the event on the customer's sandbox.
	#
	#* Ticket quantity was set to 3
	#* Registered using the following user accounts for the event using jh1@mailinator.com and 2 more attendees.
	#* On the recommended items page, it only shows the recommended item for jh1@mailinator.com and not for the other 2 attendees.
	#
	#Screen Recording: [https://drive.google.com/file/d/1l2U10IS65icMHjr021TwD\_\_ASze3N5y9/view?usp=sharing|https://drive.google.com/file/d/1l2U10IS65icMHjr021TwD__ASze3N5y9/view?usp=sharing]
	#
	#Issue reproduced in 21Winter.0.4.
	#
	#*Actual Results:*
	#
	#Recommended items are not available for the attendees.
	#
	#*Expected Results:*
	#
	#should have an option to add the recommended items for the attendees.
	#
	#*CS Note:*
	#GCO URL: https://gcon4qrsd.lightning.force.com/lightning/page/home Username: enesson-20r2b@fonteva.com Password: Fonteva703 Event Url: https://gcon4qrsd.lightning.force.com/lightning/r/EventApi\_\_Event\_\_c/a1Y5Y000008D6O7UAK/view

	#Tests *Case Reporter* Eight Cloud
	#
	#*Customer* ZERO TO THREE: National Center for Infants, Toddlers and Families
	#
	#*Reproduced by* Sandeep Bangwal in 21Winter.0.4
	#
	#*Reference Case#* [00030626|https://fonteva.my.salesforce.com/5004V000016MMCbQAO]
	#
	#*Description:*
	#
	#If we set the ticket quantity to 3 and register for the event with 3 attendees, once we get redirected to the recommended item page, we don't get the option to add the recommended items for the attendees.
	#
	#*Steps to Reproduce:*
	#
	#Created an event similar to the event on the customer's sandbox.
	#
	#* Ticket quantity was set to 3
	#* Registered using the following user accounts for the event using jh1@mailinator.com and 2 more attendees.
	#* On the recommended items page, it only shows the recommended item for jh1@mailinator.com and not for the other 2 attendees.
	#
	#Screen Recording: [https://drive.google.com/file/d/1l2U10IS65icMHjr021TwD\_\_ASze3N5y9/view?usp=sharing|https://drive.google.com/file/d/1l2U10IS65icMHjr021TwD__ASze3N5y9/view?usp=sharing]
	#
	#Issue reproduced in 21Winter.0.4.
	#
	#*Actual Results:*
	#
	#Recommended items are not available for the attendees.
	#
	#*Expected Results:*
	#
	#should have an option to add the recommended items for the attendees.
	#
	#*CS Note:*
	#GCO URL: https://gcon4qrsd.lightning.force.com/lightning/page/home Username: enesson-20r2b@fonteva.com Password: Fonteva703 Event Url: https://gcon4qrsd.lightning.force.com/lightning/r/EventApi\_\_Event\_\_c/a1Y5Y000008D6O7UAK/view
	@TEST_PD-29314 @REQ_PD-27915 @21Winter @22Winter @regression @ngunda
	Scenario: Test Cannot Add recommended items to the selected attendee when registering multiple people
		Given User navigate to community Portal page with "maxfoxworth@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User selects event "AutoEvent1" and event type "MultiTicket" on LT portal
		And User register for "PITicket2" ticket with 3 quantity and navigate to "attendee modal" page as "authenticated user"
		And User updates the Attendee list for the ticket "PITicket2" as below:
			| GuestName      |
			| Eva Foxworth   |
			| Larry Foxworth |
		And User navigates to agenda page
		And User selects "NA" sessions on agenda page and navigate to "packageItems" page
		Then User verifies packageitems can be added for each of the below attendees:
			| AttendeeName   | packageItemName |
			| Max Foxworth   | FontevaPens     |
			| Eva Foxworth   | FontevaPens     |
			| Larry Foxworth | FontevaPens     |
