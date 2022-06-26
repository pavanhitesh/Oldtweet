@REQ_PD-29564
Feature: Insert Phone, Multipicklist, Picklist, Currency, Checkbox and Decimal fields
	#STEPS:
	#
	#1. 1. Navigate to the Form created above
	#1. Click Form Builder button
	#1. For the Field Group mapped to Contact > Click ' + New Field' button on Field Category
	#
	## Enter a value for 'Field Label' field
	## Select 'Phone' as a picklist value for 'Type' field in the modal
	## Map the field to Home Phone under the Mapped Object Field
	## Click Save in the modal
	#
	#2. For the Field Group mapped to Contact > Click ' + New Field' button on Field Category
	#
	## Enter a value for 'Field Label' field
	## Select 'Multipicklist' as a picklist value for 'Type' field in the modal
	## Map the field to a custom multipicklist under the Mapped Object Field
	## Click Save in the modal
	#
	#3.  For the Field Group mapped to Contact > Click ' + New Field' button on Field Category
	#
	## Enter a value for 'Field Label' field
	## Select 'Picklist' as a picklist value for 'Type' field in the modal
	## Map the field to a Default Greeting Type under the Mapped Object Field
	## Click Save in the modal
	#
	#4. For the Field Group mapped to Contact > Click 'New Field' button on Field Category
	#
	## Enter a value for 'Field Label' field
	## Select 'Currency' as a picklist value for 'Type' field in the modal
	## Map the field to Gifts Outstanding under the Mapped Object Field
	## Click Save in the modal
	#
	#5. For the Field Group mapped to Contact > Click 'New Field' button on Field Category
	#
	## Enter a value for 'Field Label' field
	## Select 'Checkbox' as a picklist value for 'Type' field in the modal
	## Map the field to Active Recurring Gift under the Mapped Object Field
	## Click Save in the modal
	#
	#6. For the Field Group mapped to Contact > Click ' + New Field' button on Field Category
	#
	## Enter a value for 'Field Label' field
	## Select 'Decimal' as a picklist value for 'Type' field in the modal
	## Map the field to Annual Engagement Score under the Mapped Object Field
	## Click Save in the modal
	#
	#Expected Result:
	#New Fields with Type 'Phone', 'Multipicklist', 'Picklist', 'Currency', 'Decimal' should be created under the Field Category.
	#
	#2. 1. Click Preview 
	#1. Enter values for Account Name and Last Name
	#
	#2.  Enter a value for the Home Phone field
	#
	#3. Select multiple values for the 'custom multipicklist' field
	#
	#4. Select a value for the picklist field
	#
	#5. Enter a value for the Currency field
	#
	#6. Check the checkbox for the Checkbox field
	#
	#7. Enter a value for the Decimal field
	#
	#8.  Click Submit 
	#Expected Result:
	#Form response should be submitted successfully
	#3. 1. Navigate to the newly created Contact record
	#Expected Result:
	#
	#The ‘Home Phone’, ‘custom multipicklist', ‘Default Greeting Type’,  ‘Gifts Outstanding, Active Recurring Gift’ and ‘Annual Engagement Score’ fields on the Contact should be populated with the user entered value during submission
	#
	#The account related to the contact should have the same name as user entered value during form submission
	#EXPECTED RESULTS:

	#Tests STEPS:
	#
	#1. 1. Navigate to the Form created above
	#1. Click Form Builder buttom
	#1. For the Field Group mapped to Contact > Click ' + New Field' button on Field Category
	#1. Enter a value for 'Field Label' field
	#1. Select 'Phone' as a picklist value for 'Type' field in the modal
	#1. Map the field to Home Phone under the Mapped Object Field
	#1. Click Save in the modal
	#Expected Result:
	#A new Field with Type 'Phone' should be created under the Field Category
	#2. 1. Click Preview 
	#1. Enter values for Account Name and Last Name
	#1. Enter a value for the Home Phone field
	#1. Click Submit 
	#Expected Result:
	#Form response should be submitted successfully
	#3. 1. Navigate to the newly created Contact record
	#Expected Result:
	#
	#The Home Phone field on the Contact should be populated with the user entered value during submission
	#
	#The account related to the contact should have the same name as user entered value during form submission
	#EXPECTED RESULTS:
	@TEST_PD-29565 @REQ_PD-29564 @regression @21Winter @22Winter @lakshmi
	Scenario: Test Insert Phone, Multipicklist, Picklist, Currency, Checkbox and Decimal fields for new contact and Test Update Phone Currency fields in existing contact
		Given User navigate to community Portal page with "davidjackson@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User opens "AutoTestFormForAutomation" form page
		And User fills form with lastName, phone, "Option 1", "Option 3", "Personal Greeting", currency, decimal, checkbox and verify contact summary
		Then User should verify contact details
		And User should able to update form with phone, currency and verify contact summary
		Then User should verify contact details for "David Jackson"

