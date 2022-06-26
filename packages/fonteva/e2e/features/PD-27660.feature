@REQ_PD-27660
Feature: Lookup field label is displaying incorrectly on portal
	#*Case Reporter* Diego Alzugaray
	#
	#*Customer* The Association For Manufacturing Technology
	#
	#*Reproduced by* Diego Alzugaray in 21Winter.0.5
	#
	#*Reference Case#* [00031388|https://fonteva.my.salesforce.com/5004V000017KEoEQAW]
	#
	#*Description:*
	#
	#AMT prompts their users to fill out the essential contacts for their company (Sales contact, Accounting contact, Membership Dues contact etc). AMT uses these values to know to who they need to send certain information to.
	#
	#
	#
	#*PM NOTE:*
	#
	#Looks like we are hard coding the contact lookup labels. It should always display the label of the field, dynamically.
	#
	#We know that it is happening for contact lookups on the account, but it is a good idea to test with some other look-up fields too, just to be safe. (You can create any lookups like create a lookup to badge object)
	#
	#Make sure to populate different values on the lookups to make sure issue is only for field label not the value
	#
	#
	#
	#*Org to Reproduce*
	#
	#2nd org Username: [21wintermc@fondash.io|mailto:21wintermc@fondash.io] Password: Fonteva703
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#1) Go to setup
	#
	#2) Go to the object manager
	#
	#3) Go to the Account object
	#
	#4) Go to Field Sets
	#
	#5) Add "Primary Contact" to the portal fieldset
	#
	#6) Go to a contact record
	#
	#7) Assign the contact a badge that will allow them to see "Company Info" in the portal
	#
	#8) Log in to the community as the contact
	#
	#9) Go to the "Company Info" tab
	#
	#*Actual Results:*
	#
	#The field label says "Contact Name"
	#
	#*Expected Results:*
	#
	#The field label should say "Primary Contact"
	#
	#
	#
	#*Business Justification:*
	#
	#This is bad UI as AMT has 6 look-ups to contact for different essential contacts, but they all just say "Contact Name" This will be a go-live blocker for AMT
	#
	#
	#
	#*CS Note:*
	#This used to display correctly until 21Winter.5 was installed.

	#Tests *Case Reporter* Diego Alzugaray
	#
	#*Customer* The Association For Manufacturing Technology
	#
	#*Reproduced by* Diego Alzugaray in 21Winter.0.5
	#
	#*Reference Case#* [00031388|https://fonteva.my.salesforce.com/5004V000017KEoEQAW]
	#
	#*Description:*
	#
	#AMT prompts their users to fill out the essential contacts for their company (Sales contact, Accounting contact, Membership Dues contact etc). AMT uses these values to know to who they need to send certain information to.
	#
	#
	#
	#*PM NOTE:*
	#
	#Looks like we are hard coding the contact lookup labels. It should always display the label of the field, dynamically.
	#
	#We know that it is happening for contact lookups on the account, but it is a good idea to test with some other look-up fields too, just to be safe. (You can create any lookups like create a lookup to badge object)
	#
	#Make sure to populate different values on the lookups to make sure issue is only for field label not the value
	#
	#
	#
	#*Org to Reproduce*
	#
	#2nd org Username: [21wintermc@fondash.io|mailto:21wintermc@fondash.io] Password: Fonteva703
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#1) Go to setup
	#
	#2) Go to the object manager
	#
	#3) Go to the Account object
	#
	#4) Go to Field Sets
	#
	#5) Add "Primary Contact" to the portal fieldset
	#
	#6) Go to a contact record
	#
	#7) Assign the contact a badge that will allow them to see "Company Info" in the portal
	#
	#8) Log in to the community as the contact
	#
	#9) Go to the "Company Info" tab
	#
	#*Actual Results:*
	#
	#The field label says "Contact Name"
	#
	#*Expected Results:*
	#
	#The field label should say "Primary Contact"
	#
	#
	#
	#*Business Justification:*
	#
	#This is bad UI as AMT has 6 look-ups to contact for different essential contacts, but they all just say "Contact Name" This will be a go-live blocker for AMT
	#
	#
	#
	#*CS Note:*
	#This used to display correctly until 21Winter.5 was installed.
	@REQ_PD-27660 @TEST_PD-27958 @regression @21Winter @22Winter @sophiya
	Scenario: Test Lookup field label is displaying incorrectly on portal
		//Needed fields should be added to the fieldset manually before running the script
		Given User navigate to community Portal page with "davidbrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		Then User will select the "My Company Info" page in LT Portal
		And User will verify the fieldset fields in portal that has following details
			| Field                                     | Label                        |
			| OrderApi__Primary_Contact__c              | Primary Contact              |
			| DonorApi__Primary_Relationship_Manager__c | Primary Relationship Manager |
			| CreatedById                               | User Name                    |
