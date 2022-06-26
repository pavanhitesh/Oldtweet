@REQ_PD-28178
Feature: Portal users not able to register for Free Events that have two ticket types
	#h2. Details
	#When a user tries to register for a free event that has two ticket types, the tickets do not show up in the 'Registration Summary' Box and the user is unable to register for that event. This is only happening when there are two ticket types.
	#h2. Steps to Reproduce
	#Org ID: 00D5e0000011vTv
	#Event : https://portal.cohesityusergroup.com/s/community-event?id=a1Y5e000000uWFDEA2
	#Event Record: https://cohesity3.lightning.force.com/lightning/r/EventApi__Event__c/a1Y5e000000uWFDEA2/view
	#Credentials -
	#UserName: vojupe@mailinator.com
	#Pwd: Fonteva703
	#
	#Console error- /s/community-event?i…DEA2#/reg/tickets:1 Uncaught (in promise) LC {component: "LTE:EventRegistrationFlowDetails$controller$doInit", componentStack: "[LTE:EventRegistrationTicketSelection] > [LTE:Even…etSelection] > [LTE:EventRegistrationFlowDetails]", action: null, name: "TypeError", message: "Action failed: LTE:EventRegistrationFlowDetails$co…r$doInit [Cannot read property 'hasForm' of null]", …}
	#
	#No system logs were generated.
	#
	# The page does not proceed after clicking confirm order button, an attendee record is created in the backend with 'Registered' Status. This is happening for events that are marked as 'Free' and have two ticket types.
	#h2. Expected Results
	#The user should be able to proceed on the confirmation page after clicking on confirm order button.
	#h2. Actual Results
	#The page does not proceed after clicking confirm order button
	#h2. Business Justification
	#This is a major issue for CUG.  and  Events are their major functionality.
	#CUG will have lots of users registering for events in Fonteva

	#Tests h2. Details
	#When a user tries to register for a free event that has two ticket types, the tickets do not show up in the 'Registration Summary' Box and the user is unable to register for that event. This is only happening when there are two ticket types.
	#h2. Steps to Reproduce
	#Org ID: 00D5e0000011vTv
	#Event : https://portal.cohesityusergroup.com/s/community-event?id=a1Y5e000000uWFDEA2
	#Event Record: https://cohesity3.lightning.force.com/lightning/r/EventApi__Event__c/a1Y5e000000uWFDEA2/view
	#Credentials -
	#UserName: vojupe@mailinator.com
	#Pwd: Fonteva703
	#
	#Console error- /s/community-event?i…DEA2#/reg/tickets:1 Uncaught (in promise) LC {component: "LTE:EventRegistrationFlowDetails$controller$doInit", componentStack: "[LTE:EventRegistrationTicketSelection] > [LTE:Even…etSelection] > [LTE:EventRegistrationFlowDetails]", action: null, name: "TypeError", message: "Action failed: LTE:EventRegistrationFlowDetails$co…r$doInit [Cannot read property 'hasForm' of null]", …}
	#
	#No system logs were generated.
	#
	# The page does not proceed after clicking confirm order button, an attendee record is created in the backend with 'Registered' Status. This is happening for events that are marked as 'Free' and have two ticket types.
	#h2. Expected Results
	#The user should be able to proceed on the confirmation page after clicking on confirm order button.
	#h2. Actual Results
	#The page does not proceed after clicking confirm order button
	#h2. Business Justification
	#This is a major issue for CUG.  and  Events are their major functionality.
	#CUG will have lots of users registering for events in Fonteva
 @TEST_PD-28986 @REQ_PD-28178 @21Winter @22Winter @regression @alex
 Scenario: Test Portal users not able to register for Free Events that have two ticket types
  Given User navigate to community Portal page with "larkinherbert@mailinator.com" user and password "705Fonteva" as "authenticated" user
  When User selects event "Auto FreeEvent SingleFormMulTickets" and event type "MultiTicket" on LT portal
  Then User verifies summary and confirm order button after ordering "1" tickets of type "AutoTicket1"
