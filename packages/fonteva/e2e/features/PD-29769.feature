@REQ_PD-29769
Feature: Submit the form for Checkbox field validations and verify the response.
	#C89841
	#
	#PRE-CONDITIONS:\[C16509] Create a New Field with Field Type CheckboxSTEPS:
	#
	## In the Form Builder, click on the Edit icon for the 'Checkbox' type field.
	## Enable the 'Is Required' option.
	## Click on the Save button within the 'Edit Field' modal.
	## Click on the Preview button on the Form Builder page.
	## Click on the Submit button.
	## Click on 'Back To Form Builder' button.
	## Click on the Exit button.
	## Scroll down to the Form Responses section on the Form Detail page.
	## Click on the Response ID for the new form response.
	#
	#EXPECTED RESULTS:-If the Field was setup with the "Is Required" enabled, the form response should NOT be submitted.-UI should present an appropriate error message ("This value is required.")-A new form response record should not be created under the Form Responses section on the Form Detail page.
	#
	#C89840
	#
	#PRE-CONDITIONS:\[C16509] Create a New Field with Field Type CheckboxSTEPS:
	#
	## In the Form Builder, click on the Edit icon for the 'Checkbox' type field.
	## Disable the 'Is Required' option if the option is currently enabled.
	## Click on the Save button within the 'Edit Field' modal.
	## Click on the Preview button on the Form Builder page.
	## Click on the Submit button.
	## Click on 'Back To Form Builder' button.
	## Click on the Exit button.
	## Scroll down to the Form Responses section on the Form Detail page.
	## Click on the Response ID for the new form response.
	## EXPECTED RESULTS:-If the Field was setup without checking the "Is Required" field, the form response should be submitted-Form response record should be submitted.-value for the checkbox field is marked false.

	#Tests C89841
	#
	#PRE-CONDITIONS:
	#\[C16509] Create a New Field with Field Type Checkbox
	#STEPS:
	#
	## In the Form Builder, click on the Edit icon for the 'Checkbox' type field.
	## Enable the 'Is Required' option.
	## Click on the Save button within the 'Edit Field' modal.
	## Click on the Preview button on the Form Builder page.
	## Click on the Submit button.
	## Click on 'Back To Form Builder' button.
	## Click on the Exit button.
	## Scroll down to the Form Responses section on the Form Detail page.
	## Click on the Response ID for the new form response.
	#
	#EXPECTED RESULTS:
	#-If the Field was setup with the "Is Required" enabled, the form response should NOT be submitted.
	#-UI should present an appropriate error message ("This value is required.")
	#-A new form response record should not be created under the Form Responses section on the Form Detail page.
	#
	#
	#
	#
	#
	#
	#
	#C89840
	#
	#PRE-CONDITIONS:
	#\[C16509] Create a New Field with Field Type Checkbox
	#STEPS:
	#
	## In the Form Builder, click on the Edit icon for the 'Checkbox' type field.
	## Disable the 'Is Required' option if the option is currently enabled.
	## Click on the Save button within the 'Edit Field' modal.
	## Click on the Preview button on the Form Builder page.
	## Click on the Submit button.
	## Click on 'Back To Form Builder' button.
	## Click on the Exit button.
	## Scroll down to the Form Responses section on the Form Detail page.
	## Click on the Response ID for the new form response.
	#
	#EXPECTED RESULTS:
	#-If the Field was setup without checking the "Is Required" field, the form response should be submitted
	#-Form response record should be submitted.
	#-value for the checkbox field is marked false.
	@TEST_PD-29719 @REQ_PD-29769 @regression @21Winter @22Winter @Lakshman
	Scenario Outline: Test Submitting the form with Checkbox Field and Verify the response saved
		Given User create a form "delete_AutoCheckboxform"
			| formGroupName        | formFieldName | formFieldType | isRequired   |
			| CheckBox Validations | Checkbox      | Checkbox      | <isRequired> |
		When User navigate to community Portal page with "jacksonfernandez@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User opens "delete_AutoCheckboxform" form page
		Then User set the Checkbox as "<setCheckbox>" and Submit the form and verify response
		Examples:
			| isRequired | setCheckbox |
			| false      | OFF         |
			| true       | OFF         |
			| true       | ON          |
			| false      | ON          |
			


