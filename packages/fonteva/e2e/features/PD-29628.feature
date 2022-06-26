@REQ_PD-29628
Feature: Insert Text Area,Insert Text and Text Area Long
	#C89706
	#
	#PRE-CONDITIONS:
	#\[C30285] Create a form with Account as Parent Object and Contact as child object 
	#STEPS:
	#
	## 1. Navigate to the Form created above
	#
	## Click Form Builder buttom
	#
	## For the Field Group mapped to Contact > Click ' + New Field' button on Field Category
	#
	## Enter a value for 'Field Label' field
	#
	## Select 'Text Area' as a picklist value for 'Type' field in the modal
	#
	## Map the field to Mailing Street under the Mapped Object Field
	#
	## Click Save in the modal
	#
	#Expected Result:
	#A new Field with Type 'Text Area' should be created under the Field Category
	#
	## 1. Click Preview 
	#
	## Enter values for Account Name and Last Name
	#
	## Enter a value for the Text Area field
	#
	## Click Submit 
	#
	#Expected Result:
	#Form response should be submitted successfully
	#
	## 1. Navigate to the newly created Contact record
	#
	#Expected Result:
	#
	#* The Mailing Address field on the Contact should be populated with the user entered value during submission
	#* The account related to the contact should have the same name as user entered value during form submission
	#EXPECTED RESULTS:
	#
	#ALTERNATE FLOW(S):

	#Tests C89706
	#
	#PRE-CONDITIONS:
	#\[C30285] Create a form with Account as Parent Object and Contact as child object 
	#STEPS:
	#
	## 1. Navigate to the Form created above
	#
	## Click Form Builder buttom
	#
	## For the Field Group mapped to Contact > Click ' + New Field' button on Field Category
	#
	## Enter a value for 'Field Label' field
	#
	## Select 'Text Area' as a picklist value for 'Type' field in the modal
	#
	## Map the field to Mailing Street under the Mapped Object Field
	#
	## Click Save in the modal
	#
	#Expected Result:
	#A new Field with Type 'Text Area' should be created under the Field Category
	#
	## 1. Click Preview 
	#
	## Enter values for Account Name and Last Name
	#
	## Enter a value for the Text Area field
	#
	## Click Submit 
	#
	#Expected Result:
	#Form response should be submitted successfully
	#
	## 1. Navigate to the newly created Contact record
	#
	#Expected Result:
	#
	#* The Mailing Address field on the Contact should be populated with the user entered value during submission
	#* The account related to the contact should have the same name as user entered value during form submission
	#EXPECTED RESULTS:
	#
	#ALTERNATE FLOW(S):
	@TEST_PD-29629 @REQ_PD-29628 @22Winter @21Winter @ninjety @regression
	Scenario: Insert Text Area,Insert Text and Text Area Long
		Given User navigate to community Portal page with "rosebrixton@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User opens "AutoTextAreaTestForm" form page
		And User validate the populated field values on form with details of contact "Rose Brixton"
		Then User updates mailing Street and contact description and submits and Verify updated contact details


