@REQ_PD-29730
Feature: Verify updating of checkbox field using custom dynamic variable
	#C89858
	#
	#PRE-CONDITIONS:
	#
	#STEPS:
	#
	## Go to Form Builder > Forms
	## Click New
	## Enter form name, click Save
	## Click Form Builder
	## Add new field group with following parameters:
	#
	## Field Group Name: Contact
	## SOQL Filter: Id='<SF Id of existing contact>', where <SF Id of existing contact> is Salesforce is, e.g. a0S41000000lgXv
	## Mapped Object Field: select Contact from picklist
	## Database Operation: Upsert
	#1. Click Save
	#1. Add two fields of type Text, and Mapped Object Field equals First Name and Last Name respectively
	#1. Add field of type Checkbox, Label "Do Not Call", Mapped Object Field equals "Do Not Call". Check "Hidden Field" and in "Hidden Field Value" enter: {{url.donotcall}}. Click Save
	#1. Click Exit to return to form page
	#1. Copy content of Form URL field
	#(if field doesn't exist on layout, create URL as: <Site URL>/Cpbase__form?ID=xxxxxx )
	#1. Open this URL in new tab and add "&donotcall=true" at the end of the URL
	#1. Click Submit
	#1. In another tab go to contact used in this test and verify Do Not Call field

	#C89858
	#
	#PRE-CONDITIONS:
	#
	#STEPS:
	#
	## Go to Form Builder > Forms
	## Click New
	## Enter form name, click Save
	## Click Form Builder
	## Add new field group with following parameters:
	#
	## Field Group Name: Contact
	## SOQL Filter: Id='<SF Id of existing contact>', where <SF Id of existing contact> is Salesforce is, e.g. a0S41000000lgXv
	## Mapped Object Field: select Contact from picklist
	## Database Operation: Upsert
	#1. Click Save
	#1. Add two fields of type Text, and Mapped Object Field equals First Name and Last Name respectively
	#1. Add field of type Checkbox, Label "Do Not Call", Mapped Object Field equals "Do Not Call". Check "Hidden Field" and in "Hidden Field Value" enter: {{url.donotcall}}. Click Save
	#1. Click Exit to return to form page
	#1. Copy content of Form URL field
	#(if field doesn't exist on layout, create URL as: <Site URL>/Cpbase__form?ID=xxxxxx )
	#1. Open this URL in new tab and add "&donotcall=true" at the end of the URL
	#1. Click Submit
	#1. In another tab go to contact used in this test and verify Do Not Call field
	@TEST_PD-29722 @REQ_PD-29730 @regression @21Winter @22Winter @Lakshman
	Scenario: Verify updating of checkbox field using custom dynamic variable
		Given User navigate to community Portal page with "jacksonfernandez@mailinator.com" user and password "705Fonteva" as "authenticated" user
		When User opens "Auto_CheckBoxDoNotCallForm" form page
		Then Then User submits the form by updating donotcall dynamic variable and verifies the contact "Jackson Fernandez"

