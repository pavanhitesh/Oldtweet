@REQ_PD-29728
Feature: Enter text and submit for 'Text' field type
	#C89801
	#
	#PRE-CONDITIONS:[C16523] Create a New Field with Field Type TextSTEPS:1. Click on the Preview button on the Form Builder page.2. Enter any text into the Text field.3. Submit the form.4. Click on 'Back To Form Builder' button.5. Click on the Exit button.6. Scroll down to the Form Responses section on the Form Detail page.7. Click on the Response ID for the new form response.
	#
	#EXPECTED RESULTS:
	#
	#The Form should be submitted successfully.
	#
	#A new form response record should be created under the Form Responses section on the Form Detail page.
	#
	#The Response field under the 'Field Responses' section on the Form Response Detail page should contain the value that was inputted in the form when submitted.ALTERNATE FLOW(S):

	#Tests C89801
	#
	#PRE-CONDITIONS:[C16523] Create a New Field with Field Type TextSTEPS:1. Click on the Preview button on the Form Builder page.2. Enter any text into the Text field.3. Submit the form.4. Click on 'Back To Form Builder' button.5. Click on the Exit button.6. Scroll down to the Form Responses section on the Form Detail page.7. Click on the Response ID for the new form response.
	#
	#EXPECTED RESULTS:
	#
	#The Form should be submitted successfully.
	#
	#A new form response record should be created under the Form Responses section on the Form Detail page.
	#
	#The Response field under the 'Field Responses' section on the Form Response Detail page should contain the value that was inputted in the form when submitted.ALTERNATE FLOW(S):
	@TEST_PD-29729 @REQ_PD-29728 @regression @21Winter @22Winter @uday
	Scenario Outline: Test Enter text and submit for 'Text' field type
		Given User create a form "delete_AutoTextForm"
			| formGroupName | formFieldName | formFieldType | isRequired         |
			| Account Info  | Account Name  | Text          | <IsRequiredStatus> |
		When User navigate to community Portal page with "jacksonfernandez@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User opens "delete_AutoTextForm" form page
		Then User submits the created form and validates the response when field required is "<IsRequiredStatus>" and value is "<value>"
		Examples:
			| IsRequiredStatus | value |
			| true             | No    |
			| false            | No    |
			| false            | Yes   |

