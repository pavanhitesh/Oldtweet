@REQ_PD-29653
Feature: Submit the form with Phone number field as required and not required
	#PRE-CONDITIONS:
	#\[C16519] Create a New Field with Field Type Phone
	#STEPS:
	#
	## In the Form Builder, click on the Edit icon for the 'Phone' type field.
	## Disable the 'Is Required' option if the option is currently enabled.
	## Click on the Save button within the 'Edit Field' modal.
	## Open the form URL on LT portal.
	## Click on the Submit button.
	## Verify the form responses on back end.
	## Scroll down to the Form Responses section on the Form Detail page.
	## Click on the Response ID for the new form response.
	#
	#EXPECTED RESULTS:
	#
	#* If the Field was setup without checking the "Is Required" field, the form response should be submitted successfully.
	#* A new form response record should be created under the Form Responses section on the Form Detail page.
	#* The Response field under 'Field Responses' section on the Form Response Detail page should be empty if no input was entered in to the field before submission.
	#
	#C89766
	#
	#PRE-CONDITIONS:
	#\[C16519] Create a New Field with Field Type Phone
	#STEPS:
	#
	## Open the form URL on LT portal.
	## Enter a valid phone number into the phone field.
	## Submit the form.
	## Verify the form responses on back end.
	## Scroll down to the Form Responses section on the Form Detail page.
	## Click on the Response ID for the new form response.
	#
	#EXPECTED RESULTS:
	#
	#* The Form should be submitted successfully.
	#* A new form response record should be created under the Form Responses section on the Form Detail page.
	#* The Response field under the 'Field Responses' section on the Form Response Detail page should contain the value that was inputted in the form when submitted.
	#ALTERNATE FLOW(S):
	#
	#PRE-CONDITIONS:
	#\[C16519] Create a New Field with Field Type Phone
	#STEPS:
	#
	## In the Form Builder, click on the Edit icon for the 'Phone' type field.
	#
	## Enable the 'Is Required' option if the option is currently disabled.
	#
	## Click on the Save button within the 'Edit Field' modal.
	#
	## Open the form URL on LT portal.
	#
	## Click on the Submit button.
	#
	## Verify the form responses on back end.
	#
	## Scroll down to the Form Responses section on the Form Detail page.
	#
	#EXPECTED RESULTS:
	#
	#* If the Field was setup with the "Is Required" enable , the form response should NOT be submitted.
	#* UI should present an appropriate error message.
	#* A new form response record should not be created under the Form Responses section on the Form Detail page.

	#Tests PRE-CONDITIONS:
	#\[C16519] Create a New Field with Field Type Phone
	#STEPS:
	#
	## In the Form Builder, click on the Edit icon for the 'Phone' type field.
	## Disable the 'Is Required' option if the option is currently enabled.
	## Click on the Save button within the 'Edit Field' modal.
	## Open the form URL on LT portal.
	## Click on the Submit button.
	## Verify the form responses on back end.
	## Scroll down to the Form Responses section on the Form Detail page.
	## Click on the Response ID for the new form response.
	#
	#EXPECTED RESULTS:
	#
	#* If the Field was setup without checking the "Is Required" field, the form response should be submitted successfully.
	#* A new form response record should be created under the Form Responses section on the Form Detail page.
	#* The Response field under 'Field Responses' section on the Form Response Detail page should be empty if no input was entered in to the field before submission.
	#
	#C89766
	#
	#PRE-CONDITIONS:
	#\[C16519] Create a New Field with Field Type Phone
	#STEPS:
	#
	## Open the form URL on LT portal.
	## Enter a valid phone number into the phone field.
	## Submit the form.
	## Verify the form responses on back end.
	## Scroll down to the Form Responses section on the Form Detail page.
	## Click on the Response ID for the new form response.
	#
	#EXPECTED RESULTS:
	#
	#* The Form should be submitted successfully.
	#* A new form response record should be created under the Form Responses section on the Form Detail page.
	#* The Response field under the 'Field Responses' section on the Form Response Detail page should contain the value that was inputted in the form when submitted.
	#ALTERNATE FLOW(S):
	#
	#PRE-CONDITIONS:
	#\[C16519] Create a New Field with Field Type Phone
	#STEPS:
	#
	## In the Form Builder, click on the Edit icon for the 'Phone' type field.
	#
	## Enable the 'Is Required' option if the option is currently disabled.
	#
	## Click on the Save button within the 'Edit Field' modal.
	#
	## Open the form URL on LT portal.
	#
	## Click on the Submit button.
	#
	## Verify the form responses on back end.
	#
	## Scroll down to the Form Responses section on the Form Detail page.
	#
	#EXPECTED RESULTS:
	#
	#* If the Field was setup with the "Is Required" enable , the form response should NOT be submitted.
	#* UI should present an appropriate error message.
	#* A new form response record should not be created under the Form Responses section on the Form Detail page.

	@TEST_PD-29654 @REQ_PD-29653 @regression @21Winter @22Winter @Lakshman
	Scenario Outline: Test Submit the form responding to Phone Number field
		Given User create a form "delete_AutoPhoneTypeRequiredForm"
			| formGroupName | formFieldName | formFieldType | isRequired         |
			| Contact info  | Phone Number  | Phone         | <IsRequiredStatus> |
		When User navigate to community Portal page with "jacksonfernandez@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User opens "delete_AutoPhoneTypeRequiredForm" form page
		Then User submits the form with Phone Number "<PhoneNumber>" and validates the response
		Examples:
			| IsRequiredStatus | PhoneNumber |
			| true             | YES         |
			| true             | NA          |
			| false            | YES         |
			| false            | NA          |
