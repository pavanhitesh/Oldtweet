@REQ_PD-29755
Feature: Submit without responding to Picklist field when Is Required is not enabled
	#STEPS:1. In the Form Builder, click on the Edit icon for the 'Picklist' type field.2. Disable the 'Is Required' option if the option is currently enabled.3. Click on the Save button within the 'Edit Field' modal.4. Click on the Preview button on the Form Builder page.5. Click on the Submit button (without selecting any of the option from the Picklist).6. Click on 'Back To Form Builder' button.7. Click on the Exit button.8. Scroll down to the Form Responses section on the Form Detail page.9. Click on the Response ID for the new form response.
	#
	#EXPECTED RESULTS:
	#
	#If the Field was setup without checking the "Is Required" field, the form response should be submitted successfully.
	#
	#A new form response record should be created under the Form Responses section on the Form Detail page.
	#
	#The Response field under 'Field Responses' section on the Form Response Detail page should be empty if no input was entered in to the field before submission.ALTERNATE FLOW(S):

	#Tests STEPS:1. In the Form Builder, click on the Edit icon for the 'Picklist' type field.2. Disable the 'Is Required' option if the option is currently enabled.3. Click on the Save button within the 'Edit Field' modal.4. Click on the Preview button on the Form Builder page.5. Click on the Submit button (without selecting any of the option from the Picklist).6. Click on 'Back To Form Builder' button.7. Click on the Exit button.8. Scroll down to the Form Responses section on the Form Detail page.9. Click on the Response ID for the new form response.
	#
	#EXPECTED RESULTS:
	#
	#If the Field was setup without checking the "Is Required" field, the form response should be submitted successfully.
	#
	#A new form response record should be created under the Form Responses section on the Form Detail page.
	#
	#The Response field under 'Field Responses' section on the Form Response Detail page should be empty if no input was entered in to the field before submission.ALTERNATE FLOW(S):
	@TEST_PD-29756 @REQ_PD-29755 @regression @21Winter @22Winter @lakshmi
	Scenario: Test Submit without responding to Picklist field when Is Required is not enabled
		Given User create a form "delete_AutoPicklist"
			| formGroupName        | formFieldName | formFieldType | isRequired         | options                                                       |
			| Picklist Validations | Picklist      | Picklist      | <IsRequiredStatus> | Personal Greeting\nFormal Greeting\nPersonal Recognition Name |
		When User navigate to community Portal page with "davidjackson@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User opens "delete_AutoPicklist" form page
		Then User submits the created form and validates the response when IsRequiredStatus is "<IsRequiredStatus>" and value is "<value>"
		Examples:
			| IsRequiredStatus | value             |
			| true             | No                |
			| false            | No                |
			| false            | Personal Greeting |

