@REQ_PD-29798
Feature: Verify Field Group Instructions on the form
	#C89846
	#
	#PRE-CONDITIONS:Create a Form:1. Go to Form Builder -> Forms2. On the Forms page click the "New" button.3. Enter a value into the Field Value for "Form Name"4. Click SaveSTEPS:1. Click the Form Builder Button1. Add a Field Group to the Form, with Instructions field populated, click Save1. Add a Field to the Field Group, Save1. Click Preview
	#
	#EXPECTED RESULTS:Field Group and Field should be savedInstructions should be displayed under Field Group labelALTERNATE FLOW(S):

	#Tests C89846
	#
	#PRE-CONDITIONS:Create a Form:1. Go to Form Builder -> Forms2. On the Forms page click the "New" button.3. Enter a value into the Field Value for "Form Name"4. Click SaveSTEPS:1. Click the Form Builder Button1. Add a Field Group to the Form, with Instructions field populated, click Save1. Add a Field to the Field Group, Save1. Click Preview
	#
	#EXPECTED RESULTS:Field Group and Field should be savedInstructions should be displayed under Field Group labelALTERNATE FLOW(S):
	@TEST_PD-29803 @REQ_PD-29798 @regression @21Winter @22Winter @uday
	Scenario: Test Verify Field Group Instructions on the form
		Given User create a form "delete_AutoInstructionFieldForm"
			| formGroupName     | formFieldName      | formFieldType      | isRequired |
			| Instruction Group | Instructions Field | Instructional Text | true       |
		And User update the instructions on formGroup to the created form
		When User navigate to community Portal page with "jacksonfernandez@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User opens "delete_AutoInstructionFieldForm" form page
		Then User validates the field group instructions and visibility of instructional text field on form
