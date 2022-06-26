@REQ_PD-28034
Feature: BLOCKED BY PD-29293 FOR 22WINTER + 21WINTER PASSED : Attendee field is cleared from Form's Field response object when editing it from Manage Registration
	#*Case Reporter* Paul Walstrom
	#
	#*Customer* American Academy of Family Physicians
	#
	#*Reproduced by* Prathyusha Pamudoorthi in 21Winter.0.1
	#
	#*Reference Case#* [00025300|https://fonteva.my.salesforce.com/5004V000011tfh9QAA]
	#
	#*Description:*
	#To reproduce:
	#1. Register for an event with Form.
	#2. Fill out the form. When You view the Field responses list, you will see the Attendee ID.
	#3. Now go to "Manage Registration" -> Edit Order Info. Change some form info and save.
	#4. Now if you view the Field responses list, you will see that the Attendee IDs are empty.
	#
	#*Steps to Reproduce:*
	#
	#Demor org ID: 00D5Y000001NF95
	#
	#Find the Event - FON-Annual Meeting (Community Event)
	#
	#Find a contact, login to the lightning community
	#
	#Register for the above event
	#
	#Upon registering for the event, Find the attendee record, Locate form response.
	#
	#Under from response related list, Find Field response.
	#
	#On the field response record, Find Attendee look up being populated.
	#
	#Go back to community, Open the above registered event
	#
	#Click Manage registration and select 'Edit order detail'
	#
	#Change the form response value
	#
	#Save
	#
	#Go back to the field response
	#
	#and Attendee look up is not populated anymore.
	#
	#*Actual Results:*
	#
	#Attendee field is cleared from Form's Field response object when editing it from Manage Registration
	#
	#*Expected Results:*
	#
	#Attendee field should not be cleared from Form's Field response object when editing it from Manage Registration
	#
	#*T3 Notes:*
	#
	#We need to add these lines of code in LTE.Form class to fix this issue:
	#
	## [#L580|https://github.com/Fonteva/LightningLens/blob/21Winter/community/main/default/classes/Form.cls#L580], add: {{formResponse = (PagesApi__Form_Response__c) new Framework.Selector(PagesApi__Form_Response__c.SObjectType).fields('EventApi__Attendee__c') .selectById(this.formResponseId);}}
	## [#L704|https://github.com/Fonteva/LightningLens/blob/21Winter/community/main/default/classes/Form.cls#L704] & [#737|https://github.com/Fonteva/LightningLens/blob/21Winter/community/main/default/classes/Form.cls#L737], add this same code: {{if(formResponse.EventApi__Attendee__c != null) { fieldResponse.EventApi__Attendee__c = formResponse.EventApi__Attendee__c; }}}
	#
	#!image (15).png|width=1019,height=360!
	#
	#!image (13).png|width=1036,height=348!
	#
	#!image (14).png|width=1030,height=368!

	#Tests *Case Reporter* Paul Walstrom
	#
	#*Customer* American Academy of Family Physicians
	#
	#*Reproduced by* Prathyusha Pamudoorthi in 21Winter.0.1
	#
	#*Reference Case#* [00025300|https://fonteva.my.salesforce.com/5004V000011tfh9QAA]
	#
	#*Description:*
	#To reproduce:
	#1. Register for an event with Form.
	#2. Fill out the form. When You view the Field responses list, you will see the Attendee ID.
	#3. Now go to "Manage Registration" -> Edit Order Info. Change some form info and save.
	#4. Now if you view the Field responses list, you will see that the Attendee IDs are empty.
	#
	#*Steps to Reproduce:*
	#
	#Demor org ID: 00D5Y000001NF95
	#
	#Find the Event - FON-Annual Meeting (Community Event)
	#
	#Find a contact, login to the lightning community
	#
	#Register for the above event
	#
	#Upon registering for the event, Find the attendee record, Locate form response.
	#
	#Under from response related list, Find Field response.
	#
	#On the field response record, Find Attendee look up being populated.
	#
	#Go back to community, Open the above registered event
	#
	#Click Manage registration and select 'Edit order detail'
	#
	#Change the form response value
	#
	#Save
	#
	#Go back to the field response
	#
	#and Attendee look up is not populated anymore.
	#
	#*Actual Results:*
	#
	#Attendee field is cleared from Form's Field response object when editing it from Manage Registration
	#
	#*Expected Results:*
	#
	#Attendee field should not be cleared from Form's Field response object when editing it from Manage Registration
	#
	#*T3 Notes:*
	#
	#We need to add these lines of code in LTE.Form class to fix this issue:
	#
	## [#L580|https://github.com/Fonteva/LightningLens/blob/21Winter/community/main/default/classes/Form.cls#L580], add: {{formResponse = (PagesApi__Form_Response__c) new Framework.Selector(PagesApi__Form_Response__c.SObjectType).fields('EventApi__Attendee__c') .selectById(this.formResponseId);}}
	## [#L704|https://github.com/Fonteva/LightningLens/blob/21Winter/community/main/default/classes/Form.cls#L704] & [#737|https://github.com/Fonteva/LightningLens/blob/21Winter/community/main/default/classes/Form.cls#L737], add this same code: {{if(formResponse.EventApi__Attendee__c != null) { fieldResponse.EventApi__Attendee__c = formResponse.EventApi__Attendee__c; }}}
	#
	#!image (15).png|width=1019,height=360!
	#
	#!image (13).png|width=1036,height=348!
	#
	#!image (14).png|width=1030,height=368!
	@TEST_PD-29368 @REQ_PD-28034 @regression @21Winter @22Winter @anitha
	Scenario: Test : Attendee field is cleared from Form's Field response object when editing it from Manage Registration
		Given User navigate to community Portal page with "danielabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User selects event "AutoEvent3" and event type "MultiTicket" on LT portal
		When User enters the form response "New York" after ordering 1 ticket of type "AutoTicket"
		And User successfully pays for the event using credit card
		Then User verifies the form response field is populated or updated with "New York" for attendee record
		And User edits the order details and change the form resoponse value with "Houston"
		Then User verifies the form response field is populated or updated with "Houston" for attendee record
