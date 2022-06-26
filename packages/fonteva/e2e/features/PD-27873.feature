@REQ_PD-27873
Feature: Price Rule - "New" button for price rule throws an error (LT Only)
	#h2. Steps to Reproduce
	#
	#Steps to reproduce - In lightning
	#
	#go to any event and click any Ticket Type
	#
	#Go To the related list for the price rule
	#
	#Click 'New Button'
	#
	#
	#A pink error appears that has the following verbiage: "Invalid id: ...." The ID is for Price Rule Custom Field - Ticket Type (Managed).
	#*However, this works in Classic AND within Event Builder*
	#
	#
	#
	#*PM NOTE:*
	#
	#* This ticket is not event-related, you dont need to know how events work. It is about price rules for ticket types.
	#* Price Rules work with Items actually, and each ticket type has a look up item (it is 1 to 1).
	#* So technically you can reach/manage price rules from item or ticket type.
	#* If you are coming from Item related list it works fine, but if you are coming from TT page throws an error.
	#* Since the Ticket type object lives in *EventAPI* which is on top of Orderapi, u need to reproduce this in Eventapi or *LTE* dev org. But the fix will likely go in Orderapi bc the price rule page is in orderapi.
	#*
	#
	#h2. Expected Results
	#
	#The ability to add a price rule without error.
	#
	#h2. Actual Results
	#
	#A pink error appears that has the following verbiage: "Invalid id: ...." The ID is for Price Rule Custom Field - Ticket Type (Managed).
	#
	#h2. Business Justification
	#
	#Customer unable to use 'New' button in Ticket Type related list - impacts client configurations for Events.

	#Tests h2. Steps to Reproduce
	#
	#Steps to reproduce - In lightning
	#
	#go to any event and click any Ticket Type
	#
	#Go To the related list for the price rule
	#
	#Click 'New Button'
	#
	#
	#A pink error appears that has the following verbiage: "Invalid id: ...." The ID is for Price Rule Custom Field - Ticket Type (Managed).
	#*However, this works in Classic AND within Event Builder*
	#
	#
	#
	#*PM NOTE:*
	#
	#* This ticket is not event-related, you dont need to know how events work. It is about price rules for ticket types.
	#* Price Rules work with Items actually, and each ticket type has a look up item (it is 1 to 1).
	#* So technically you can reach/manage price rules from item or ticket type.
	#* If you are coming from Item related list it works fine, but if you are coming from TT page throws an error.
	#* Since the Ticket type object lives in *EventAPI* which is on top of Orderapi, u need to reproduce this in Eventapi or *LTE* dev org. But the fix will likely go in Orderapi bc the price rule page is in orderapi.
	#*
	#
	#h2. Expected Results
	#
	#The ability to add a price rule without error.
	#
	#h2. Actual Results
	#
	#A pink error appears that has the following verbiage: "Invalid id: ...." The ID is for Price Rule Custom Field - Ticket Type (Managed).
	#
	#h2. Business Justification
	#
	#Customer unable to use 'New' button in Ticket Type related list - impacts client configurations for Events.
	@TEST_PD-28351 @REQ_PD-27873 @regression @21Winter @22Winter @ngunda
	Scenario: Test Price Rule - "New" button for price rule throws an error (LT Only)
		When User opens the PriceRules list page for a ticket of Event "AutoEvent1"
		Then User clicks on New Price Rule Button and verifies Price Rule page is dispalyed

