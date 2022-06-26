@REQ_PD-28442
Feature: Missing registration form data for primary attendee on Group Ticket type events
	#h2. Details
	#For Group Ticket Type events, the primary attendee's information will not be collected from the attached registration form for free events.
	#h2. Steps to Reproduce
	#EVENT CONFIGURATION
	#1 - Create a lightning event 
	#2 - Select 'Free' Event checkbox
	#3 - Save the record
	#4- Add a ticket (quantity = 10 each) and attach a form
	#- Also, mark the ticket as a ‘Group Ticket’ and select 2 attendees per group
	#- Save the record
	#4 - Add an optional agenda item
	#-Save the record
	#5- Activate the event and save and exit to close Event Builder.
	#
	#STEPS TO REPRODUCE
	#6 - Go to the Event Registration Page
	#7 - Register for the event
	#-Select ticket quantity (1) and click ‘Register Now'.
	#- Provide purchaser information (first name, last, and email).
	#- Click ‘Continue’.
	#8 – On the next page, provide attendee information along with other form data.
	#-click ‘Continue’ to save and provide additional guest’s information.
	#-NOTE: You will notice that the form data from the previous attendee’s section is carried forward. (Also an issue)
	#-Provide necessary information for the guest attendee and click ‘Continue’.
	#9 – On the registration summary page, add an agenda (optional) and ‘Confirm order’.
	#10 – After successful submission, navigate to primary attendee record.
	#
	#The reason behind the issue is the 'Free event Checkbox'. If it is unchecked the form response is getting saved but the Customer wants the 'Free event' checkbox to be true.
	#
	#GCO Details:
	#enesson-20r2b@fonteva.com/Fonteva703
	#Recording- https://fonteva.zoom.us/rec/share/vzYPZrk4eK7EtoPQZwluC9JvXrGMPbvErP8W7i3WRoYIdzqZ4QVUqs8Gte2-4zfS.LNx3ppXdC1OPGlk0
	#Event- https://eligco.lightning.force.com/lightning/r/EventApi__Event__c/a1Y5Y000008KhRgUAK/view
	#Primary attendee record- https://eligco.lightning.force.com/lightning/r/EventApi__Attendee__c/a1W5Y000013S6gzUAC/view
	#Second attendee record- https://eligco.lightning.force.com/lightning/r/EventApi__Attendee__c/a1W5Y000013S6h0UAC/view
	#h2. Expected Results
	#Primary attendee’s related registration form should be present and captured responses should be available.
	#h2. Actual Results
	#Registration form record and collected responses are missing under the primary attendee’s record.
	#h2. Business Justification
	#Form information missing leads to customer's complication

	#Tests h2. Details
	#For Group Ticket Type events, the primary attendee's information will not be collected from the attached registration form for free events.
	#h2. Steps to Reproduce
	#EVENT CONFIGURATION
	#1 - Create a lightning event 
	#2 - Select 'Free' Event checkbox
	#3 - Save the record
	#4- Add a ticket (quantity = 10 each) and attach a form
	#- Also, mark the ticket as a ‘Group Ticket’ and select 2 attendees per group
	#- Save the record
	#4 - Add an optional agenda item
	#-Save the record
	#5- Activate the event and save and exit to close Event Builder.
	#
	#STEPS TO REPRODUCE
	#6 - Go to the Event Registration Page
	#7 - Register for the event
	#-Select ticket quantity (1) and click ‘Register Now'.
	#- Provide purchaser information (first name, last, and email).
	#- Click ‘Continue’.
	#8 – On the next page, provide attendee information along with other form data.
	#-click ‘Continue’ to save and provide additional guest’s information.
	#-NOTE: You will notice that the form data from the previous attendee’s section is carried forward. (Also an issue)
	#-Provide necessary information for the guest attendee and click ‘Continue’.
	#9 – On the registration summary page, add an agenda (optional) and ‘Confirm order’.
	#10 – After successful submission, navigate to primary attendee record.
	#
	#The reason behind the issue is the 'Free event Checkbox'. If it is unchecked the form response is getting saved but the Customer wants the 'Free event' checkbox to be true.
	#
	#GCO Details:
	#enesson-20r2b@fonteva.com/Fonteva703
	#Recording- https://fonteva.zoom.us/rec/share/vzYPZrk4eK7EtoPQZwluC9JvXrGMPbvErP8W7i3WRoYIdzqZ4QVUqs8Gte2-4zfS.LNx3ppXdC1OPGlk0
	#Event- https://eligco.lightning.force.com/lightning/r/EventApi__Event__c/a1Y5Y000008KhRgUAK/view
	#Primary attendee record- https://eligco.lightning.force.com/lightning/r/EventApi__Attendee__c/a1W5Y000013S6gzUAC/view
	#Second attendee record- https://eligco.lightning.force.com/lightning/r/EventApi__Attendee__c/a1W5Y000013S6h0UAC/view
	#h2. Expected Results
	#Primary attendee’s related registration form should be present and captured responses should be available.
	#h2. Actual Results
	#Registration form record and collected responses are missing under the primary attendee’s record.
	#h2. Business Justification
	#Form information missing leads to customer's complication
	@REQ_PD-28442 @TEST_PD-29121 @regression @21Winter @22Winter @sophiya
	Scenario: Test Missing registration form data for primary attendee on Group Ticket type events
		Given User navigate to community Portal page with "danielabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		When User selects event "Auto Free Event with Group ticket and form" and event type "MultiTicket" on LT portal
		And User register for "GroupTicket" ticket with "1" quantity and with form and group ticket
		Then User verifies registration form data is available in all attendee record
