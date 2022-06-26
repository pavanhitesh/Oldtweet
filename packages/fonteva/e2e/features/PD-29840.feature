@REQ_PD-29840
Feature: Attach a new child record to an existing parent record using a custom dynamic variable
	#C89819
	#
	#PRE-CONDITIONS:
	#
	#* \[C15631] Create a new Form
	#* \[C16470] Click Form Builder button
	#* Have an existing parent record, such as an Event, Invoice, Subscription (can be any existing record)
	#* Determine which Child record you’d like to update within an existing parent record.  The examples within this test case will be referring to adding a new Speaker (child) to an existing Event (parent) but any parent/child combination can be used.
	#
	#STEPS:
	#
	## Create a Field Group that is mapped to the chosen child object:
	#
	## Click on the 'New Field Group' button.
	## Enter a Field Group Name.
	## Select the chosen Child object for the ‘Mapped Object Field’, i.e. Speaker.
	## Select ‘Insert’ under Database Operations.
	## Click on the Save button.
	#
	#Expected Result:
	#The new Field Group should be created without issue.
	#
	## Create one or more fields associated with the child object. For example, if you choose the ‘Speaker’ option in the 'Mapped Object Field' for the created field group, you could create a new field for anything associated with a Speaker object, such as, Speaker Name, Email, Company Name.
	#
	## Click on the ‘New Field’ button.
	## Enter a name in the ‘Field Label’, i.e. Name.
	## Select the appropriate Type for the new field, i.e. Text.
	## Select the appropriate ‘Mapped Object Field’ the chosen field, i.e. ‘Speaker Name’.
	## Repeat steps 1 - 4 until all desired Fields are created.
	#
	#Expected Result:
	#The new Fields should be created without issue.
	#
	## Create a reference to the Parent Object within the same field group:
	#
	## Click on the ‘New Field’ button.
	#
	## Enter a name in the name field, such as, Event.
	#
	## Select ‘Reference’ for the Type field.
	#
	## Select the appropriate Parent object for the ‘Mapped Object Field’, i.e. Event.
	#
	## Select ‘Hidden Field’.
	#
	## Enter a ‘Hidden Field Value’ that will be used to map the form to the parent object using the format
	#
	#{{url.param}}, replacing 'param' with any parameter you choose, such as {{url.eventId}}.
	#
	## Click on the Save button.
	#
	#Expected Result:
	#The new Reference type field should be created without issue.
	#
	## Build your form URL to associate the form to a specific parent object in the following manner:
	#
	## Click the ‘Exit’ button on the Form Builder page.
	## Copy the form URL from the Form Details page and paste it into URL field in another browser tab. See Note 1 below.
	## Add '&param=' (without quotes) to the end of the form URL, replacing 'param' with the value used for the Hidden Field Value, i.e. &eventId=
	## Return to the previous browser tab.
	## Search for the existing parent object you’d like to update using the Search field at the top of the screen or navigate to the object using the main navigation pull-down in upper right-hand corner.
	## Select the object.
	## Copy the object ID listed at the end of the URL.  See Note 2 below.
	## Return to the tab with the form URL and append the object ID to the end of the URL. See Note 3 below.
	## Refresh the page to load the form.
	#
	#Note 1: If testing in an integration org, change cpbase to cpbase8 within the copied URL.
	#
	#Note 2:  Example, if the URL for the parent object is as follows:  [https://na30.salesforce.com/a1Z36000001ADDw|https://na30.salesforce.com/a1Z36000001ADDw] , the object ID would be a1Z36000001ADDw
	#
	#Note 3:  Here’s an example of a complete form URL that associates a form with a parent object using the hidden field value of eventId within an integration org:
	#
	#[https://applausetest.force.com/cpbase8__form?ID=a0Y360000036kVo&eventId=a1Z36000001AC33|https://applausetest.force.com/cpbase8__form?ID=a0Y360000036kVo&eventId=a1Z36000001AC33]
	#
	#Expected Result:
	#The form should load without issue.
	#
	## 1. Fill out the form and hit submit.
	#
	#Expected Result:
	#The form should submit without issue.
	#
	## Verify that the new child record was added to the parent object:
	#
	## Return to the tab that contains the parent object.
	#
	## Refresh the page.
	#
	## Scroll down to the section pertaining to the child object, i.e. the Speakers section.
	#
	## Verify that a new entry has been added containing the information provided in the form.
	#
	#Expected Result:
	#A new record should be added to the area that pertains to the child object.  For example, a new Speaker entry for the Event.
	#EXPECTED RESULTS:
	#
	#ALTERNATE FLOW(S):

	#Tests C89819
	#
	#PRE-CONDITIONS:
	#
	#* \[C15631] Create a new Form
	#* \[C16470] Click Form Builder button
	#* Have an existing parent record, such as an Event, Invoice, Subscription (can be any existing record)
	#* Determine which Child record you’d like to update within an existing parent record.  The examples within this test case will be referring to adding a new Speaker (child) to an existing Event (parent) but any parent/child combination can be used.
	#
	#STEPS:
	#
	## Create a Field Group that is mapped to the chosen child object:
	#
	## Click on the 'New Field Group' button.
	## Enter a Field Group Name.
	## Select the chosen Child object for the ‘Mapped Object Field’, i.e. Speaker.
	## Select ‘Insert’ under Database Operations.
	## Click on the Save button.
	#
	#Expected Result:
	#The new Field Group should be created without issue.
	#
	## Create one or more fields associated with the child object. For example, if you choose the ‘Speaker’ option in the 'Mapped Object Field' for the created field group, you could create a new field for anything associated with a Speaker object, such as, Speaker Name, Email, Company Name.
	#
	## Click on the ‘New Field’ button.
	## Enter a name in the ‘Field Label’, i.e. Name.
	## Select the appropriate Type for the new field, i.e. Text.
	## Select the appropriate ‘Mapped Object Field’ the chosen field, i.e. ‘Speaker Name’.
	## Repeat steps 1 - 4 until all desired Fields are created.
	#
	#Expected Result:
	#The new Fields should be created without issue.
	#
	## Create a reference to the Parent Object within the same field group:
	#
	## Click on the ‘New Field’ button.
	#
	## Enter a name in the name field, such as, Event.
	#
	## Select ‘Reference’ for the Type field.
	#
	## Select the appropriate Parent object for the ‘Mapped Object Field’, i.e. Event.
	#
	## Select ‘Hidden Field’.
	#
	## Enter a ‘Hidden Field Value’ that will be used to map the form to the parent object using the format
	#
	#{{url.param}}, replacing 'param' with any parameter you choose, such as {{url.eventId}}.
	#
	## Click on the Save button.
	#
	#Expected Result:
	#The new Reference type field should be created without issue.
	#
	## Build your form URL to associate the form to a specific parent object in the following manner:
	#
	## Click the ‘Exit’ button on the Form Builder page.
	## Copy the form URL from the Form Details page and paste it into URL field in another browser tab. See Note 1 below.
	## Add '&param=' (without quotes) to the end of the form URL, replacing 'param' with the value used for the Hidden Field Value, i.e. &eventId=
	## Return to the previous browser tab.
	## Search for the existing parent object you’d like to update using the Search field at the top of the screen or navigate to the object using the main navigation pull-down in upper right-hand corner.
	## Select the object.
	## Copy the object ID listed at the end of the URL.  See Note 2 below.
	## Return to the tab with the form URL and append the object ID to the end of the URL. See Note 3 below.
	## Refresh the page to load the form.
	#
	#Note 1: If testing in an integration org, change cpbase to cpbase8 within the copied URL.
	#
	#Note 2:  Example, if the URL for the parent object is as follows:  [https://na30.salesforce.com/a1Z36000001ADDw|https://na30.salesforce.com/a1Z36000001ADDw] , the object ID would be a1Z36000001ADDw
	#
	#Note 3:  Here’s an example of a complete form URL that associates a form with a parent object using the hidden field value of eventId within an integration org:
	#
	#[https://applausetest.force.com/cpbase8__form?ID=a0Y360000036kVo&eventId=a1Z36000001AC33|https://applausetest.force.com/cpbase8__form?ID=a0Y360000036kVo&eventId=a1Z36000001AC33]
	#
	#Expected Result:
	#The form should load without issue.
	#
	## 1. Fill out the form and hit submit.
	#
	#Expected Result:
	#The form should submit without issue.
	#
	## Verify that the new child record was added to the parent object:
	#
	## Return to the tab that contains the parent object.
	#
	## Refresh the page.
	#
	## Scroll down to the section pertaining to the child object, i.e. the Speakers section.
	#
	## Verify that a new entry has been added containing the information provided in the form.
	#
	#Expected Result:
	#A new record should be added to the area that pertains to the child object.  For example, a new Speaker entry for the Event.
	#EXPECTED RESULTS:
	#
	#ALTERNATE FLOW(S):
	@TEST_PD-29841 @REQ_PD-29840 @regression @21Winter @22Winter @lakshman
	Scenario: Test Attach a new child record to an existing parent record using a custom dynamic variable
		Given User navigate to community Portal page with "jacksonfernandez@mailinator.com" user and password "705Fonteva" as "authenticated" user
		When User opens "AutoAttachSpeakerChildToEventParentForm" form page
		And User links the form with the event "AutoDynamicSpeakerChildParentEvent" using url parameter.
		Then Then User submits the form with "Speaker Name" and "Speaker Company" and verifies the form response
		And User verifies the speaker information added in the parent event

