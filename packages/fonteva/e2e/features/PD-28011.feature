@REQ_PD-28011
Feature: When managing an existing contact's known addresses if you select Edit and check the Enter Address Manually box the Country field shows Blank and it allows you to Save even though Country is a Required field.
	#*Case Reporter* Ian Shaw
	#
	#*Customer* Royal Automobile Club
	#
	#*Reproduced by* Linda Diemer in 2019.1.0.38
	#
	#*Reference Case#* [00029583|https://fonteva.my.salesforce.com/5004V000014l6MOQAY]
	#
	#*Description:*
	#
	#Customer wants there to be an error message if the Country field is left blank when they Enter the Address Manually to ensure an accurate update on the address.
	#
	#*Steps to Reproduce:*
	#
	## In a GCO where State & Country picklist is Enabled
	## Go to a Contact with multiple known addresses. Example: Bob Kelley
	## Select the Manage Known Addresses button
	## Select the pencil icon next to one of the addresses Example: the Shipping Address (notice the country is showing prior to clicking edit)
	## check the box: Enter Address Manually
	## See how the Country field is not populated.
	## if you modify the street, leaving the Country blank and Save there is no error indicating the Country is required and the record Saves
	#
	#If in step 7 you select a Country and then remove it a leaving this field Blank again, when you try to Save you will now see an error indicating to fill out the field.
	#
	#*Actual Results:*
	#
	#When editing an existing known address and selecting Enter Address Manually the Country field is showing Blank, even when the record shows these fields populated before going into this edit mode.
	#
	#*Expected Results:*
	#
	#The expected behavior would be for the fields to be populated and for there to be an error indicating to populate the field before allowing to Save.
	#
	#*CS Notes:*
	#
	#Note from the client testing the issue in 21 Winter.
	#
	#This is still an issue after upgrading our sandbox to Winter21. I am fairly sure that it is still related to the country picklist using the country code rather than a value.
	#
	#If I create a new address, it populates the list view with the country code despite the field label being country i.e. GB.
	#If I go to edit an existing address, the list view will contain the country United Kingdom (which is of course a valid country) but the modal that opens to allow editing is not able to map the correct country of the United Kingdom due to the fact that the modal is using country code, not a country.
	#
	#So either the country field is not actually the country field, but country code, or somewhere behind the scenes the field mapping is incorrect and using/displaying the code instead of country.
	#
	#
	#
	#*T3 Notes:*
	#
	#Even when the org does not have Fonteva Registry Entry to _KA_Country_long_Name_ to display country long name, we're passing the long name of the country in the backend. This leads to the incongruence with [https://github.com/Fonteva/framework/blob/2019-R1-Patch-Master/src/classes/AddressPickerFieldController.cls#L25-L26|https://github.com/Fonteva/framework/blob/2019-R1-Patch-Master/src/classes/AddressPickerFieldController.cls#L25-L26]  and leads to the failure

	#Tests *Case Reporter* Ian Shaw
	#
	#*Customer* Royal Automobile Club
	#
	#*Reproduced by* Linda Diemer in 2019.1.0.38
	#
	#*Reference Case#* [00029583|https://fonteva.my.salesforce.com/5004V000014l6MOQAY]
	#
	#*Description:*
	#
	#Customer wants there to be an error message if the Country field is left blank when they Enter the Address Manually to ensure an accurate update on the address.
	#
	#*Steps to Reproduce:*
	#
	## In a GCO where State & Country picklist is Enabled
	## Go to a Contact with multiple known addresses. Example: Bob Kelley
	## Select the Manage Known Addresses button
	## Select the pencil icon next to one of the addresses Example: the Shipping Address (notice the country is showing prior to clicking edit)
	## check the box: Enter Address Manually
	## See how the Country field is not populated.
	## if you modify the street, leaving the Country blank and Save there is no error indicating the Country is required and the record Saves
	#
	#If in step 7 you select a Country and then remove it a leaving this field Blank again, when you try to Save you will now see an error indicating to fill out the field.
	#
	#*Actual Results:*
	#
	#When editing an existing known address and selecting Enter Address Manually the Country field is showing Blank, even when the record shows these fields populated before going into this edit mode.
	#
	#*Expected Results:*
	#
	#The expected behavior would be for the fields to be populated and for there to be an error indicating to populate the field before allowing to Save.
	#
	#*CS Notes:*
	#
	#Note from the client testing the issue in 21 Winter.
	#
	#This is still an issue after upgrading our sandbox to Winter21. I am fairly sure that it is still related to the country picklist using the country code rather than a value.
	#
	#If I create a new address, it populates the list view with the country code despite the field label being country i.e. GB.
	#If I go to edit an existing address, the list view will contain the country United Kingdom (which is of course a valid country) but the modal that opens to allow editing is not able to map the correct country of the United Kingdom due to the fact that the modal is using country code, not a country.
	#
	#So either the country field is not actually the country field, but country code, or somewhere behind the scenes the field mapping is incorrect and using/displaying the code instead of country.
	#
	#
	#
	#*T3 Notes:*
	#
	#Even when the org does not have Fonteva Registry Entry to _KA_Country_long_Name_ to display country long name, we're passing the long name of the country in the backend. This leads to the incongruence with [https://github.com/Fonteva/framework/blob/2019-R1-Patch-Master/src/classes/AddressPickerFieldController.cls#L25-L26|https://github.com/Fonteva/framework/blob/2019-R1-Patch-Master/src/classes/AddressPickerFieldController.cls#L25-L26]  and leads to the failure
	@TEST_PD-28918 @REQ_PD-28011 @21Winter @22Winter @regression @Pavan
	Scenario: Test When managing an existing contact's known addresses if you select Edit and check the Enter Address Manually box the Country field shows Blank and it allows you to Save even though Country is a Required field.
		Given User selects the contact "Coco Dulce" having multiple addresses and navigates to view Known addresses page
		And user navigates to manage known addresses
		When user selects one of the address to edit
		And  user click on Enter Address Manually Checkbox
		Then user verifies the country is populated
		And user verifies the validation message is displayed as "Country is required" when country is blank and street is modified
		

