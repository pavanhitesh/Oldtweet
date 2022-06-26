@REQ_PD-26903
Feature: Multi-select picklist at guest checkout shows 'No Options Available'
	#*Case Reporter* Nada Spriggs
	#
	#*Customer* Association of the United States Army
	#
	#*Reproduced by* Linda Diemer in 2019.1.0.33,2019.1.0.40
	#
	#*Reference Case#* [00029718|https://fonteva.my.salesforce.com/5004V000014lq6YQAQ]
	#
	#*Description:*
	#
	#Guest users are not able to fill out a form at checkout because the multi-select picklist field is not showing values to choose from and it is a required field in order to proceed for my customer.
	#
	#*Steps to Reproduce:*
	#
	## Find an existing Multi-Select picklist field on the contact object or create a new one
	### If you create a new one make sure to give read/write access to GUEST PROFILE for the community
	## Add a multi-select picklist field to the *contact information fieldset under* the Contact object.
	## Then add this field set to the Store under the section: "Guest Checkout", in the field called "*New Contact Fieldset(s) csv*"
	## Now go to the community store
	### Do not log in as someone, use a public URL to view the store
	### You can grab the community URL under the SF setup menu, Digital Sites
	### Example URL format: [https://MY_BASE_URL/LightningMemberPortal/s/store#/store/browse/tiles|https://us-tdm-tso-15eb63ff4c6-1626e-177bd6e908f.force.com/LightningMemberPortal/s/store#/store/browse/tiles]
	## Select an item from the store and add it to your cart and proceed to the checkout page
	## The checkout page will ask you to login or cont as a guest since you are not logged in
	## Select Continue as a Guest option
	### FYI, this option will create a new contact record and update the sales order.
	## Fill in First, Last Name and Email so the rest of the fields appear (fields are populated on fieldset mentioned above)
	## Notice the multi-select field says 'No Options Available'
	#
	#*Actual Results:*
	#
	#When checking out as a Guest, users do not see values in the multi-select field to choose.
	#
	#*Expected Results:*
	#
	#To be able to see the values in the multi-select picklist and choose to continue with processing payment.
	#
	#*CS Note:*
	#This behavior is not seen when registering to an event as a guest with the same fieldset in use.
	#
	#*PM Notes:*
	#
	#* See the fix already applied for the ticket *PD-13821*. {color:#ff5630}We have already fixed this issue for event checkout{color} and now we are going to address the issue for the store checkout page.
	#* You can find the list of checkout pages and their capabilities here:
	#** [https://docs.google.com/spreadsheets/d/10B1L5V8c6mQ7giiAjtjxJXp5yq2mYlmNKPmyT5MwBkE/edit?usp=sharing|https://docs.google.com/spreadsheets/d/10B1L5V8c6mQ7giiAjtjxJXp5yq2mYlmNKPmyT5MwBkE/edit?usp=sharing]
	#* Both Store and Event heckout pages hosted in the LTE package
	#
	#Estimate
	#
	#QA: 20h

	#Tests *Case Reporter* Nada Spriggs
	#
	#*Customer* Association of the United States Army
	#
	#*Reproduced by* Linda Diemer in 2019.1.0.33,2019.1.0.40
	#
	#*Reference Case#* [00029718|https://fonteva.my.salesforce.com/5004V000014lq6YQAQ]
	#
	#*Description:*
	#
	#Guest users are not able to fill out a form at checkout because the multi-select picklist field is not showing values to choose from and it is a required field in order to proceed for my customer.
	#
	#*Steps to Reproduce:*
	#
	## Find an existing Multi-Select picklist field on the contact object or create a new one
	### If you create a new one make sure to give read/write access to GUEST PROFILE for the community
	## Add a multi-select picklist field to the *contact information fieldset under* the Contact object.
	## Then add this field set to the Store under the section: "Guest Checkout", in the field called "*New Contact Fieldset(s) csv*"
	## Now go to the community store
	### Do not log in as someone, use a public URL to view the store
	### You can grab the community URL under the SF setup menu, Digital Sites
	### Example URL format: [https://MY_BASE_URL/LightningMemberPortal/s/store#/store/browse/tiles|https://us-tdm-tso-15eb63ff4c6-1626e-177bd6e908f.force.com/LightningMemberPortal/s/store#/store/browse/tiles]
	## Select an item from the store and add it to your cart and proceed to the checkout page
	## The checkout page will ask you to login or cont as a guest since you are not logged in
	## Select Continue as a Guest option
	### FYI, this option will create a new contact record and update the sales order.
	## Fill in First, Last Name and Email so the rest of the fields appear (fields are populated on fieldset mentioned above)
	## Notice the multi-select field says 'No Options Available'
	#
	#*Actual Results:*
	#
	#When checking out as a Guest, users do not see values in the multi-select field to choose.
	#
	#*Expected Results:*
	#
	#To be able to see the values in the multi-select picklist and choose to continue with processing payment.
	#
	#*CS Note:*
	#This behavior is not seen when registering to an event as a guest with the same fieldset in use.
	#
	#*PM Notes:*
	#
	#* See the fix already applied for the ticket *PD-13821*. {color:#ff5630}We have already fixed this issue for event checkout{color} and now we are going to address the issue for the store checkout page.
	#* You can find the list of checkout pages and their capabilities here:
	#** [https://docs.google.com/spreadsheets/d/10B1L5V8c6mQ7giiAjtjxJXp5yq2mYlmNKPmyT5MwBkE/edit?usp=sharing|https://docs.google.com/spreadsheets/d/10B1L5V8c6mQ7giiAjtjxJXp5yq2mYlmNKPmyT5MwBkE/edit?usp=sharing]
	#* Both Store and Event heckout pages hosted in the LTE package
	#
	#Estimate
	#
	#QA: 20h
	@REQ_PD-26903 @TEST_PD-27077 @regression @22Winter @21Winter @svinjamuri
	Scenario: To validate Multi-select picklist at guest checkout are Available
		When User navigate to community Portal page
		And User select an item "AutoItem1" from the store and add it to your cart and proceed to the checkout page
		And User select Continue as a Guest option
		And User fills in First, Last Name and Email
		When User clicks the multi selector drop down in checkout page
		Then User should see the options in the multi select drop down
