@REQ_PD-29596
Feature: Create a form with Account as Parent Object and Contact as child object
	#STEPS:
	#
	#1. 1. Navigate to the Form created above
	#1. Click Form Builder buttom
	#1. For the Field Group mapped to Contact > Click 'New Field' button on Field Category
	#1. Enter a value for 'Field Label' field
	#1. Select 'Date' as a picklist value for 'Type' field in the modal
	#1. Map the field to Birthdate under the Mapped Object Field
	#1. Click Save in the modal
	#Expected Result:
	#A new Field with Type 'Date' should be created under the Field Category
	#2. 1. Click Preview 
	#1. Enter values for Account Name and Last Name
	#1. Enter a value for the Date field
	#1. Click Submit 
	#Expected Result:
	#Form response should be submitted successfully
	#3. 1. Navigate to the newly created Contact record
	#Expected Result:
	#
	#The Birthdate field on the Contact should be populated with the user entered value during submission
	#
	#The account related to the contact should have the same name as user entered value during form submission

	#Tests STEPS:
	#
	#1. 1. Navigate to the Form created above
	#1. Click Form Builder buttom
	#1. For the Field Group mapped to Contact > Click 'New Field' button on Field Category
	#1. Enter a value for 'Field Label' field
	#1. Select 'Date' as a picklist value for 'Type' field in the modal
	#1. Map the field to Birthdate under the Mapped Object Field
	#1. Click Save in the modal
	#Expected Result:
	#A new Field with Type 'Date' should be created under the Field Category
	#2. 1. Click Preview 
	#1. Enter values for Account Name and Last Name
	#1. Enter a value for the Date field
	#1. Click Submit 
	#Expected Result:
	#Form response should be submitted successfully
	#3. 1. Navigate to the newly created Contact record
	#Expected Result:
	#
	#The Birthdate field on the Contact should be populated with the user entered value during submission
	#
	#The account related to the contact should have the same name as user entered value during form submission
	@TEST_PD-29598 @REQ_PD-29596 @regression @21Winter @22Winter @niklesh
	Scenario: Test Create a form with Account as Parent Object and Contact as child object
		Given User navigate to community Portal page with "brandlarson@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User opens "AutoAccountContactDateTimeEmailForm" form page
		Then User fills the data, submits the form and validates the contact record
