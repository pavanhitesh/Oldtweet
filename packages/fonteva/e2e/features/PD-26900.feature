@REQ_PD-26900
Feature: Checkbox fields that are added to the Contact Information fieldset can be checked by the community user without selecting Change
	#*Case Reporter* James Simpson
	#
	#*Customer* Communities In Schools - National Office Department
	#
	#*Reproduced by* John Herrera in 20Spring.0.14
	#
	#*Reference Case#* [00029814|https://fonteva.my.salesforce.com/5004V000015esH2QAI]
	#
	#*Overview:*
	#
	#* The issue is checkboxes are displayed in edit mode even if the user has not clicked the “Change” button on the page.
	#
	#*Description:*
	#
	#* This is bad UX for the customer - Customers are selecting the checkbox and expecting their selections to reflect within the database
	#* It's confusing for the customer
	#* "Mobile Do Not Call" is a managed field
	#* "Mobile Do Not Text" is an unmanaged field
	#
	#*Screen recording:*
	#
	#[https://www.screencast.com/t/LA8F899bTfs4|https://www.screencast.com/t/LA8F899bTfs4]
	#
	#*ORR to Reproduce*
	#
	#GCO Org ID: 00D4x000000JXuG
	#
	#*Steps to Reproduce:*
	#
	#* On the contact object, add the "Mobile Do Not Call" field to the "Contact Information" fieldset
	#* Create a custom field, type checkbox (eg "Mobile Do Not Text"), and add the field to the "Contact Information" fieldset
	#** Make sure Custom Community profile has access to newly created field
	#* Login to the community as a User (eg Bob Kelley)
	#* Navigate to the My Info tab and check off the two checkbox fields without selecting "Change"
	#
	#The issue is found here. Customers expect their change will stick but the database is not saving their preference because "Change" was not selected.
	#
	#*Actual Results:*
	#
	#End-User can modify the checkbox fields without selecting "Change"
	#
	#*Expected Results:*
	#
	#End-User must select "Change" to modify the checkbox fields.
	#
	#Checkoxare should not be clickable unless the user clicks "Change".
	#
	#Checkboxes should behave the same as Text fields. On the page load, it should be read-only when the user clicks "Change" then it should be editable.
	#
	#Estimate
	#
	#QA: 22h

	#Tests *Case Reporter* James Simpson
	#
	#*Customer* Communities In Schools - National Office Department
	#
	#*Reproduced by* John Herrera in 20Spring.0.14
	#
	#*Reference Case#* [00029814|https://fonteva.my.salesforce.com/5004V000015esH2QAI]
	#
	#*Overview:*
	#
	#* The issue is checkboxes are displayed in edit mode even if the user has not clicked the “Change” button on the page.
	#
	#*Description:*
	#
	#* This is bad UX for the customer - Customers are selecting the checkbox and expecting their selections to reflect within the database
	#* It's confusing for the customer
	#* "Mobile Do Not Call" is a managed field
	#* "Mobile Do Not Text" is an unmanaged field
	#
	#*Screen recording:*
	#
	#[https://www.screencast.com/t/LA8F899bTfs4|https://www.screencast.com/t/LA8F899bTfs4]
	#
	#*ORR to Reproduce*
	#
	#GCO Org ID: 00D4x000000JXuG
	#
	#*Steps to Reproduce:*
	#
	#* On the contact object, add the "Mobile Do Not Call" field to the "Contact Information" fieldset
	#* Create a custom field, type checkbox (eg "Mobile Do Not Text"), and add the field to the "Contact Information" fieldset
	#** Make sure Custom Community profile has access to newly created field
	#* Login to the community as a User (eg Bob Kelley)
	#* Navigate to the My Info tab and check off the two checkbox fields without selecting "Change"
	#
	#The issue is found here. Customers expect their change will stick but the database is not saving their preference because "Change" was not selected.
	#
	#*Actual Results:*
	#
	#End-User can modify the checkbox fields without selecting "Change"
	#
	#*Expected Results:*
	#
	#End-User must select "Change" to modify the checkbox fields.
	#
	#Checkoxare should not be clickable unless the user clicks "Change".
	#
	#Checkboxes should behave the same as Text fields. On the page load, it should be read-only when the user clicks "Change" then it should be editable.
	#
	#Estimate
	#
	#QA: 22h
	
 @REQ_PD-26900 @TEST_PD-27664 @regression @21Winter @22Winter @svinjamuri
 Scenario: Test Checkbox fields that are added to the Contact Information fieldset can be checked by the community user without selecting Change
  Given User navigate to community Portal page with "ettabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
  Then User verifies check box of Mobile Do Not Call from Address Information should be read only for "Etta Brown" contact
  When User updates the Mobile Donot Call checkbox state to disable on profile page
  And User clicks on Save button in address change
  Then User verifies Mobile Do not Call check box is not selected in profile page
