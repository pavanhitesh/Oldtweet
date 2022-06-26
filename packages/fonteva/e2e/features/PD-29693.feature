@REQ_PD-29693
Feature: Submit form with Multipicklist field when Is Required is not enabled
	#STEPS:1. In the Form Builder, click on the Edit icon for the 'Multipicklist' type field.2. Disable the 'Is Required' option if the option is currently enabled.3. Click on the Save button within the 'Edit Field' modal.4. Click on the Preview button on the Form Builder page.1. Select a value for the multipicklist field5. Click on the Submit button 6. Click on 'Back To Form Builder' button.7. Click on the Exit button.8. Scroll down to the Form Responses section on the Form Detail page.9. Click on the Response ID for the new form response.
	#
	#EXPECTED RESULTS:
	#
	#If the Field was setup without checking the "Is Required" field, the form response should be submitted successfully.
	#
	#A new form response record should be created under the Form Responses section on the Form Detail page.
	#
	#The Response field under 'Field Responses' section on the Form Response Detail page should contain the value that was entered by user in to the field before submission.ALTERNATE FLOW(S):

	#Tests STEPS:1. In the Form Builder, click on the Edit icon for the 'Multipicklist' type field.2. Disable the 'Is Required' option if the option is currently enabled.3. Click on the Save button within the 'Edit Field' modal.4. Click on the Preview button on the Form Builder page.1. Select a value for the multipicklist field5. Click on the Submit button 6. Click on 'Back To Form Builder' button.7. Click on the Exit button.8. Scroll down to the Form Responses section on the Form Detail page.9. Click on the Response ID for the new form response.
	#
	#EXPECTED RESULTS:
	#
	#If the Field was setup without checking the "Is Required" field, the form response should be submitted successfully.
	#
	#A new form response record should be created under the Form Responses section on the Form Detail page.
	#
	#The Response field under 'Field Responses' section on the Form Response Detail page should contain the value that was entered by user in to the field before submission.ALTERNATE FLOW(S):
	@TEST_PD-29694 @REQ_PD-29693 @regression @21Winter @22Winter @lakshmi
	Scenario Outline: Test Submit form with Multipicklist field when Is Required is not enabled
		Given User create a form "delete_AutoMultipicklist"
			| formGroupName             | formFieldName | formFieldType | isRequired         | options                            |
			| Multipicklist Validations | Multipicklist | Multipicklist | <IsRequiredStatus> | Option1\nOption2\nOption3\nOption4 |
		When User navigate to community Portal page with "davidjackson@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User opens "delete_AutoMultipicklist" form page
		Then User submits the created form and validates the response when IsRequired is "<IsRequiredStatus>" and value is "<value>"
		Examples:
			| IsRequiredStatus | value           |
			| false            | No              |
			| false            | Option1         |
			| false            | Option1,Option3 |
			| true             | No              |

