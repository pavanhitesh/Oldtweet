@REQ_PD-29708
Feature: Submit a form with Date field validations
	#\[C16511] Create a New Field with Field Type DateSTEPS:1. Click on the Preview button on the Form Builder page.2. View the Date field
	#
	#EXPECTED RESULTS:The Date field has no value by default.ALTERNATE FLOW(S):
	#
	#PRE-CONDITIONS:
	#\[C16511] Create a New Field with Field Type Date
	#STEPS:
	#1. Click on the Preview button on the Form Builder page.
	#2. Click on the date field.
	#3. Choose any Date from the listed Calendar shown.
	#4. Click on the Submit button.
	#
	#EXPECTED RESULTS:
	#
	#The Form should be submitted successfully.
	#
	#A new form response record should be created under the Form Responses section on the Form Detail page.
	#
	#The Response field under the 'Field Responses' section on the Form Response Detail page should contain the date value that was in the form when submitted.
	#
	#No default date value provided.
	#
	#PRE-CONDITIONS:
	#\[C16511] Create a New Field with Field Type Date
	#STEPS:
	#
	## Click on the Preview button on the Form Builder page.
	## Click on the date field.
	## Manually enter an invalid date value for each portion of the date (day, month, year) such as, 45/45/4545, into the Date Field.
	## Click on the Submit button.
	## Click on 'Back To Form Builder' button.
	## Click on the Exit button.
	## Scroll down to the Form Responses section on the Form Detail page.
	## Click on the Response ID for the new form response.
	#
	#EXPECTED RESULTS:
	#.. When entering an invalid day, month, year into the date Field, the date Field will display a validation message.
	#
	#PRE-CONDITIONS:
	#\[C16512] Create a New Field with Field Type Date/Time
	#STEPS:
	#
	## In the Form Builder, click on the Edit icon for the 'Date/Time' type field.
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
	#* If the Field was setup without checking the "Is Required" field, the form response should be submitted
	#* successfully.
	#* A new form response record should be created under the Form Responses section on the Form Detail page.
	#* The Response field under 'Field Responses' section on the Form Response Detail page should be empty if no input was entered in to the field before submission.
	#
	#PRE-CONDITIONS:
	#\[C16512] Create a New Field with Field Type Date/Time
	#
	#STEPS:
	#
	## Click on the Preview button on the Form Builder page.
	## Click on the Date/Time field.
	## Choose any Date from the listed Calendar shown.
	## Click on the Select Time field directly underneath the calendar (Select Time is displayed upon hover).
	## Increment or Decrement the Hour to select the desired hour.
	## Increment or Decrement the Minutes to select the desired minutes.
	#
	#* - NOTE: **Increment/Decrement arrows should not be visible in IE. These arrows are not supported in IE browser**
	#7. Toggle the AM to PM (and back if desired) to select AM or PM.
	#8. Click on the Submit button.
	#9. Click on 'Back To Form Builder' button.
	#10. Click on the Exit button.
	#11. Scroll down to the Form Responses section on the Form Detail page.
	#12. Click on the Response ID for the new form response.
	#
	#EXPECTED RESULTS:
	#
	#* The current date and a time of 12:00 AM should be displayed by default after clicking on the Date/Time field.
	#* Should be able to select a date within the calendar view.
	#* Should be able to switch between the calendar and time views.
	#* Should be able to increment/decrement the hour and minutes fields in the time view.
	#* NOTE: **Increment/Decrement arrows should not be visible in IE. These arrows are not supported in IE browser**
	#* Should be able to toggle between AM and PM in the time view.
	#* The Form should be submitted successfully.
	#* A new form response record should be created under the Form Responses section on the Form Detail page.
	#* The Response field under the 'Field Responses' section on the Form Response Detail page should contain the value that was in the form when submitted.
	#
	#PRE-CONDITIONS:
	#\[C16512] Create a New Field with Field Type Date/Time
	#STEPS:
	#
	## In the Form Builder, click on the Edit icon for the 'Date/Time' type field.
	#
	## Enable the 'Is Required' option if the option is currently disabled.
	#
	## Click on the Save button within the 'Edit Field' modal.
	#
	## Click on the Preview button on the Form Builder page.
	#
	## Click on the Submit button.
	#
	## Click on 'Back To Form Builder' button.
	#
	## Click on the Exit button.
	#
	## Scroll down to the Form Responses section on the Form Detail page.
	#
	#EXPECTED RESULTS:
	#
	#* If the Field was setup with the "Is Required" enable , the form response should NOT be submitted.
	#* UI should present an appropriate error message.
	#* A new form response record should not be created under the Form Responses section on the Form Detail page.

	#Tests \[C16511] Create a New Field with Field Type DateSTEPS:1. Click on the Preview button on the Form Builder page.2. View the Date field
	#
	#EXPECTED RESULTS:The Date field has no value by default.ALTERNATE FLOW(S):
	#
	#PRE-CONDITIONS:
	#\[C16511] Create a New Field with Field Type Date
	#STEPS:
	#1. Click on the Preview button on the Form Builder page.
	#2. Click on the date field.
	#3. Choose any Date from the listed Calendar shown.
	#4. Click on the Submit button.
	#
	#EXPECTED RESULTS:
	#
	#The Form should be submitted successfully.
	#
	#A new form response record should be created under the Form Responses section on the Form Detail page.
	#
	#The Response field under the 'Field Responses' section on the Form Response Detail page should contain the date value that was in the form when submitted.
	#
	#No default date value provided.
	#
	#PRE-CONDITIONS:
	#\[C16511] Create a New Field with Field Type Date
	#STEPS:
	#
	## Click on the Preview button on the Form Builder page.
	## Click on the date field.
	## Manually enter an invalid date value for each portion of the date (day, month, year) such as, 45/45/4545, into the Date Field.
	## Click on the Submit button.
	## Click on 'Back To Form Builder' button.
	## Click on the Exit button.
	## Scroll down to the Form Responses section on the Form Detail page.
	## Click on the Response ID for the new form response.
	#
	#EXPECTED RESULTS:
	#.. When entering an invalid day, month, year into the date Field, the date Field will display a validation message.
	#
	#PRE-CONDITIONS:
	#\[C16512] Create a New Field with Field Type Date/Time
	#STEPS:
	#
	## In the Form Builder, click on the Edit icon for the 'Date/Time' type field.
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
	#* If the Field was setup without checking the "Is Required" field, the form response should be submitted
	#* successfully.
	#* A new form response record should be created under the Form Responses section on the Form Detail page.
	#* The Response field under 'Field Responses' section on the Form Response Detail page should be empty if no input was entered in to the field before submission.
	#
	#PRE-CONDITIONS:
	#\[C16512] Create a New Field with Field Type Date/Time
	#
	#STEPS:
	#
	## Click on the Preview button on the Form Builder page.
	## Click on the Date/Time field.
	## Choose any Date from the listed Calendar shown.
	## Click on the Select Time field directly underneath the calendar (Select Time is displayed upon hover).
	## Increment or Decrement the Hour to select the desired hour.
	## Increment or Decrement the Minutes to select the desired minutes.
	#
	#* - NOTE: **Increment/Decrement arrows should not be visible in IE. These arrows are not supported in IE browser**
	#7. Toggle the AM to PM (and back if desired) to select AM or PM.
	#8. Click on the Submit button.
	#9. Click on 'Back To Form Builder' button.
	#10. Click on the Exit button.
	#11. Scroll down to the Form Responses section on the Form Detail page.
	#12. Click on the Response ID for the new form response.
	#
	#EXPECTED RESULTS:
	#
	#* The current date and a time of 12:00 AM should be displayed by default after clicking on the Date/Time field.
	#* Should be able to select a date within the calendar view.
	#* Should be able to switch between the calendar and time views.
	#* Should be able to increment/decrement the hour and minutes fields in the time view.
	#* NOTE: **Increment/Decrement arrows should not be visible in IE. These arrows are not supported in IE browser**
	#* Should be able to toggle between AM and PM in the time view.
	#* The Form should be submitted successfully.
	#* A new form response record should be created under the Form Responses section on the Form Detail page.
	#* The Response field under the 'Field Responses' section on the Form Response Detail page should contain the value that was in the form when submitted.
	#
	#PRE-CONDITIONS:
	#\[C16512] Create a New Field with Field Type Date/Time
	#STEPS:
	#
	## In the Form Builder, click on the Edit icon for the 'Date/Time' type field.
	#
	## Enable the 'Is Required' option if the option is currently disabled.
	#
	## Click on the Save button within the 'Edit Field' modal.
	#
	## Click on the Preview button on the Form Builder page.
	#
	## Click on the Submit button.
	#
	## Click on 'Back To Form Builder' button.
	#
	## Click on the Exit button.
	#
	## Scroll down to the Form Responses section on the Form Detail page.
	#
	#EXPECTED RESULTS:
	#
	#* If the Field was setup with the "Is Required" enable , the form response should NOT be submitted.
	#* UI should present an appropriate error message.
	#* A new form response record should not be created under the Form Responses section on the Form Detail page.
	@TEST_PD-29709 @REQ_PD-29708 @22Winter @21Winter @ninjety @regression
	Scenario Outline: Test Submit form with with Date field validations
		Given User create a form "delete_AutoDateform"
			| formGroupName     | formFieldName | formFieldType | isRequired   |
			| Email Validations | Date          | Date          | <isRequired> |
		When User navigate to community Portal page with "rosebrixton@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User opens "delete_AutoDateform" form page
		Then User verifies Date value is empty by default
		And User submits the form by entering Date value as "<dateValue>" and validates the Response "<errorMsg>"
		Examples:
			| isRequired | dateValue  | errorMsg                                                                                 |
			| true       | valid      |                                                                                          |
			| false      | 23/15/2012 | Invalid month 23. The month has been adjusted to 12 for December.                        |
			| false      | 10/56/2012 | Invalid day 56 in month 10. The day has been adjusted to 31, the maximum for this month. |
			| false      | 10/10/5555 | Invalid year 5555. The year has been adjusted to the maximum, 2100.                      |
			| false      | NA         |                                                                                          |
			| false      | valid      |                                                                                          |



