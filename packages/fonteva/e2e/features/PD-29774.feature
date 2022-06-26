@REQ_PD-29774
Feature: Respond to a form that is mapped to an object with Database Operation as Insert
	#C89843
	#
	#PRE-CONDITIONS:
	#
	#STEPS:
	#
	## Create a Form
	#
	## Navigate to Forrm Builder > Forms
	## Click the "New" button.
	## Enter a value into the Field Value for "Form Name"
	## Click Save
	## Click the Form Builder Button
	## Click Create New Field Group button
	## Enter a Field Group Name
	## Select Account as the mapped object
	## Scroll down to Database Operations
	## Select Insert from the dropdown menu
	## Save
	#
	#Expected Result:
	#Field Group is created successfully
	#
	## 1. Click New Field button for the Field Group
	#
	## Select Field Type as Text
	#
	## Enter "Account Name" in Field Label
	#
	## Select "Account Name" from Mapped Object Field picklist
	#
	## Save
	#
	#Expected Result:
	#Mapped field is created successfully
	#
	## 1. Click New Field button for the Field Group
	#
	## Select Field Type as Text
	#
	## Enter "Billing City" in Field Label
	#
	## Select "Billing City" from Mapped Object Field picklist
	#
	## Save
	#
	#Expected Result:
	#Mapped field is created successfully
	#
	## 1. Navigate to the form created
	#
	## Click Form Builder
	#
	## Click Preview
	#
	## Complete the fields on the form
	#
	## Submit the Form
	#
	#Expected Result:
	#Form Response is submitted successfully
	#
	## 1. Navigate the Account record created
	#
	#Expected Result:
	#Billing City for the Account is updated with the user entered value
	#EXPECTED RESULTS:
	#
	#ALTERNATE FLOW(S):

	#C89843
	#
	#PRE-CONDITIONS:
	#
	#STEPS:
	#
	## Create a Form
	#
	## Navigate to Forrm Builder > Forms
	## Click the "New" button.
	## Enter a value into the Field Value for "Form Name"
	## Click Save
	## Click the Form Builder Button
	## Click Create New Field Group button
	## Enter a Field Group Name
	## Select Account as the mapped object
	## Scroll down to Database Operations
	## Select Insert from the dropdown menu
	## Save
	#
	#Expected Result:
	#Field Group is created successfully
	#
	## 1. Click New Field button for the Field Group
	#
	## Select Field Type as Text
	#
	## Enter "Account Name" in Field Label
	#
	## Select "Account Name" from Mapped Object Field picklist
	#
	## Save
	#
	#Expected Result:
	#Mapped field is created successfully
	#
	## 1. Click New Field button for the Field Group
	#
	## Select Field Type as Text
	#
	## Enter "Billing City" in Field Label
	#
	## Select "Billing City" from Mapped Object Field picklist
	#
	## Save
	#
	#Expected Result:
	#Mapped field is created successfully
	#
	## 1. Navigate to the form created
	#
	## Click Form Builder
	#
	## Click Preview
	#
	## Complete the fields on the form
	#
	## Submit the Form
	#
	#Expected Result:
	#Form Response is submitted successfully
	#
	## 1. Navigate the Account record created
	#
	#Expected Result:
	#Billing City for the Account is updated with the user entered value
	#EXPECTED RESULTS:
	#
	#ALTERNATE FLOW(S):
	@TEST_PD-29718 @REQ_PD-29774 @regression @21Winter @22Winter @Lakshman
	Scenario: Respond to a form that is mapped to an object with Database Operation as Insert
		Given User navigate to community Portal page with "jacksonfernandez@mailinator.com" user and password "705Fonteva" as "authenticated" user
		When User opens "AutoFormAccountInsertNameAndBillingCity" form page
		Then User submits the form by updating "Account Name" and "Billing City" for the account of "Jackson Fernandez" and verifies the account record.
		And User verifies Account Name and Billing city values are populated for the contact
