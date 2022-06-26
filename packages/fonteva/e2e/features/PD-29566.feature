@REQ_PD-29566
Feature: Updating every type of field within a record using a standard dynamic variable 
	#STEPS:
	#
	#1. Create a Field Group using a usr.AccountId Standard Dynamic variable in the SOQL Filter.
	#
	#1. Click on the 'New Field Group' button.2. Enter a Field Group Name, i.e. Account Info.3. Select an option for the ‘Mapped Object Field’, i.e. Account.4. Enter the following into the SOQL Filter field : Id = 'usr.AccountId'5. Select ‘Upsert’ under Database Operations.6. Click on the Save button.Expected Result:
	#
	#Should be able to create a new field group using the an ID pointing to usr.AccountId in the SOQL filter without issue.2. Create a field for every field type available within a Account record, include attachment, checkbox, currency, Date, etc:
	#
	#1. Click on the ‘New Field’ button.2. Enter a name in the ‘Field Label’, i.e. Account Name.3. Select the appropriate Type for the new field, i.e. Text.4. Select the appropriate ‘Mapped Object Field’ the chosen field, i.e. Account Name.5. Repeat steps 1 - 4 until other Field types available.Expected Result:
	#
	#The new Fields should be created without issue.3. 1. Click the ‘Exit’ button on the Form Builder page.Expected Result:
	#
	#Should be returned to the Form Detail page.4. 1. In another browser tab, log into the community portal.Expected Result:
	#
	#Should be able to log in to the community portal without issue.5. 1. Return to the tab with the Form Detail page displayed.2. Copy the Form URL into a different tab in the same browser used to log into the community portal. See Note below.3. Hit return on the keyboard or refresh the page.
	#
	#Note: If testing in an integration org, change cpbase to cpbase8 within the copied URL.Expected Result:
	#
	#The form should be displayed without issue.
	#
	#Since the user is logged into the community portal, the form fields should be pre-filled with current information for the record you are updating, if those fields currently have data.6. 1. Enter new information into every field within the form.2. Hit the Submit button.Expected Result:
	#
	#User should be able to update all fields in the form
	#
	#The form should be submitted without issue.7. 1. Return to the tab with the Form Detail page displayed.2. Navigate to or search for the existing record that was being updated, i.e. the Account associated with the portal user.3. Verify that all fields updated in the form have been updated in the record with the the new values.Expected Result:
	#
	#The record should be updated with all entries that were changed in the form.EXPECTED RESULTS:
	#
	#ALTERNATE FLOW(S):

	#Tests STEPS:
	#
	#1. Create a Field Group using a usr.AccountId Standard Dynamic variable in the SOQL Filter.
	#
	#1. Click on the 'New Field Group' button.2. Enter a Field Group Name, i.e. Account Info.3. Select an option for the ‘Mapped Object Field’, i.e. Account.4. Enter the following into the SOQL Filter field : Id = 'usr.AccountId'5. Select ‘Upsert’ under Database Operations.6. Click on the Save button.Expected Result:
	#
	#Should be able to create a new field group using the an ID pointing to usr.AccountId in the SOQL filter without issue.2. Create a field for every field type available within a Account record, include attachment, checkbox, currency, Date, etc:
	#
	#1. Click on the ‘New Field’ button.2. Enter a name in the ‘Field Label’, i.e. Account Name.3. Select the appropriate Type for the new field, i.e. Text.4. Select the appropriate ‘Mapped Object Field’ the chosen field, i.e. Account Name.5. Repeat steps 1 - 4 until other Field types available.Expected Result:
	#
	#The new Fields should be created without issue.3. 1. Click the ‘Exit’ button on the Form Builder page.Expected Result:
	#
	#Should be returned to the Form Detail page.4. 1. In another browser tab, log into the community portal.Expected Result:
	#
	#Should be able to log in to the community portal without issue.5. 1. Return to the tab with the Form Detail page displayed.2. Copy the Form URL into a different tab in the same browser used to log into the community portal. See Note below.3. Hit return on the keyboard or refresh the page.
	#
	#Note: If testing in an integration org, change cpbase to cpbase8 within the copied URL.Expected Result:
	#
	#The form should be displayed without issue.
	#
	#Since the user is logged into the community portal, the form fields should be pre-filled with current information for the record you are updating, if those fields currently have data.6. 1. Enter new information into every field within the form.2. Hit the Submit button.Expected Result:
	#
	#User should be able to update all fields in the form
	# 
	#The form should be submitted without issue.7. 1. Return to the tab with the Form Detail page displayed.2. Navigate to or search for the existing record that was being updated, i.e. the Account associated with the portal user.3. Verify that all fields updated in the form have been updated in the record with the the new values.Expected Result:
	#
	#The record should be updated with all entries that were changed in the form.EXPECTED RESULTS:
	#
	#ALTERNATE FLOW(S):
	@TEST_PD-29567 @REQ_PD-29566 @regression @21Winter @22Winter @uday
	Scenario: Test Updating every type of field within a record using a standard dynamic variable 
		Given User navigate to community Portal page with "jacksonfernandez@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User opens "AutoTestForm AccountName" form page
		And User validate the auto populated fields on form with account details for contact "Jackson Fernandez"
		Then User fills and submits the form and verifies details in Account are updated
