@REQ_PD-29701
Feature: Enter invalid characters into Number field
	#C89714
	#
	#PRE-CONDITIONS:[C16517] Create a New Field with Field Type NumberSTEPS:1 Click on the Preview button on the Form Builder page.2. Manually enter invalid characters, such as letter or special characters,  into the Number field, i.e. 'six' or {[*?/3. Submit the form.4. Click on 'Back To Form Builder' button.5. Click on the Exit button.6. Scroll down to the Form Responses section on the Form Detail page.
	#
	#EXPECTED RESULTS:
	#
	#User should not be able to enter non-integer numbers into the input field.
	#
	#ALTERNATE FLOW(S):

	#Tests C89714
	#
	#PRE-CONDITIONS:[C16517] Create a New Field with Field Type NumberSTEPS:1 Click on the Preview button on the Form Builder page.2. Manually enter invalid characters, such as letter or special characters,  into the Number field, i.e. 'six' or {[*?/3. Submit the form.4. Click on 'Back To Form Builder' button.5. Click on the Exit button.6. Scroll down to the Form Responses section on the Form Detail page.
	#
	#EXPECTED RESULTS:
	#
	#User should not be able to enter non-integer numbers into the input field.
	#
	#ALTERNATE FLOW(S):
	@TEST_PD-29702 @REQ_PD-29701 @regression @21Winter @22Winter @uday
	Scenario Outline: Test Enter invalid characters into Number field
		Given User create a form "delete_AutoNumberform"
			| formGroupName | formFieldName  | formFieldType | isRequired         |
			| Account Info  | Employee Count | Number        | <isRequiredStatus> |
		When User navigate to community Portal page with "jacksonfernandez@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User opens "delete_AutoNumberform" form page
		Then User fills "<employeesCount>" and submits the created form and validates the response when isRequired option is "<isRequiredStatus>"
		Examples:
			| employeesCount | isRequiredStatus |
			|                | true             |
			|                | false            |
			| 5              | false            |
			| @#$%           | false            |
			| employee       | false            |

