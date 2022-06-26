@REQ_PD-28014
Feature: Date field on Form attached to Ticket Type does not show date picker in single ticket registration and does not save the manually entered date value to the Field Response
	#*Case Reporter* Barnaby Savage
	#
	#*Customer* Moët Hennessy - Global
	#
	#*Reproduced by* Eli Nesson in 21Winter.0.0,20Spring.1.6
	#
	#*Reference Case#* [00029074|https://fonteva.my.salesforce.com/5004V000014LzGZQA0]
	#
	#*Description:*
	#
	#Date field on Form attached to Ticket Type does not show date picker in single ticket registration and does not save the manually entered date value to the Field Response
	#
	#Screen recording: [https://www.screencast.com/t/04jrTS8Zl]
	#
	#*Steps to Reproduce:*
	#
	## Create a form with a date field
	## Create an event with one ticket type and attach the form
	## Set ticket quantity and activate event
	## Access the Event URL (as a guest in test)
	## Click into the Date field from the attached form
	#
	#*Actual Results:*
	#
	#-The date picker does not show when the field is clicked on.- When entered manually, the date value is not saved to the Field Response record.
	#
	#*Expected Results:*
	#
	#-The date picker opens when the date field is clicked on-. Selecting the field and proceeding saves the value to the Field Response record.
	#
	#*Business Justification:*
	#
	#Per Barney - Moet requires Date of Birth information for all event registrants (due to alcohol consumption laws). This must be collected by Form during Event Registration. They cannot use Fonteva as it stands.
	#
	#*T3 Notes:*
	#
	#PM has confirmed the issue with date picker is expected for now (see [T1-4051|https://fonteva.aha.io/features/T1-4051?reference-class=Feature]) - that will not be a bug. see [FON-1392|https://fonteva.aha.io/features/FON-1392?reference-class=Feature] for more info
	#
	#However we need to fix the problem with blank field response for Date fields
	#
	#similar to[https://jira.fonteva.io/browse/PD-23968]{color:#1D1C1D} {color}
	#
	#Field response for Date field is blank for both logged in users and guest users

	#Tests *Case Reporter* Barnaby Savage
	#
	#*Customer* Moët Hennessy - Global
	#
	#*Reproduced by* Eli Nesson in 21Winter.0.0,20Spring.1.6
	#
	#*Reference Case#* [00029074|https://fonteva.my.salesforce.com/5004V000014LzGZQA0]
	#
	#*Description:*
	#
	#Date field on Form attached to Ticket Type does not show date picker in single ticket registration and does not save the manually entered date value to the Field Response
	#
	#Screen recording: [https://www.screencast.com/t/04jrTS8Zl]
	#
	#*Steps to Reproduce:*
	#
	## Create a form with a date field
	## Create an event with one ticket type and attach the form
	## Set ticket quantity and activate event
	## Access the Event URL (as a guest in test)
	## Click into the Date field from the attached form
	#
	#*Actual Results:*
	#
	#-The date picker does not show when the field is clicked on.- When entered manually, the date value is not saved to the Field Response record.
	#
	#*Expected Results:*
	#
	#-The date picker opens when the date field is clicked on-. Selecting the field and proceeding saves the value to the Field Response record.
	#
	#*Business Justification:*
	#
	#Per Barney - Moet requires Date of Birth information for all event registrants (due to alcohol consumption laws). This must be collected by Form during Event Registration. They cannot use Fonteva as it stands.
	#
	#*T3 Notes:*
	#
	#PM has confirmed the issue with date picker is expected for now (see [T1-4051|https://fonteva.aha.io/features/T1-4051?reference-class=Feature]) - that will not be a bug. see [FON-1392|https://fonteva.aha.io/features/FON-1392?reference-class=Feature] for more info
	#
	#However we need to fix the problem with blank field response for Date fields
	#
	#similar to[https://jira.fonteva.io/browse/PD-23968]{color:#1D1C1D} {color}
	#
	#Field response for Date field is blank for both logged in users and guest users
	@TEST_PD-29182 @REQ_PD-28014 @regression @akash @21Winter @22Winter
	Scenario: Test Date field on Form attached to Ticket Type does not show date picker in single ticket registration (authenticated user)
		Given User navigate to community Portal page with "danielabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		When User selects event "AutoSingleTicketEventWForm" and event type "SingleTicket" on LT portal
		And User enters "11/27/2030" date on the form and register for the event as "authenticated user"
		And User successfully pays for the event using credit card
		Then User verifies the "DateForm" form response for "authenticated user"

	@TEST_PD-29250 @REQ_PD-28014 @regression @akash @21Winter @22Winter
	Scenario: Test Date field on Form attached to Ticket Type does not show date picker in single ticket registration (guest user)
		Given User navigate to community Portal page
		When User selects event "AutoSingleTicketEventWForm" and event type "SingleTicket" on LT portal
		And User enters "11/27/2030" date on the form and register for the event as "guest user"
		And User successfully pays for the event using credit card
		Then User verifies the "DateForm" form response for "guest user"

