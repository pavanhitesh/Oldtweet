@REQ_PD-29545
Feature: Submit a form response for field group enabled with multiple entry and mapped to an object
	#STEPS:
	#1. Navigate to Form Builder>Forms
	#1. Click on New, Form Name
	#1. Click Save
	#1. Click the Form Builder button at the top of the page
	#1. Click on New Field Group
	#1. Enter New Field Group Name
	#1. Set Mapped Object Field=Contact
	#1. Set Database Operations as Insert
	#1. Check box Allow Multiple Entries
	#1. Save
	#1. Click New Field, Set Type=Text
	#1. Check Is Required 
	#1. Enter Field Label
	#1. Under Database Options, set Mapped Object Field=First Name (This should always be the field that most closely corresponds to the desired field on the Object Record)
	#1. Repeat Steps for Last Name 
	#1. Click Save
	#1. Click Preview
	#1. Enter Text into the fields. Click Submit
	#1. Click Add Entry button and repeat the previous step
	#1. Return to the form in the Forms Tab
	#1. Verify the form responses
	#
	#EXPECTED RESULTS:
	#
	#There should be two form responses created 
	#
	#Two contact records should be created with the First and Last names entered by the user

	#Tests STEPS:
	#1. Navigate to Form Builder>Forms
	#1. Click on New, Form Name
	#1. Click Save
	#1. Click the Form Builder button at the top of the page
	#1. Click on New Field Group
	#1. Enter New Field Group Name
	#1. Set Mapped Object Field=Contact
	#1. Set Database Operations as Insert
	#1. Check box Allow Multiple Entries
	#1. Save
	#1. Click New Field, Set Type=Text
	#1. Check Is Required 
	#1. Enter Field Label
	#1. Under Database Options, set Mapped Object Field=First Name (This should always be the field that most closely corresponds to the desired field on the Object Record)
	#1. Repeat Steps for Last Name 
	#1. Click Save
	#1. Click Preview
	#1. Enter Text into the fields. Click Submit
	#1. Click Add Entry button and repeat the previous step
	#1. Return to the form in the Forms Tab
	#1. Verify the form responses
	#
	#EXPECTED RESULTS:
	#
	#There should be two form responses created 
	#
	#Two contact records should be created with the First and Last names entered by the user
	@TEST_PD-29546 @REQ_PD-29545 @regression @21Winter @22Winter @niklesh
	Scenario: Test Submit a form response for field group enabled with multiple entry and mapped to an object
		Given User navigate to community Portal page with "jacksonfernandez@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User opens "AutoMultiEntryMappedObjectForm" form page
		Then User fills the data for firstName and lastName and submit the form
		Then User verifies the form responses "AutoMultiEntryMappedObjectForm"
