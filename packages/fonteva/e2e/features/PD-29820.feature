@REQ_PD-29820
Feature: Form Response - captures Responder name incorrectly
	#1. Create a form 
	#2.  Attach it to an Event Ticket Access the Event in the portal 
	#3.  Purchase the ticket and answer the form's question 
	#4. Access the form response 
	#5. Note the field "Responder" 
	#6. The user's first name and last name appears

	#Tests 1. Create a form 
	#2.  Attach it to an Event Ticket Access the Event in the portal 
	#3.  Purchase the ticket and answer the form's question 
	#4. Access the form response 
	#5. Note the field "Responder" 
	#6. The user's first name and last name appears
	@TEST_PD-29821 @REQ_PD-29820 @regression @21Winter @22Winter @jhansi
	Scenario:  Test Form Response - captures Responder name incorrectly
		Given User navigate to community Portal page with "julianajacobson@mailinator.com" user and password "705Fonteva" as "authenticated" user
		When User selects event "AutoEventwithForm" and event type "SingleTicket" on LT portal
		And User enter the attendee details and register for the event
		And User successfully pays for the event using credit card
		Then User verifies the responder "Juliana Jacobson" name and the form "AutoEventResponderNameForm" response

