@REQ_PD-22982
Feature: PRIORITY AOF - Events - Speakers not cloning
	#*Reproduced by* Ewa Imtiaz in 2019.1.0.19
	#
	#*Reference Case#*[00021808|https://fonteva.my.salesforce.com/5003A000010BJ2nQAG]
	#
	#*Description:*
	#
	#When you clone an Event that has speaker records, those speaker records do not save on the new event. The events I have tested are Lightning Registration Style.
	#
	#*Steps to Reproduce:*
	#
	#Username: [laurenmay6@gco.test|mailto:laurenmay6@gco.test]
	#
	#password: training123
	#
	#Events > New > Clone > Select Event with Speakers > Clone > confirm Speakers is among selected objects to clone > clone
	#
	#*Actual Results:*
	#
	#The speaker records from the cloned event do NOT save on the new event.
	#
	#*Expected Results:*
	#
	#The speaker records from the cloned event save on the new event.
	#
	#*Additional Scenario (T1-3537):*
	#
	#When cloning a base event which is configured with Speakers, Scheduled Items AND a relationship between the two exists (i.e. Speakers assigned to various Sessions) AND both Scheduled Items and Speakers are included in the clone the cloning process does not complete fully. Speakers are not created.
	#
	#Error "Required fields are missing: \[Scheduled Item] Class.EventApi.EventsBuilderController.buildSpeakers: line 1727, column 1" generated
	#
	#*T3 Notes:*
	#
	#Issue seems in controller 'EventsBuilderController' Method 'buildSpeakers';[+https://github.com/Fonteva/eventapi/blob/2019-R1-Patch-Master/src/classes/EventsBuilderController.cls#L17+|https://github.com/Fonteva/eventapi/blob/2019-R1-Patch-Master/src/classes/EventsBuilderController.cls#L17]+37+
	#
	#Not getting the value from 'schMapMap' during mapping Schedule_Item__c field on Object 'Speaker_Schedule_Item__c' , that's why we are getting error required Field Missing.
	#Need to populate valid value, so we can get expected result.

	#Tests *Reproduced by* Ewa Imtiaz in 2019.1.0.19
	#
	#*Reference Case#*[00021808|https://fonteva.my.salesforce.com/5003A000010BJ2nQAG]
	#
	#*Description:*
	#
	#When you clone an Event that has speaker records, those speaker records do not save on the new event. The events I have tested are Lightning Registration Style.
	#
	#*Steps to Reproduce:*
	#
	#Username: [laurenmay6@gco.test|mailto:laurenmay6@gco.test]
	#
	#password: training123
	#
	#Events > New > Clone > Select Event with Speakers > Clone > confirm Speakers is among selected objects to clone > clone
	#
	#*Actual Results:*
	#
	#The speaker records from the cloned event do NOT save on the new event.
	#
	#*Expected Results:*
	#
	#The speaker records from the cloned event save on the new event.
	#
	#*Additional Scenario (T1-3537):*
	#
	#When cloning a base event which is configured with Speakers, Scheduled Items AND a relationship between the two exists (i.e. Speakers assigned to various Sessions) AND both Scheduled Items and Speakers are included in the clone the cloning process does not complete fully. Speakers are not created.
	#
	#Error "Required fields are missing: \[Scheduled Item] Class.EventApi.EventsBuilderController.buildSpeakers: line 1727, column 1" generated
	#
	#*T3 Notes:*
	#
	#Issue seems in controller 'EventsBuilderController' Method 'buildSpeakers';[+https://github.com/Fonteva/eventapi/blob/2019-R1-Patch-Master/src/classes/EventsBuilderController.cls#L17+|https://github.com/Fonteva/eventapi/blob/2019-R1-Patch-Master/src/classes/EventsBuilderController.cls#L17]+37+
	#
	#Not getting the value from 'schMapMap' during mapping Schedule_Item__c field on Object 'Speaker_Schedule_Item__c' , that's why we are getting error required Field Missing.
	#Need to populate valid value, so we can get expected result.
	@TEST_PD-29457 @REQ_PD-22982 @regression @21Winter @22Winter @akash
	Scenario: Test PRIORITY AOF - Events - Speakers not cloning
		Given User navigates to events tabs
		And User clones the event with "AutoEvent10" event
		Then User verifies all the speakers are cloned




