@REQ_PD-27745
Feature: Account-level Credit Memo in Draft status shows up as Available Credit on Apply Payment page
	#*Case Reporter* James Simpson
	#
	#*Customer* Raybourn Group International
	#
	#*Reproduced by* Eli Nesson in 20Spring.0.13,20Spring.0.16
	#
	#*Reference Case#* [00028227|https://fonteva.my.salesforce.com/5004V000013atd1QAA]
	#
	#*Description:*
	#
	#*Account*-level Credit Memo in Draft status shows up as Available Credit on Apply Payment page
	#
	#Screen recording:
	#
	# [https://www.screencast.com/t/kwFtri5IAG|https://www.screencast.com/t/kwFtri5IAG]
	#
	#*Steps to Reproduce:*
	#
	## From an Account record's Credit Memo related list, create a new one with an amount, but leave it in Draft status
	## Open ROE from the Account, add an item, proceed to payment
	#
	#*Actual Results:*
	#
	#On the Apply Payment screen, an Available Credit appears for the amount of the Draft Credit Memo.
	#
	#*Expected Results:*
	#
	#Credit Memos only count as Available Credit when they are posted.
	#
	#*Business Justification:*
	#
	#Inaccurate accounting of available credits
	#
	#
	#
	#*PM NOTE:*
	#
	#* Apply Payment Page is in LTE.
	#* We *do NOT* want to rely on _OrderApi__Outstanding_Credits__c_ field on the account and contact.
	#* We rely on the actual Credit Memo records, we need to loop and only bring the posted records.
	#* We d not wanna show draft Credit Memos.
	#* Credit Memo has Is Posted checkbox. we can rely on, do not implement a logic using the status picklist
	#* Remember depending on the Sales Order entity being account or contact, we get the related credit memo records either from the account or contact
	#** Make sure to test both scenarios
	#** But apparently, it is working fine for the contact scenario, the bug is only reported for the entity account scenario.
	#* *FOR QA:* See the existing automation and potentially update that.

	#Tests *Case Reporter* James Simpson
	#
	#*Customer* Raybourn Group International
	#
	#*Reproduced by* Eli Nesson in 20Spring.0.13,20Spring.0.16
	#
	#*Reference Case#* [00028227|https://fonteva.my.salesforce.com/5004V000013atd1QAA]
	#
	#*Description:*
	#
	#*Account*-level Credit Memo in Draft status shows up as Available Credit on Apply Payment page
	#
	#Screen recording:
	#
	# [https://www.screencast.com/t/kwFtri5IAG|https://www.screencast.com/t/kwFtri5IAG]
	#
	#*Steps to Reproduce:*
	#
	## From an Account record's Credit Memo related list, create a new one with an amount, but leave it in Draft status
	## Open ROE from the Account, add an item, proceed to payment
	#
	#*Actual Results:*
	#
	#On the Apply Payment screen, an Available Credit appears for the amount of the Draft Credit Memo.
	#
	#*Expected Results:*
	#
	#Credit Memos only count as Available Credit when they are posted.
	#
	#*Business Justification:*
	#
	#Inaccurate accounting of available credits
	#
	#
	#
	#*PM NOTE:*
	#
	#* Apply Payment Page is in LTE.
	#* We *do NOT* want to rely on _OrderApi__Outstanding_Credits__c_ field on the account and contact.
	#* We rely on the actual Credit Memo records, we need to loop and only bring the posted records.
	#* We d not wanna show draft Credit Memos.
	#* Credit Memo has Is Posted checkbox. we can rely on, do not implement a logic using the status picklist
	#* Remember depending on the Sales Order entity being account or contact, we get the related credit memo records either from the account or contact
	#** Make sure to test both scenarios
	#** But apparently, it is working fine for the contact scenario, the bug is only reported for the entity account scenario.
	#* *FOR QA:* See the existing automation and potentially update that.
	@TEST_PD-28189 @REQ_PD-27745 @regression @21Winter @22Winter @ngunda
	Scenario: Test Account-level Credit Memo in Draft status shows up as Available Credit on Apply Payment page
		Given User creates Credit Memo with below information:
			| Account          | BusinessGroup | Contact      | Status | Entity  | Amount | PostedDate  | isPosted | DebitAccount | CreditAccount                     |
			| Gundas HouseHold | Foundation    | Mannik Gunda | Draft  | Account | 150    | CurrentDate | false    | 1000 - Cash  | 5000-01 - Foundation Credit Memos |
		When User will select "Gundas HouseHold" account
		And User opens the Rapid Order Entry page from account
		And User should be able to add "AutoItem6" item on rapid order entry
		And User selects "Process Payment" as payment method and proceeds further
		Then User verifies draft credit Memo amount is not displayed as available credit
