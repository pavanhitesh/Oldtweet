@REQ_PD-27973
Feature: Apply Payment Page Error when Entity = Account and Billing Address Entered
	#*Case Reporter* Himali Shah
	#
	#*Customer* Material Handling Industry
	#
	#*Reproduced by* Linda Diemer in 20Spring.1.12,20Spring.1.11
	#
	#*Reference Case#* [00031159|https://fonteva.my.salesforce.com/5004V000017IOleQAG]
	#
	#*Org to Reproduce:*
	#
	#in my GCO ( [20spring.1@fondash.io|mailto:20spring.1@fondash.io] ,Pass: Fonteva703 )
	#
	#*Recording:*
	#
	#[https://recordit.co/6WwOTvyY8A|https://recordit.co/6WwOTvyY8A]
	#
	#*Description:*
	#
	#We should be able to process ROE for both Accounts and Contacts without encountering an error.
	#
	#*Steps to Reproduce:*
	#
	## Go to *Account*: Alfreda Jones Household ([https://gcogaw8n4.lightning.force.com/lightning/r/Account/0015Y00002azfhzQAA/view)|https://gcogaw8n4.lightning.force.com/lightning/r/Account/0015Y00002azfhzQAA/view)]
	## ROE
	## Add Any Item and Process Payment
	## Select Credit Card and Apply Payment
	## Fill in Credit card details and *Add Billing Addresses even if it's not required.*
	## Save and see there is a System Log Error
	#
	#
	#
	#{noformat}System Log Error:
	#
	#==== ** Exception Message ** ====
	#
	#Insert failed. First exception on row 0; first error:
	#FIELD_INTEGRITY_EXCEPTION, Contact: id value of incorrect type: 0015Y00002azfhzQAA:
	#[OrderApi__Contact__c]{noformat}
	#
	#
	#
	#*Actual Results:*
	#
	#A system log error is seen and we are not able to proceed to process payment.
	#
	#*Expected Results:*
	#
	#For the Payment to Process successfully
	#
	#KA is created and Contact lookup populated (selected contact on the apply payment page)
	#
	#No system log is generated.
	#
	#
	#
	#*Business Justification:*
	#
	#Impacting in revenue for pending invoices with an upcoming due date with Entity as Account
	#
	#*CS Note:*
	#This issue is not happening if you do ROE from a Contact, where Entity =Contact
	#
	#*T3 Notes:*
	#
	#Cannot repro in 20Winter.0.5 / 20Spring.1.13
	#
	#
	#
	#*PM NOTE:*
	#
	#I think this. is happening bc the Known Address object does not have a lookup to the Account object, and since SO type is account looks like the page is trying to populate account id on a contact lookup.
	#
	#Use the contact from the page to populate contact lookup for KA
	#
	#DEV NOTE: Look for this.customerId, it should be this.conatctId (reach out. to [~accountid:6076f91ac642ff0070f2e02a] )

	#Tests *Case Reporter* Himali Shah
	#
	#*Customer* Material Handling Industry
	#
	#*Reproduced by* Linda Diemer in 20Spring.1.12,20Spring.1.11
	#
	#*Reference Case#* [00031159|https://fonteva.my.salesforce.com/5004V000017IOleQAG]
	#
	#*Org to Reproduce:*
	#
	#in my GCO ( [20spring.1@fondash.io|mailto:20spring.1@fondash.io] ,Pass: Fonteva703 )
	#
	#*Recording:*
	#
	#[https://recordit.co/6WwOTvyY8A|https://recordit.co/6WwOTvyY8A]
	#
	#*Description:*
	#
	#We should be able to process ROE for both Accounts and Contacts without encountering an error.
	#
	#*Steps to Reproduce:*
	#
	## Go to *Account*: Alfreda Jones Household ([https://gcogaw8n4.lightning.force.com/lightning/r/Account/0015Y00002azfhzQAA/view)|https://gcogaw8n4.lightning.force.com/lightning/r/Account/0015Y00002azfhzQAA/view)]
	## ROE
	## Add Any Item and Process Payment
	## Select Credit Card and Apply Payment
	## Fill in Credit card details and *Add Billing Addresses even if it's not required.*
	## Save and see there is a System Log Error
	#
	#
	#
	#{noformat}System Log Error:
	#
	#==== ** Exception Message ** ====
	#
	#Insert failed. First exception on row 0; first error:
	#FIELD_INTEGRITY_EXCEPTION, Contact: id value of incorrect type: 0015Y00002azfhzQAA:
	#[OrderApi__Contact__c]{noformat}
	#
	#
	#
	#*Actual Results:*
	#
	#A system log error is seen and we are not able to proceed to process payment.
	#
	#*Expected Results:*
	#
	#For the Payment to Process successfully
	#
	#KA is created and Contact lookup populated (selected contact on the apply payment page)
	#
	#No system log is generated.
	#
	#
	#
	#*Business Justification:*
	#
	#Impacting in revenue for pending invoices with an upcoming due date with Entity as Account
	#
	#*CS Note:*
	#This issue is not happening if you do ROE from a Contact, where Entity =Contact
	#
	#*T3 Notes:*
	#
	#Cannot repro in 20Winter.0.5 / 20Spring.1.13
	#
	#
	#
	#*PM NOTE:*
	#
	#I think this. is happening bc the Known Address object does not have a lookup to the Account object, and since SO type is account looks like the page is trying to populate account id on a contact lookup.
	#
	#Use the contact from the page to populate contact lookup for KA
	#
	#DEV NOTE: Look for this.customerId, it should be this.conatctId (reach out. to [~accountid:6076f91ac642ff0070f2e02a] )
	@TEST_PD-28427 @REQ_PD-27973 @21Winter @22Winter @regression @ngunda
	Scenario: Test Apply Payment Page Error when Entity = Account and Billing Address Entered
		Given User will select "Gundas HouseHold" account
		When User opens the Rapid Order Entry page from account
		And User should be able to add "AutoItem6" item on rapid order entry
		And User selects "Process Payment" as payment method and proceeds further
		Then User applies payment using "Credit Card" as payment type by entering below Billing Address details:
			| Name                 | Type | Street          | City    | State | PostalCode |
			| Test Billing Address | Home | 123 Main street | Houston | Texas | 505123     |
