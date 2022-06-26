@REQ_PD-29793
Feature: Updating an existing record using the standard dynamic variable ContactId
	#C89820
	#
	#PRE-CONDITIONS:
	#
	#* \[C15631] Create a new Form
	#* \[C16470] Click Form Builder button
	#
	#The examples used in this test case will allow a portal user to update their contact record.
	#STEPS:
	#
	## Create a Field Group using a usr.ContactId Standard Dynamic variable in the SOQL Filter.
	#
	## Click on the 'New Field Group' button.
	#
	## Enter a Field Group Name, i.e. Contact Info.
	#
	## Enter the following into the SOQL Filter field : Id = '
	#
	#{{usr.ContactId}}'
	#
	## Select the 'Contact' option for the ‘Mapped Object Field’.
	#
	## Select ‘Upsert’ under Database Operations.
	#
	## Click on the Save button.
	#
	#Expected Result:
	#
	#* Should be able to create a new field group using the an ID pointing to usr.ContactId in the SOQL filter without issue.
	#2. Create one or more fields for entries you would like the form user to update within the Contact record:
	#
	## Click on the ‘New Field’ button.
	#
	## Enter a name in the ‘Field Label’, i.e. Name.
	#
	## Select the appropriate Type for the new field, i.e. Contact Last Name.
	#
	## Select the appropriate ‘Mapped Object Field’ the chosen field, i.e. Last Name.
	#
	## Repeat steps 1 - 4 until all desired Fields are created.
	#
	#Expected Result:
	#
	#* The new Fields should be created without issue.
	#3. 1. Click the ‘Exit’ button on the Form Builder page.
	#Expected Result:
	#* Should be returned to the Form Detail page.
	#4. 1. In another browser tab, log into the community portal.
	#Expected Result:
	#* Should be able to log in to the community portal without issue.
	#5. 1. Return to the tab with the Form Detail page displayed.
	#2. Copy the Form URL into a different tab in the same browser used to log into the community portal.  See Note Below.
	#3. Hit return on the keyboard or refresh the page.
	#
	#Note: If testing in an integration org, change cpbase to cpbase8 within the copied URL.
	#Expected Result:
	#
	#* The form should be displayed without issue.
	#* Since the user is logged into the community portal, the form fields should be pre-filled with current information for the record you are updating, if those fields currently have data.
	#6. 1. Enter new information into one or more of the form fields.
	#2. Hit the Submit button.
	#Expected Result:
	#* User should be able to update all fields in the form
	#* The form should be submitted without issue.
	#7. 1. Return to the tab with the Form Detail page displayed.
	#2. Navigate to or search for the existing record that was being updated, i.e. the Contact associated with the portal user.
	#3. Verify that all fields updated in the form have been updated in the record with the the new values.
	#Expected Result:
	#* The record should be updated with all entries that were changed in the form.
	#EXPECTED RESULTS:
	#
	#ALTERNATE FLOW(S):

	#Tests C89820
	#
	#PRE-CONDITIONS:
	#
	#* \[C15631] Create a new Form
	#* \[C16470] Click Form Builder button
	#
	#The examples used in this test case will allow a portal user to update their contact record.
	#STEPS:
	#
	## Create a Field Group using a usr.ContactId Standard Dynamic variable in the SOQL Filter.
	#
	## Click on the 'New Field Group' button.
	#
	## Enter a Field Group Name, i.e. Contact Info.
	#
	## Enter the following into the SOQL Filter field : Id = '
	#
	#{{usr.ContactId}}'
	#
	## Select the 'Contact' option for the ‘Mapped Object Field’.
	#
	## Select ‘Upsert’ under Database Operations.
	#
	## Click on the Save button.
	#
	#Expected Result:
	#
	#* Should be able to create a new field group using the an ID pointing to usr.ContactId in the SOQL filter without issue.
	#2. Create one or more fields for entries you would like the form user to update within the Contact record:
	#
	## Click on the ‘New Field’ button.
	#
	## Enter a name in the ‘Field Label’, i.e. Name.
	#
	## Select the appropriate Type for the new field, i.e. Contact Last Name.
	#
	## Select the appropriate ‘Mapped Object Field’ the chosen field, i.e. Last Name.
	#
	## Repeat steps 1 - 4 until all desired Fields are created.
	#
	#Expected Result:
	#
	#* The new Fields should be created without issue.
	#3. 1. Click the ‘Exit’ button on the Form Builder page.
	#Expected Result:
	#* Should be returned to the Form Detail page.
	#4. 1. In another browser tab, log into the community portal.
	#Expected Result:
	#* Should be able to log in to the community portal without issue.
	#5. 1. Return to the tab with the Form Detail page displayed.
	#2. Copy the Form URL into a different tab in the same browser used to log into the community portal.  See Note Below.
	#3. Hit return on the keyboard or refresh the page.
	#
	#Note: If testing in an integration org, change cpbase to cpbase8 within the copied URL.
	#Expected Result:
	#
	#* The form should be displayed without issue.
	#* Since the user is logged into the community portal, the form fields should be pre-filled with current information for the record you are updating, if those fields currently have data.
	#6. 1. Enter new information into one or more of the form fields.
	#2. Hit the Submit button.
	#Expected Result:
	#* User should be able to update all fields in the form
	#* The form should be submitted without issue.
	#7. 1. Return to the tab with the Form Detail page displayed.
	#2. Navigate to or search for the existing record that was being updated, i.e. the Contact associated with the portal user.
	#3. Verify that all fields updated in the form have been updated in the record with the the new values.
	#Expected Result:
	#* The record should be updated with all entries that were changed in the form.
	#EXPECTED RESULTS:
	#
	#ALTERNATE FLOW(S):
	@TEST_PD-29794 @REQ_PD-29793 @regression @21Winter @22Winter @lakshman
	Scenario: Test Updating an existing record using the standard dynamic variable ContactId
		Given User navigate to community Portal page with "george.washington@mailinator.com" user and password "705Fonteva" as "authenticated" user
		When User opens "AutoUpdateContactFields" form page
		Then User verifies "Home Phone" and "Mailing City" values are populated from the contact "George Washington"
		And User submits the form by updating Home Phone and Mailing City for the contact and verifies the response

