@REQ_PD-29704
Feature: Submit the form with data in Percent field for validations
	#Manually enter a value > 100
	#
	#C89788
	#
	#PRE-CONDITIONS:
	#\[C16518] Create a New Field with Field Type Percent
	#STEPS:
	#
	## Click on the Preview button on the Form Builder page.
	## Manually enter a value greater than 100 in the Percent Field, i.e. 120.
	## Submit the form.
	## Click on 'Back To Form Builder' button.
	## Click on the Exit button.
	## Scroll down to the Form Responses section on the Form Detail page.
	#
	#EXPECTED RESULTS:
	#
	#* User should not be able to submit the form when using a number greater than 100 in the percent field.
	#* UI should present an appropriate validation error message.
	#* A new form response record should not be created under the Form Responses section on the Form Detail page.
	#
	#
	#
	#Manually enter a value < 0
	#
	#C89789
	#
	#PRE-CONDITIONS:
	#\[C16518] Create a New Field with Field Type Percent
	#STEPS:
	#
	## Click on the Preview button on the Form Builder page.
	## Manually enter a value less than 0 in the Percent Field, i.e. -10.
	## Submit the form.
	## Click on 'Back To Form Builder' button.
	## Click on the Exit button.
	## Scroll down to the Form Responses section on the Form Detail page.
	#
	#EXPECTED RESULTS:
	#
	#* User should not be able to submit the form when using a number greater than 100 in the percent field.
	#* UI should present an appropriate validation error message.
	#* A new form response record should not be created under the Form Responses section on the Form Detail page.
	#
	#
	#
	#Enter invalid characters as a value for the Percent field
	#
	#C89790
	#
	#PRE-CONDITIONS:
	#\[C16518] Create a New Field with Field Type Percent
	#STEPS:
	#
	## Click on the Preview button on the Form Builder page.
	## Manually enter invalid characters, such as letter or special characters, into the Number field, i.e. 'six' or %\{\[*?/
	## Submit the form.
	## Click on 'Back To Form Builder' button.
	## Click on the Exit button.
	## Scroll down to the Form Responses section on the Form Detail page.
	#
	#EXPECTED RESULTS:
	#
	#* User should not be able to submit the form when using using any invalid characters including letters or special characters (only integer numbers between 0 and 100 are valid).
	#* UI should present an appropriate validation error message.
	#** A new form response record should not be created under the Form Responses section on the Form Detail page.
	#
	#
	#
	#Manually enter a valid value and submit a response
	#
	#C89785
	#
	#PRE-CONDITIONS:
	#\[C16518] Create a New Field with Field Type Percent
	#STEPS:
	#
	## Click on the Preview button on the Form Builder page.
	## Manually enter a valid decimal number (integer between 0 - 100) into the Percent field, i.e. 25.
	## Submit the form.
	## Click on 'Back To Form Builder' button.
	## Click on the Exit button.
	## Scroll down to the Form Responses section on the Form Detail page.
	## Click on the Response ID for the new form response.
	#
	#EXPECTED RESULTS:
	#
	#* The Form should be submitted successfully.
	#* A new form response record should be created under the Form Responses section on the Form Detail page.
	#* The Response field under the 'Field Responses' section on the Form Response Detail page should contain the value that was inputted in the form when submitted.
	#
	#
	#
	#Submit without adding a value to percent field when Is Required is not enabled
	#
	#C89784
	#
	#PRE-CONDITIONS:
	#\[C16518] Create a New Field with Field Type Percent
	#STEPS:
	#
	## In the Form Builder, click on the Edit icon for the 'Percent' type field.
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
	#
	#* If the Field was setup without checking the "Is Required" field, the form response should be submitted successfully.
	#* A new form response record should be created under the Form Responses section on the Form Detail page.
	#* The Response field under 'Field Responses' section on the Form Response Detail page should be empty if no input was entered in to the field before submission.

	#Tests Manually enter a value > 100
	#
	#C89788
	#
	#PRE-CONDITIONS:
	#\[C16518] Create a New Field with Field Type Percent
	#STEPS:
	#
	## Click on the Preview button on the Form Builder page.
	## Manually enter a value greater than 100 in the Percent Field, i.e. 120.
	## Submit the form.
	## Click on 'Back To Form Builder' button.
	## Click on the Exit button.
	## Scroll down to the Form Responses section on the Form Detail page.
	#
	#EXPECTED RESULTS:
	#
	#* User should not be able to submit the form when using a number greater than 100 in the percent field.
	#* UI should present an appropriate validation error message.
	#* A new form response record should not be created under the Form Responses section on the Form Detail page.
	#
	#
	#
	#Manually enter a value < 0
	#
	#C89789
	#
	#PRE-CONDITIONS:
	#\[C16518] Create a New Field with Field Type Percent
	#STEPS:
	#
	## Click on the Preview button on the Form Builder page.
	## Manually enter a value less than 0 in the Percent Field, i.e. -10.
	## Submit the form.
	## Click on 'Back To Form Builder' button.
	## Click on the Exit button.
	## Scroll down to the Form Responses section on the Form Detail page.
	#
	#EXPECTED RESULTS:
	#
	#* User should not be able to submit the form when using a number greater than 100 in the percent field.
	#* UI should present an appropriate validation error message.
	#* A new form response record should not be created under the Form Responses section on the Form Detail page.
	#
	#
	#
	#Enter invalid characters as a value for the Percent field
	#
	#C89790
	#
	#PRE-CONDITIONS:
	#\[C16518] Create a New Field with Field Type Percent
	#STEPS:
	#
	## Click on the Preview button on the Form Builder page.
	## Manually enter invalid characters, such as letter or special characters, into the Number field, i.e. 'six' or %\{\[*?/
	## Submit the form.
	## Click on 'Back To Form Builder' button.
	## Click on the Exit button.
	## Scroll down to the Form Responses section on the Form Detail page.
	#
	#EXPECTED RESULTS:
	#
	#* User should not be able to submit the form when using using any invalid characters including letters or special characters (only integer numbers between 0 and 100 are valid).
	#* UI should present an appropriate validation error message.
	#** A new form response record should not be created under the Form Responses section on the Form Detail page.
	#
	#
	#
	#Manually enter a valid value and submit a response
	#
	#C89785
	#
	#PRE-CONDITIONS:
	#\[C16518] Create a New Field with Field Type Percent
	#STEPS:
	#
	## Click on the Preview button on the Form Builder page.
	## Manually enter a valid decimal number (integer between 0 - 100) into the Percent field, i.e. 25.
	## Submit the form.
	## Click on 'Back To Form Builder' button.
	## Click on the Exit button.
	## Scroll down to the Form Responses section on the Form Detail page.
	## Click on the Response ID for the new form response.
	#
	#EXPECTED RESULTS:
	#
	#* The Form should be submitted successfully.
	#* A new form response record should be created under the Form Responses section on the Form Detail page.
	#* The Response field under the 'Field Responses' section on the Form Response Detail page should contain the value that was inputted in the form when submitted.
	#
	#
	#
	#Submit without adding a value to percent field when Is Required is not enabled
	#
	#C89784
	#
	#PRE-CONDITIONS:
	#\[C16518] Create a New Field with Field Type Percent
	#STEPS:
	#
	## In the Form Builder, click on the Edit icon for the 'Percent' type field.
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
	#
	#* If the Field was setup without checking the "Is Required" field, the form response should be submitted successfully.
	#* A new form response record should be created under the Form Responses section on the Form Detail page.
	#* The Response field under 'Field Responses' section on the Form Response Detail page should be empty if no input was entered in to the field before submission.
	@TEST_PD-29717 @REQ_PD-29704 @regression @21Winter @22Winter @Lakshman
	Scenario Outline: Test Submit the form with data in Percent field for validations
		Given User create a form "delete_AutoPercentform"
			| formGroupName          | formFieldName | formFieldType | isRequired   |
			| Percentage Validations | Percentage    | Percent       | <isRequired> |
		And User navigate to community Portal page with "jacksonfernandez@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User opens "delete_AutoPercentform" form page
		Then User enter the Percent value "<percentValue>" and Submit the form and verify response
		Examples:
			| isRequired | percentValue |
			| true       | 88           |
			| true       |              |
			| false      |              |
			| false      | 77           |
			| true       | -10          |
			| true       | 120          |
			| true       | $%&*         |
