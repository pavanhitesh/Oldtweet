@REQ_PD-29682
Feature: Submit form with email field as required and non required
	#[C16514] Create a New Field with Field Type Email
	#STEPS:
	#1. In the Form Builder, click on the Edit icon for the 'Email' type field.
	#2. Enable the 'Is Required' option if the option is currently disabled.
	#3. Click on the Save button within the 'Edit Field' modal.
	#4. Click on the Preview button on the Form Builder page.
	#5. Click on the Submit button.
	#6. Click on 'Back To Form Builder' button.
	#7. Click on the Exit button.
	#8. Scroll down to the Form Responses section on the Form Detail page.
	#
	#EXPECTED RESULTS:
	#
	#If the Field was setup with the "Is Required" enable , the form response should NOT be submitted.
	#
	#UI should present an appropriate error message.
	#
	#A new form response record should not be created under the Form Responses section on the Form Detail page.
	#
	#PRE-CONDITIONS:[C16514] Create a New Field with Field Type Email
	#STEPS:
	#1. Click on the Preview button on the Form Builder page.
	#2. Click on the Email field.
	#3. Enter an invalid email into the Email field of the Form.
	#4. Click on the Submit button.
	#5. Click on 'Back To Form Builder' button.
	#6. Click on the Exit button.
	#7. Scroll down to the Form Responses section on the Form Detail page.
	#
	#EXPECTED RESULTS:
	#
	#User should not be able to enter an invalid email.
	#
	#UI should present an appropriate validation error message.
	#
	#A new form response record should not be created under the Form Responses section on the Form Detail page.
	#
	#[C16514] Create a New Field with Field Type Email
	#STEPS:
	#1. In the Form Builder, click on the Edit icon for the 'Email' type field.
	#2. Disable the 'Is Required' option if the option is currently enabled.
	#3. Click on the Save button within the 'Edit Field' modal.
	#4. Click on the Preview button on the Form Builder page.
	#5. Click on the Submit button.
	#6. Click on 'Back To Form Builder' button.
	#7. Click on the Exit button.
	#8. Scroll down to the Form Responses section on the Form Detail page.
	#9. Click on the Response ID for the new form response.
	#
	#EXPECTED RESULTS:
	#
	#If the Field was setup without checking the "Is Required" field, the form response should be submitted successfully.
	#
	#A new form response record should be created under the Form Responses section on the Form Detail page.
	#
	#The Response field under 'Field Responses' section on the Form Response Detail page should be empty if no input was entered in to the field before submission.
	#
	#[C16514] Create a New Field with Field Type Email
	#STEPS:
	#1. Click on the Preview button on the Form Builder page.
	#2. Enter a valid Email address into the Email field.
	#3. Submit the form.
	#4. Click on 'Back To Form Builder' button.
	#5. Click on the Exit button.
	#6. Scroll down to the Form Responses section on the Form Detail page.
	#7. Click on the Response ID for the new form response.
	#
	#1. Navigate to the form created
	#1. Click Form Builder
	#1. Click Preview
	#1. Enter a valid email into the eMail Field on the Form
	#1. Submit the Form
	#
	#EXPECTED RESULTS:
	#
	#The Form should be submitted successfully.
	#
	#A new form response record should be created under the Form Responses section on the Form Detail page.
	#
	#The Response field under the 'Field Responses' section on the Form Response Detail page should contain the value that was inputted in the form when submitted.

	#Tests [C16514] Create a New Field with Field Type Email
	#STEPS:
	#1. In the Form Builder, click on the Edit icon for the 'Email' type field.
	#2. Enable the 'Is Required' option if the option is currently disabled.
	#3. Click on the Save button within the 'Edit Field' modal.
	#4. Click on the Preview button on the Form Builder page.
	#5. Click on the Submit button.
	#6. Click on 'Back To Form Builder' button.
	#7. Click on the Exit button.
	#8. Scroll down to the Form Responses section on the Form Detail page.
	#
	#EXPECTED RESULTS:
	#
	#If the Field was setup with the "Is Required" enable , the form response should NOT be submitted.
	#
	#UI should present an appropriate error message.
	#
	#A new form response record should not be created under the Form Responses section on the Form Detail page.
	#
	#PRE-CONDITIONS:[C16514] Create a New Field with Field Type Email
	#STEPS:
	#1. Click on the Preview button on the Form Builder page.
	#2. Click on the Email field.
	#3. Enter an invalid email into the Email field of the Form.
	#4. Click on the Submit button.
	#5. Click on 'Back To Form Builder' button.
	#6. Click on the Exit button.
	#7. Scroll down to the Form Responses section on the Form Detail page.
	#
	#EXPECTED RESULTS:
	#
	#User should not be able to enter an invalid email.
	#
	#UI should present an appropriate validation error message.
	#
	#A new form response record should not be created under the Form Responses section on the Form Detail page.
	#
	#[C16514] Create a New Field with Field Type Email
	#STEPS:
	#1. In the Form Builder, click on the Edit icon for the 'Email' type field.
	#2. Disable the 'Is Required' option if the option is currently enabled.
	#3. Click on the Save button within the 'Edit Field' modal.
	#4. Click on the Preview button on the Form Builder page.
	#5. Click on the Submit button.
	#6. Click on 'Back To Form Builder' button.
	#7. Click on the Exit button.
	#8. Scroll down to the Form Responses section on the Form Detail page.
	#9. Click on the Response ID for the new form response.
	#
	#EXPECTED RESULTS:
	#
	#If the Field was setup without checking the "Is Required" field, the form response should be submitted successfully.
	#
	#A new form response record should be created under the Form Responses section on the Form Detail page.
	#
	#The Response field under 'Field Responses' section on the Form Response Detail page should be empty if no input was entered in to the field before submission.
	#
	#[C16514] Create a New Field with Field Type Email
	#STEPS:
	#1. Click on the Preview button on the Form Builder page.
	#2. Enter a valid Email address into the Email field.
	#3. Submit the form.
	#4. Click on 'Back To Form Builder' button.
	#5. Click on the Exit button.
	#6. Scroll down to the Form Responses section on the Form Detail page.
	#7. Click on the Response ID for the new form response.
	#
	#1. Navigate to the form created
	#1. Click Form Builder
	#1. Click Preview
	#1. Enter a valid email into the eMail Field on the Form
	#1. Submit the Form
	#
	#EXPECTED RESULTS:
	#
	#The Form should be submitted successfully.
	#
	#A new form response record should be created under the Form Responses section on the Form Detail page.
	#
	#The Response field under the 'Field Responses' section on the Form Response Detail page should contain the value that was inputted in the form when submitted.
	@TEST_PD-29683 @REQ_PD-29682 @22Winter @21Winter @ninjety @regression
	Scenario Outline: Test Submit form with email field as required and non required validations
		Given User create a form "delete_AutoEmailform"
			| formGroupName     | formFieldName | formFieldType | isRequired   |
			| Email Validations | Email         | Email         | <isRequired> |
		When User navigate to community Portal page with "rosebrixton@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User opens "delete_AutoEmailform" form page
		Then User submits the form with Email value as "<validEmail>" and validates the Response
		Examples:
			| isRequired | validEmail |
			| true       | NA         |
			| false      | true       |
			| false      | NA         |
			| false      | false      |
			| true       | true       |


