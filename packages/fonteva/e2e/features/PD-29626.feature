@REQ_PD-29626
Feature: Submit without responding to URL field when Is Required is enabled
	#Create a New Field with Field Type URL
	#STEPS:
	#1. In the Form Builder, click on the Edit icon for the 'URL' type field.
	#2. Enable the 'Is Required' option if the option is currently disabled.
	#3. Click on the Save button within the 'Edit Field' modal.
	#4. Click on the Preview button on the Form Builder page.
	#5. Click on the Submit button.
	#6. Click on 'Back To Form Builder' button.
	#7. Click on the Exit button.
	#8. Scroll down to the Form Responses section on the Form Detail page
	#EXPECTED RESULTS:
	#• If the Field was setup with the "Is Required" enable , the form response should NOT be submitted.
	#• UI should present an appropriate error message.
	#A new form response record should not be created under the Form Responses section on the Form Detail page.

	#Tests Create a New Field with Field Type URL
	#STEPS:
	#1. In the Form Builder, click on the Edit icon for the 'URL' type field.
	#2. Enable the 'Is Required' option if the option is currently disabled.
	#3. Click on the Save button within the 'Edit Field' modal.
	#4. Click on the Preview button on the Form Builder page.
	#5. Click on the Submit button.
	#6. Click on 'Back To Form Builder' button.
	#7. Click on the Exit button.
	#8. Scroll down to the Form Responses section on the Form Detail page
	#EXPECTED RESULTS:
	#• If the Field was setup with the "Is Required" enable , the form response should NOT be submitted.
	#• UI should present an appropriate error message.
	#A new form response record should not be created under the Form Responses section on the Form Detail page.
	@TEST_PD-29627 @REQ_PD-29626 @regression @21Winter @22Winter @niklesh
	Scenario Outline: Test Submit without responding to URL field
		Given User create a form "delete_AutoURLFieldForm"
			| formGroupName | formFieldName | formFieldType | isRequired         |
			| URL Group     | URL Field     | URL           | <IsRequiredStatus> |
		When User navigate to community Portal page with "brandlarson@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User opens "delete_AutoURLFieldForm" form page
		Then User submits the created form and validates the response when isRequired option is "<IsRequiredStatus>"
		Examples:
			| IsRequiredStatus |
			| true             |
			| false            |
