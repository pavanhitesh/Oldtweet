@REQ_PD-29796
Feature: Verify form response for Submit Style URL
	#C89848
	#
	#PRE-CONDITIONS:[C16523] Create a New Field with Field Type TextSTEPS:1. Navigate to the Form Detail page for the created form (if still in the Form Builder, click on Exit).2. On the Form Details page, click on the Edit button.3. Change the Submit Style to 'URL'.4. Enter any complete URL into the 'Submit Value' field, i.e. http://www.google.com.5. Click on the Save button.6. Click on the Form Builder button.7. Click on the Preview button.8. Enter values into the field(s).9. Click on the Submit button.
	#
	#EXPECTED RESULTS:
	#
	#Should be able to edit the Submit Style and Submit value and Save the Form without issue.
	#
	#Should be able to enter values in to the form and hit the Submit button without issue.
	#
	#After submitting the form, the user should be navigated to the URL that was entered into the Submit Value field.ALTERNATE FLOW(S):

	#Tests C89848
	#
	#PRE-CONDITIONS:[C16523] Create a New Field with Field Type TextSTEPS:1. Navigate to the Form Detail page for the created form (if still in the Form Builder, click on Exit).2. On the Form Details page, click on the Edit button.3. Change the Submit Style to 'URL'.4. Enter any complete URL into the 'Submit Value' field, i.e. http://www.google.com.5. Click on the Save button.6. Click on the Form Builder button.7. Click on the Preview button.8. Enter values into the field(s).9. Click on the Submit button.
	#
	#EXPECTED RESULTS:
	#
	#Should be able to edit the Submit Style and Submit value and Save the Form without issue.
	#
	#Should be able to enter values in to the form and hit the Submit button without issue.
	#
	#After submitting the form, the user should be navigated to the URL that was entered into the Submit Value field.ALTERNATE FLOW(S):
	@TEST_PD-29797 @REQ_PD-29796 @regression @21Winter @22Winter @uday
	Scenario: Test Verify form response for Submit Style URL
		Given User create a form "delete_AutoTextForm"
			| formGroupName | formFieldName | formFieldType | isRequired |
			| Account Info  | Account Name  | Text          | true       |
		And User update the submit style and submit value for the created form
			| submitStyle | submitValue             |
			| URL         | https://www.google.com/ |
		When User navigate to community Portal page with "jacksonfernandez@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User opens "delete_AutoTextForm" form page
		Then User fills and submits the created form and validates whether user is navigated to different page as in submitValue


