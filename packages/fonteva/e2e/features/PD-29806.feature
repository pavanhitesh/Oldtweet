@REQ_PD-29806
Feature: Submit Multiple responses for a form enabled with 'Allow Multiple Entries'
	#PRE-CONDITIONS:[C16474] Create a Field Group with 'Allow Multiple Entries' flag checked[C16523] Create a New Required Field with Field Type Text STEPS:
	#
	#1. 1. Navigate to the form created1. Click Form Builder1. Click Preview1. Submit the FormExpected Result:User should not be able to submit the form2. 1. Click Add Entry Button1. Enter a value for the text field > Save1. Click Add Entry button again 1. Enter a value for the text field > Save1. Submit the FormExpected Result:Form response should be submitted successfully3. 1. After the Form has been submitted return to the Form page on your Salesforce Org using the following steps1. From Setup go to the App Picker and go to the Form Builder App1. In the Form Builder App click the "Forms" tab, located on the dashboard1. On the Forms page choose your Form from those listed, if it was not listed click the Go button next to the view drop down menu for the full list1. When on your Form's page scroll down to Form Responses and view the inputted Form Responses for the Form Response and for all of the Answers given to be listed and savedExpected Result:
	#
	#There one form response created
	#
	#Each form response should contain two sets of field responses with the correct field valuesEXPECTED RESULTS:
	#PRE-CONDITIONS:[C16474] Create a Field Group with 'Allow Multiple Entries' flag checked[C16523] Create a New Field with Field Type Text
	#
	#Note - form should not be data binded to any objectSTEPS:
	#
	#1. 1. Navigate to the form created1. Click Form Builder1. Click Preview1. Click Add Entry Button1. Enter a value for the text field > Save1. Click Add Entry button again 1. Enter a value for the text field > Save1. Submit the FormExpected Result:Form Response is submitted successfully2. 1. After the Form has been submitted return to the Form page on your Salesforce Org using the following steps1. From Setup go to the App Picker and go to the Form Builder App1. In the Form Builder App click the "Forms" tab, located on the dashboard1. On the Forms page choose your Form from those listed, if it was not listed click the Go button next to the view drop down menu for the full list1. When on your Form's page scroll down to Form Responses and view the inputted Form Responses for the Form Response and for all of the Answers given to be listed and savedExpected Result:

	#Tests PRE-CONDITIONS:[C16474] Create a Field Group with 'Allow Multiple Entries' flag checked[C16523] Create a New Required Field with Field Type Text STEPS:
	#
	#1. 1. Navigate to the form created1. Click Form Builder1. Click Preview1. Submit the FormExpected Result:User should not be able to submit the form2. 1. Click Add Entry Button1. Enter a value for the text field > Save1. Click Add Entry button again 1. Enter a value for the text field > Save1. Submit the FormExpected Result:Form response should be submitted successfully3. 1. After the Form has been submitted return to the Form page on your Salesforce Org using the following steps1. From Setup go to the App Picker and go to the Form Builder App1. In the Form Builder App click the "Forms" tab, located on the dashboard1. On the Forms page choose your Form from those listed, if it was not listed click the Go button next to the view drop down menu for the full list1. When on your Form's page scroll down to Form Responses and view the inputted Form Responses for the Form Response and for all of the Answers given to be listed and savedExpected Result:
	#
	#There one form response created
	#
	#Each form response should contain two sets of field responses with the correct field valuesEXPECTED RESULTS:
	#PRE-CONDITIONS:[C16474] Create a Field Group with 'Allow Multiple Entries' flag checked[C16523] Create a New Field with Field Type Text
	#
	#Note - form should not be data binded to any objectSTEPS:
	#
	#1. 1. Navigate to the form created1. Click Form Builder1. Click Preview1. Click Add Entry Button1. Enter a value for the text field > Save1. Click Add Entry button again 1. Enter a value for the text field > Save1. Submit the FormExpected Result:Form Response is submitted successfully2. 1. After the Form has been submitted return to the Form page on your Salesforce Org using the following steps1. From Setup go to the App Picker and go to the Form Builder App1. In the Form Builder App click the "Forms" tab, located on the dashboard1. On the Forms page choose your Form from those listed, if it was not listed click the Go button next to the view drop down menu for the full list1. When on your Form's page scroll down to Form Responses and view the inputted Form Responses for the Form Response and for all of the Answers given to be listed and savedExpected Result:
	@TEST_PD-29807 @REQ_PD-29806 @22Winter @21Winter @ninjety @regression
	Scenario Outline: Test Submit Multiple responses for a form enabled with 'Allow Multiple Entries'
		Given User create a form "delete_MultiEntryTextform"
			| formGroupName  | formFieldName | formFieldType | isRequired   |
			| MultiTextEntry | Text          | Text          | <isRequired> |
		And User updates the form with Allow Multiple Entries as "true"
		When User navigate to community Portal page with "rosebrixton@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User opens "delete_MultiEntryTextform" form page
		Then User adds 2 entry values to form and submit and verify the Response
		Examples:
			| isRequired |
			| true       |
			| false      |
