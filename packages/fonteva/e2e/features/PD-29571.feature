@REQ_PD-29571
Feature: Updating an existing record using the standard dynamic variable Id
	#STEPS:
	#
	#1. Create a Field Group using a usr.Id Standard Dynamic variable in the SOQL Filter:
	#
	#1. Click on the 'New Field Group' button.2. Enter a Field Group Name, i.e User Info.3. Enter the following into the SOQL Filter field : Id = 'usr.Id'4. Select the 'User' option for the ‘Mapped Object Field’.5. Select ‘Upsert’ under Database Operations.6. Click on the Save button.Expected Result:
	#
	#Should be able to create a new field group using the an ID pointing to usr.Id in the SOQL filter without issue.2. Create one or more fields for entries you would like the form user to update within the User record:
	#
	#1. Click on the ‘New Field’ button.2. Enter a name in the ‘Field Label’, i.e. User Email.3. Select the appropriate Type for the new field, i.e. Email.4. Select the appropriate ‘Mapped Object Field’ the chosen field. i.e. Email.5. Repeat steps 1 - 4 until all desired Fields are created.Expected Result:
	#
	#The new Fields should be created without issue.3. 1. Click the ‘Exit’ button on the Form Builder page.Expected Result:
	#
	#Should be returned to the Form Detail page.4. 1. In another browser tab, log into the community portal.Expected Result:
	#
	#Should be able to log in to the community portal without issue.5. 1. Return to the tab with the Form Detail page displayed.2. Copy the Form URL into a different tab in the same browser used to log into the community portal.  See Note below.3. Hit return on the keyboard or refresh the page.
	#
	#Note: If testing in an integration org, change cpbase to cpbase8 within the copied URL.
	#
	#Expected Result:
	#
	#The form should be displayed without issue.
	#
	#Since the user is logged into the community portal, the form fields should be pre-filled with current information for the record you are updating, if those fields currently have data.6. 1. Enter new information into one or more of the form fields.2. Hit the Submit button.Expected Result:
	#
	#User should be able to update all fields in the form
	#
	#The form should be submitted without issue.7. 1. Return to the tab with the Form Detail page displayed.2. Navigate to or search for the existing record that was being updated, the portal User's user record.3. Verify that all entries are now have the new values entered into the form.
	#Expected Result:
	#
	#The record should be updated with all entries that were changed in the form.

	#Tests STEPS:
	#
	#1. Create a Field Group using a usr.Id Standard Dynamic variable in the SOQL Filter:
	#
	#1. Click on the 'New Field Group' button.2. Enter a Field Group Name, i.e User Info.3. Enter the following into the SOQL Filter field : Id = 'usr.Id'4. Select the 'User' option for the ‘Mapped Object Field’.5. Select ‘Upsert’ under Database Operations.6. Click on the Save button.Expected Result:
	#
	#Should be able to create a new field group using the an ID pointing to usr.Id in the SOQL filter without issue.2. Create one or more fields for entries you would like the form user to update within the User record:
	#
	#1. Click on the ‘New Field’ button.2. Enter a name in the ‘Field Label’, i.e. User Email.3. Select the appropriate Type for the new field, i.e. Email.4. Select the appropriate ‘Mapped Object Field’ the chosen field. i.e. Email.5. Repeat steps 1 - 4 until all desired Fields are created.Expected Result:
	#
	#The new Fields should be created without issue.3. 1. Click the ‘Exit’ button on the Form Builder page.Expected Result:
	#
	#Should be returned to the Form Detail page.4. 1. In another browser tab, log into the community portal.Expected Result:
	#
	#Should be able to log in to the community portal without issue.5. 1. Return to the tab with the Form Detail page displayed.2. Copy the Form URL into a different tab in the same browser used to log into the community portal.  See Note below.3. Hit return on the keyboard or refresh the page.
	#
	#Note: If testing in an integration org, change cpbase to cpbase8 within the copied URL.
	#
	#Expected Result:
	#
	#The form should be displayed without issue.
	#
	#Since the user is logged into the community portal, the form fields should be pre-filled with current information for the record you are updating, if those fields currently have data.6. 1. Enter new information into one or more of the form fields.2. Hit the Submit button.Expected Result:
	#
	#User should be able to update all fields in the form
	#
	#The form should be submitted without issue.7. 1. Return to the tab with the Form Detail page displayed.2. Navigate to or search for the existing record that was being updated, the portal User's user record.3. Verify that all entries are now have the new values entered into the form.
	#Expected Result:
	#
	#The record should be updated with all entries that were changed in the form.
	@TEST_PD-29572 @REQ_PD-29571 @22Winter @21Winter @ninjety @regression
	Scenario: Test Updating an existing record using the standard dynamic variable Id
		Given User navigate to community Portal page with "rosebrixton@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User opens "Auto User Upsert" form page
		And User validate the auto populated fields on form with user details for contact "Rose Brixton"
		Then User submits the form and validates the user record details are updated
