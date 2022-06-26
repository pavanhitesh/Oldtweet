@REQ_PD-29723
Feature: Submit the form with data validations for Decimal Number
    #STEPS:
    #1. In the Form Builder, click on the Edit icon for the 'Decimal' type field.
    #1. Disable the 'Is Required' option if the option is currently enabled.
    #1. Click on the Save button within the 'Edit Field' modal.
    #1. Click on the Preview button on the Form Builder page.
    #1. Click on the Submit button.
    #1. Click on 'Back To Form Builder' button.
    #1. Click on the Exit button.
    #1. Scroll down to the Form Responses section on the Form Detail page.
    #1. Click on the Response ID for the new form response.
    #
    #EXPECTED RESULTS:
    #
    #If the Field was setup without checking the "Is Required" field, the form response should be submitted successfully.
    #
    #A new form response record should be created under the Form Responses section on the Form Detail page.
    #
    #The Response field under 'Field Responses' section on the Form Response Detail page should be empty if no input was entered in to the field before submission.ALTERNATE FLOW(S):

    #STEPS:
    #1. Click on the Preview button on the Form Builder page.
    #1. Enter a decimal number, such as 5.67, into the decimal field.
    #1. Submit the form.
    #1. Click on 'Back To Form Builder' button.
    #1. Click on the Exit button.
    #1. Scroll down to the Form Responses section on the Form Detail page.
    #1. Click on the Response ID for the new form response.
    #
    #EXPECTED RESULTS:
    #
    #The Form should be submitted successfully.
    #
    #A new form response record should be created under the Form Responses section on the Form Detail page.
    #
    #The Response field under the 'Field Responses' section on the Form Response Detail page should contain the value that was inputted in the form when submitted.ALTERNATE FLOW(S):
    #

    #STEPS:
    #1. Click on the Preview button on the Form Builder page.
    #1. Click on the Decimal field.
    #1. Enter invalid characters, such as letters or special characters, into the number field on the form.
    #1. Click on the Submit button.
    #1. Click on 'Back To Form Builder' button.
    #1. Click on the Exit button.
    #1. Scroll down to the Form Responses section on the Form Detail page.
    #
    #EXPECTED RESULTS:
    #
    #The form response should NOT be submitted.
    #
    #UI should present an appropriate validation error message.
    #
    #A new form response record should not be created under the Form Responses section on the Form Detail page.ALTERNATE FLOW(S):
    #

    #STEPS:
    #1. In the Form Builder, click on the Edit icon for the 'Decimal' type field.
    #1. Enable the 'Is Required' option if the option is currently disabled.
    #1. Click on the Save button within the 'Edit Field' modal.
    #1. Click on the Preview button on the Form Builder page.
    #1. Click on the Submit button.
    #1. Click on 'Back To Form Builder' button.
    #1. Click on the Exit button.
    #1. Scroll down to the Form Responses section on the Form Detail page.
    #
    #EXPECTED RESULTS:
    #
    #If the Field was setup with the "Is Required" enable , the form response should NOT be submitted.
    #
    #UI should present an appropriate error message.
    #
    #A new form response record should not be created under the Form Responses section on the Form Detail page.ALTERNATE FLOW(S):
    #
 @TEST_PD-29724 @REQ_PD-29723 @regression @21Winter @22Winter @jhansi
 Scenario Outline: Test Entering a value in Decimal field and verify the response(s)
  Given User create a form "delete_validateDecimalFieldForm"
  | formGroupName | formFieldName | formFieldType | isRequired   |
  | Account Info  | Decimal       | Decimal       | <isRequired> |
  When User navigate to community Portal page with "julianajacobson@mailinator.com" user and password "705Fonteva" as "authenticated" user
  And User opens "delete_validateDecimalFieldForm" form page
  Then User enters Credit Score "<CreditScore>" and submits form and validates the response
  Examples:
   | CreditScore | isRequired |
   | 22          | false      |
   | 10.27       | true       |
   |             | true       |
   |             | false      |
   | &*#/        | true       |
