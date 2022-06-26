@REQ_PD-28009
Feature: (Winter21) Incorrect Duration when changing dates in Event builder
	#*Case Reporter* Sunita Kode
	#
	#*Customer* American Academy of Family Physicians
	#
	#*Reproduced by* Aaron Gremillion in 21Winter.0.0
	#
	#*Reference Case#* [00029664|https://fonteva.my.salesforce.com/5004V000014lXuCQAU]
	#
	#*Description:*
	#
	#Customer is attempting to manually enter date figures in start and end date fields on event builder in event info, and agenda tabs.
	#
	#*Steps to Reproduce:*
	#
	#Steps to Reproduce:
	#
	#Create event,
	#
	#On the event info page (or agenda item)
	#
	#Enter the 'Start Date'
	#
	#Enter the 'End Date'
	#
	#Activate/Save
	#
	#*Actual Results:*
	#
	#Issue:
	#
	#1. When dates are entered manually (not using calendar), wrong duration is displayed
	#
	#2. Wrong dates are displayed for scheduling the session on 'Agenda' tab
	#
	#3. When dates are selected from calendar and changed the 'End Date' more than once, wrong duration is displayed
	#
	#*Expected Results:*
	#
	#Entering dates, via manually or calendar function should produce the same results.
	#
	#Dates entered should be what appears on the front and back end of records.

	#Tests *Case Reporter* Sunita Kode
	#
	#*Customer* American Academy of Family Physicians
	#
	#*Reproduced by* Aaron Gremillion in 21Winter.0.0
	#
	#*Reference Case#* [00029664|https://fonteva.my.salesforce.com/5004V000014lXuCQAU]
	#
	#*Description:*
	#
	#Customer is attempting to manually enter date figures in start and end date fields on event builder in event info, and agenda tabs.
	#
	#*Steps to Reproduce:*
	#
	#Steps to Reproduce:
	#
	#Create event,
	#
	#On the event info page (or agenda item)
	#
	#Enter the 'Start Date'
	#
	#Enter the 'End Date'
	#
	#Activate/Save
	#
	#*Actual Results:*
	#
	#Issue:
	#
	#1. When dates are entered manually (not using calendar), wrong duration is displayed
	#
	#2. Wrong dates are displayed for scheduling the session on 'Agenda' tab
	#
	#3. When dates are selected from calendar and changed the 'End Date' more than once, wrong duration is displayed
	#
	#*Expected Results:*
	#
	#Entering dates, via manually or calendar function should produce the same results.
	#
	#Dates entered should be what appears on the front and back end of records.
	@TEST_PD-29328 @REQ_PD-28009 @regression @21Winter @22Winter @ngunda
	Scenario: Test (Winter21) Incorrect Duration when changing dates in Event builder
		Given User navigates to event "Auto_Event_WhereWhen" page
		Then User opens the eventbuilder page, enters the startDate and EndDate manually and verifies duration is calculated correctly
