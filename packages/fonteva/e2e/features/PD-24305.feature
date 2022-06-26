@REQ_PD-24305
Feature: Multi-entry forms are not displaying correct value of checkbox field in edit mode
	#*Case Reporter* James Simpson
	#
	#*Customer* Communities In Schools - National Office Department
	#
	#*Reproduced by* Erich Ehinger in2019.1.0.24 + Effie in 2019.1.0.30
	#
	#*Reference Case#* [00023305|https://fonteva.my.salesforce.com/5004V000010lVvZQAU]
	#
	#*Description:*
	#
	#When a multi-entry form binding to the Contact object is nested in a Fonteva Profile layout and there are checkboxes on the form, the bound records with true values in the checkboxes are not rendering in edit mode of a multi-entry card
	#
	#*Steps to Reproduce:*
	#
	#* Create a multi-entry form, mapped to Contact object with SOQL filter Id='{{usr.ContactId}}'. Data op = insert
	#* Add a field on the field group, e.g. Is Authorized User (custom field on Contact object) and map it to the corresponding Contact field
	#** Make sure the data type=checkbox
	#* Create a Community Site menu item with the lightning form URL of the above form
	#** Is Profile Menu Item=true
	#* Log into the community as a contact
	#* Click on the profile menu item
	#* Scroll to the checkbox field where false is the stated value
	#* Click the checkbox to make the value equal to True
	#* Data is saved and showing True in the lightning form view, however, when entering the edit screen again, it shows it is unchecked. See screenshots
	#
	#Recording: [https://fonteva.zoom.us/rec/share/97VT8D9DqLUMSA1DvtX1tX2pawWXAB5iiBfMQNXG-js6k4o5lbsvT0XKuLnztMEh.Iv69cXVO7wVxc9zF]
	#
	#*Actual Results:*
	#
	#For a data-binding form, when a checkbox has value of True, in edit mode in multi-entry card on form it still shows False
	#
	#*Expected Results:*
	#
	#Values of checkboxes should display correctly in edit mode of multi-entry form

	#Tests *Case Reporter* James Simpson
	#
	#*Customer* Communities In Schools - National Office Department
	#
	#*Reproduced by* Erich Ehinger in2019.1.0.24 + Effie in 2019.1.0.30
	#
	#*Reference Case#* [00023305|https://fonteva.my.salesforce.com/5004V000010lVvZQAU]
	#
	#*Description:*
	#
	#When a multi-entry form binding to the Contact object is nested in a Fonteva Profile layout and there are checkboxes on the form, the bound records with true values in the checkboxes are not rendering in edit mode of a multi-entry card
	#
	#*Steps to Reproduce:*
	#
	#* Create a multi-entry form, mapped to Contact object with SOQL filter Id='{{usr.ContactId}}'. Data op = insert
	#* Add a field on the field group, e.g. Is Authorized User (custom field on Contact object) and map it to the corresponding Contact field
	#** Make sure the data type=checkbox
	#* Create a Community Site menu item with the lightning form URL of the above form
	#** Is Profile Menu Item=true
	#* Log into the community as a contact
	#* Click on the profile menu item
	#* Scroll to the checkbox field where false is the stated value
	#* Click the checkbox to make the value equal to True
	#* Data is saved and showing True in the lightning form view, however, when entering the edit screen again, it shows it is unchecked. See screenshots
	#
	#Recording: [https://fonteva.zoom.us/rec/share/97VT8D9DqLUMSA1DvtX1tX2pawWXAB5iiBfMQNXG-js6k4o5lbsvT0XKuLnztMEh.Iv69cXVO7wVxc9zF]
	#
	#*Actual Results:*
	#
	#For a data-binding form, when a checkbox has value of True, in edit mode in multi-entry card on form it still shows False
	#
	#*Expected Results:*
	#
	#Values of checkboxes should display correctly in edit mode of multi-entry form
	@TEST_PD-29193 @REQ_PD-24305 @21Winter @22Winter @regression @pavan
	Scenario: Test Multi-entry forms are not displaying correct value of checkbox field in edit mode
		Given User navigate to community Portal page with "cdulce@mailinator.com" user and password "705Fonteva" as "authenticated" user
		When User selects the profile menu "MultiEntryForm" and navigate to multi entry checkbox form
		Then User edit the entry have isAuthorizedUser and verifies the correct value of checkbox based on the isAuthorizedUser value


