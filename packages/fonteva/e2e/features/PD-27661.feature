@REQ_PD-27661
Feature: Contact criteria created for the price rule are duplicated upon saving.
	#*Case Reporter* Sunita Kode
	#
	#*Customer* American Academy of Family Physicians
	#
	#*Reproduced by* Sandeep Bangwal in 21Winter.0.5
	#
	#*Reference Case#* [00031359|https://fonteva.my.salesforce.com/5004V000017K4lJQAS]
	#
	#*Description:*
	#
	#The customer is experiencing an issue while managing the price rule for a ticket type in the event while adding the contact-based criteria on the price it duplicates the criteria upon saving the price rule.
	#
	#
	#
	#*Recording:*
	#
	# [https://drive.google.com/file/d/1Bozi_SkkYSy-y6IzboZ8zzGQQAj7DOGU/view?usp=sharing|https://drive.google.com/file/d/1Bozi_SkkYSy-y6IzboZ8zzGQQAj7DOGU/view?usp=sharing|smart-link] Also added as an attachment
	#
	#
	#
	#*PM NOTE:*
	#
	#Try with regular merchandise item, if you cannot repro then try with event and ticket type (remember ticket type creates item behind the scene and uses the same price rule builder page)
	#
	#*Price Rule* is an object under the Item
	#
	#*Price Rule Variable* is also an object under the Price Rule (My guess is this record gets inserted twice or displayed twice somehow)
	#
	#
	#
	#*Org to Reproduce:*
	#GCO Details: Org ID: 00D5Y000001NF95 
	#
	#[https://gcon4qrsd.lightning.force.com/lightning/page/home?0.source=alohaHeader|https://gcon4qrsd.lightning.force.com/lightning/page/home?0.source=alohaHeader] 
	#
	#Username: [enesson-20r2b@fonteva.com|mailto:enesson-20r2b@fonteva.com] 
	#
	#Password: Fonteva703
	#
	#Url to the event record: [https://gcon4qrsd.lightning.force.com/lightning/r/EventApi__Event__c/a1Y5Y000008D7qzUAC/view|https://gcon4qrsd.lightning.force.com/lightning/r/EventApi]
	#
	#
	#
	#*Steps to Reproduce:*
	#
	## Created a similar checkbox field for the contact object.
	#
	#> Name of the field: AAFP_isAAFPStaff
	#
	#>Data type: Checkbox
	#
	## Created a Lightning Event and set the status of the event to active.
	## Created a Ticket type.
	## Choose to edit the price rule for the ticket type.
	## Upon saving contact-based criteria for the new price rule, it duplicates the criteria.
	## 
	#
	#*Actual Results:*
	#
	#The criteria are duplicating upon saving the price rule.
	#
	#
	#
	#*Expected Results:*
	#
	#The criteria created for the price rule should not be duplicated

	#Tests *Case Reporter* Sunita Kode
	#
	#*Customer* American Academy of Family Physicians
	#
	#*Reproduced by* Sandeep Bangwal in 21Winter.0.5
	#
	#*Reference Case#* [00031359|https://fonteva.my.salesforce.com/5004V000017K4lJQAS]
	#
	#*Description:*
	#
	#The customer is experiencing an issue while managing the price rule for a ticket type in the event while adding the contact-based criteria on the price it duplicates the criteria upon saving the price rule.
	#
	#
	#
	#*Recording:*
	#
	# [https://drive.google.com/file/d/1Bozi_SkkYSy-y6IzboZ8zzGQQAj7DOGU/view?usp=sharing|https://drive.google.com/file/d/1Bozi_SkkYSy-y6IzboZ8zzGQQAj7DOGU/view?usp=sharing|smart-link] Also added as an attachment
	#
	#
	#
	#*PM NOTE:*
	#
	#Try with regular merchandise item, if you cannot repro then try with event and ticket type (remember ticket type creates item behind the scene and uses the same price rule builder page)
	#
	#*Price Rule* is an object under the Item
	#
	#*Price Rule Variable* is also an object under the Price Rule (My guess is this record gets inserted twice or displayed twice somehow)
	#
	#
	#
	#*Org to Reproduce:*
	#GCO Details: Org ID: 00D5Y000001NF95 
	#
	#[https://gcon4qrsd.lightning.force.com/lightning/page/home?0.source=alohaHeader|https://gcon4qrsd.lightning.force.com/lightning/page/home?0.source=alohaHeader] 
	#
	#Username: [enesson-20r2b@fonteva.com|mailto:enesson-20r2b@fonteva.com] 
	#
	#Password: Fonteva703
	#
	#Url to the event record: [https://gcon4qrsd.lightning.force.com/lightning/r/EventApi__Event__c/a1Y5Y000008D7qzUAC/view|https://gcon4qrsd.lightning.force.com/lightning/r/EventApi]
	#
	#
	#
	#*Steps to Reproduce:*
	#
	## Created a similar checkbox field for the contact object.
	#
	#> Name of the field: AAFP_isAAFPStaff
	#
	#>Data type: Checkbox
	#
	## Created a Lightning Event and set the status of the event to active.
	## Created a Ticket type.
	## Choose to edit the price rule for the ticket type.
	## Upon saving contact-based criteria for the new price rule, it duplicates the criteria.
	## 
	#
	#*Actual Results:*
	#
	#The criteria are duplicating upon saving the price rule.
	#
	#
	#
	#*Expected Results:*
	#
	#The criteria created for the price rule should not be duplicated
	@REQ_PD-27661 @TEST_PD-27880 @regression @21Winter @22Winter @sophiya
	Scenario: Test Contact criteria created for the price rule are duplicated upon saving.
		Given User opens the Price rule for "AutoItem2" Item
		Then User creates new price rule "AutoPriceRule"
		And User saves price rule criteria with "<Object>" "<Field>" "<Operator>" "<Value>" and verifies "AutoPriceRule"
		Examples:
			| Object   | Field                           | Operator | Value |
			| contact  | orderapi__is_primary_contact__c | equals   | true  |
