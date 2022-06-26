@REQ_PD-29779
Feature: Insert URL field
	#STEPS:
	#
	#1. 1. Navigate to the Form created above1. Click Form Builder button1. For the Field Group mapped to Contact > Click ' + New Field' button on Field Category1. Enter a value for 'Field Label' field1. Select 'URL' as a picklist value for 'Type' field in the modal1. Map the field to custom URL field under the Mapped Object Field1. Click Save in the modalExpected Result:A new Field with Type 'URL' should be created under the Field Category2. 1. Click Preview 1. Enter values for Account Name and Last Name1. Enter a value for the URL field1. Click Submit Expected Result:Form response should be submitted successfully3. 1. Navigate to the newly created Contact recordExpected Result:
	#
	#The custom URL field on the Contact should be populated with the user entered value during submission
	#
	#The account related to the contact should have the same name as user entered value during form submission EXPECTED RESULTS:

	#Tests STEPS:
	#
	#1. 1. Navigate to the Form created above1. Click Form Builder button1. For the Field Group mapped to Contact > Click ' + New Field' button on Field Category1. Enter a value for 'Field Label' field1. Select 'URL' as a picklist value for 'Type' field in the modal1. Map the field to custom URL field under the Mapped Object Field1. Click Save in the modalExpected Result:A new Field with Type 'URL' should be created under the Field Category2. 1. Click Preview 1. Enter values for Account Name and Last Name1. Enter a value for the URL field1. Click Submit Expected Result:Form response should be submitted successfully3. 1. Navigate to the newly created Contact recordExpected Result:
	#
	#The custom URL field on the Contact should be populated with the user entered value during submission
	#
	#The account related to the contact should have the same name as user entered value during form submission EXPECTED RESULTS:
	@TEST_PD-29780 @REQ_PD-29779 @regression @21Winter @22Winter @lakshmi
	Scenario: Test Insert URL field
		Given User navigate to community Portal page with "davidjackson@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User opens "AutoURLInsertForm" form page
		Then User fills form with accountName, url and verify contact details for "David Jackson"

