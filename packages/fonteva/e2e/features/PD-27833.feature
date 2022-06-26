@REQ_PD-27833
Feature: Transaction and Transaction Lines are missing when trying to Renew a Subscription.
	#*Case Reporter* Tanya Renne
	#
	#*Customer* American Choral Directors Association
	#
	#*Reproduced by* Shivani Thakur in 21Winter.0.4,21Winter.0.2,21Winter.0.5
	#
	#*Reference Case#* [00031014|https://fonteva.my.salesforce.com/5004V000017HQQEQA4]
	#
	#*Description:*
	#
	#Transaction and Transaction lines are missing when trying to renew a subscription.
	#
	#*Steps to Reproduce:*
	#
	#Org ID: 00D4x0000069oJv
	#
	#-Login from Subscriber
	#
	#Steps:
	#
	## Create Subscription Item with Package Items, Renewable path, and access permissions. Also, Enable "Enable Access Permissions" flag on Item. Below is the link to the Item used in GCO: [https://gcocl8xb8.my.salesforce.com/a154x000000bRLKAA2|https://gcocl8xb8.my.salesforce.com/a154x000000bRLKAA2]
	## Purchase this subscription for any Community Portal User. The link to Contact used in GCO: [https://gcocl8xb8.my.salesforce.com/0034x000007zOXE|https://gcocl8xb8.my.salesforce.com/0034x000007zOXE]
	## Try to Renew this subscription as Community Portal User. After checkout, you will get a receipt. Cross-check this receipt, this is missing Transaction and Transaction lines. Receipt created in GCO: [https://gcocl8xb8.my.salesforce.com/a1E4x000001xntd?srPos=0&srKp=a1E|https://gcocl8xb8.my.salesforce.com/a1E4x000001xntd?srPos=0&srKp=a1E]
	#
	#Link to video of issue journey reproduced on GCO:
	#
	#[https://fonteva.zoom.us/rec/play/mgQTMIXQFEPDuLcbOwXRJn9gxD57gyClCey30Eo6UNEi8GcZZtzsb1RifZ3TTWqiH\\_qM\\_Bz07drfaWex.EQk-KgsmGRDLGitN?autoplay=true&startTime=1627053127000|https://fonteva.zoom.us/rec/play/mgQTMIXQFEPDuLcbOwXRJn9gxD57gyClCey30Eo6UNEi8GcZZtzsb1RifZ3TTWqiH_qM_Bz07drfaWex.EQk-KgsmGRDLGitN?autoplay=true&startTime=1627053127000]
	#
	#*Actual Results:*
	#
	#Transaction and Transaction Lines are missing, when we renew the subscription having an item with enabled "Enable Access Permissions".
	#
	#*Expected Results:*
	#
	#All generated receipts, SOs and SOLs, should have related Transactions and Transaction Lines.
	#
	#*Business Justification:*
	#
	#Transactions and Transaction Lines are not created, which is causing issues with accounting.
	#
	#
	#
	#*T3 Notes:*
	#
	#Looks like it’s related to this issue: [https://fonteva.atlassian.net/browse/PD-25460|https://fonteva.atlassian.net/browse/PD-25460|smart-link]
	#
	#But this time, it’s failing in [ReportingJournalService|https://github.com/Fonteva/FDServiceVersions/blob/21Winter/src/api/main/classes/ReportingJournalService.cls] instead of JournalService, most likely because multi-currency is enabled in the customer’s org. We need to add the same fix like [this PR|https://github.com/Fonteva/FDServiceVersions/pull/907/files], but for ReportingJournalService.
	#
	#NOTE: Null pointer exception is thrown at [this line|https://github.com/Fonteva/FDServiceVersions/blob/21Winter/src/api/main/classes/ReportingJournalService.cls#L304] of code.

	#Tests *Case Reporter* Tanya Renne
	#
	#*Customer* American Choral Directors Association
	#
	#*Reproduced by* Shivani Thakur in 21Winter.0.4,21Winter.0.2,21Winter.0.5
	#
	#*Reference Case#* [00031014|https://fonteva.my.salesforce.com/5004V000017HQQEQA4]
	#
	#*Description:*
	#
	#Transaction and Transaction lines are missing when trying to renew a subscription.
	#
	#*Steps to Reproduce:*
	#
	#Org ID: 00D4x0000069oJv
	#
	#-Login from Subscriber
	#
	#Steps:
	#
	## Create Subscription Item with Package Items, Renewable path, and access permissions. Also, Enable "Enable Access Permissions" flag on Item. Below is the link to the Item used in GCO: [https://gcocl8xb8.my.salesforce.com/a154x000000bRLKAA2|https://gcocl8xb8.my.salesforce.com/a154x000000bRLKAA2]
	## Purchase this subscription for any Community Portal User. The link to Contact used in GCO: [https://gcocl8xb8.my.salesforce.com/0034x000007zOXE|https://gcocl8xb8.my.salesforce.com/0034x000007zOXE]
	## Try to Renew this subscription as Community Portal User. After checkout, you will get a receipt. Cross-check this receipt, this is missing Transaction and Transaction lines. Receipt created in GCO: [https://gcocl8xb8.my.salesforce.com/a1E4x000001xntd?srPos=0&srKp=a1E|https://gcocl8xb8.my.salesforce.com/a1E4x000001xntd?srPos=0&srKp=a1E]
	#
	#Link to video of issue journey reproduced on GCO:
	#
	#[https://fonteva.zoom.us/rec/play/mgQTMIXQFEPDuLcbOwXRJn9gxD57gyClCey30Eo6UNEi8GcZZtzsb1RifZ3TTWqiH\\_qM\\_Bz07drfaWex.EQk-KgsmGRDLGitN?autoplay=true&startTime=1627053127000|https://fonteva.zoom.us/rec/play/mgQTMIXQFEPDuLcbOwXRJn9gxD57gyClCey30Eo6UNEi8GcZZtzsb1RifZ3TTWqiH_qM_Bz07drfaWex.EQk-KgsmGRDLGitN?autoplay=true&startTime=1627053127000]
	#
	#*Actual Results:*
	#
	#Transaction and Transaction Lines are missing, when we renew the subscription having an item with enabled "Enable Access Permissions".
	#
	#*Expected Results:*
	#
	#All generated receipts, SOs and SOLs, should have related Transactions and Transaction Lines.
	#
	#*Business Justification:*
	#
	#Transactions and Transaction Lines are not created, which is causing issues with accounting.
	#
	#
	#
	#*T3 Notes:*
	#
	#Looks like it’s related to this issue: [https://fonteva.atlassian.net/browse/PD-25460|https://fonteva.atlassian.net/browse/PD-25460|smart-link]
	#
	#But this time, it’s failing in [ReportingJournalService|https://github.com/Fonteva/FDServiceVersions/blob/21Winter/src/api/main/classes/ReportingJournalService.cls] instead of JournalService, most likely because multi-currency is enabled in the customer’s org. We need to add the same fix like [this PR|https://github.com/Fonteva/FDServiceVersions/pull/907/files], but for ReportingJournalService.
	#
	#NOTE: Null pointer exception is thrown at [this line|https://github.com/Fonteva/FDServiceVersions/blob/21Winter/src/api/main/classes/ReportingJournalService.cls#L304] of code.
	@TEST_PD-29216 @REQ_PD-27833 @21Winter @22Winter @ngunda @regression
	Scenario: Test Transaction and Transaction Lines are missing when trying to Renew a Subscription.
		Given User creates salesOrders with information provided below:
			| Contact      | Account            | BusinessGroup | Entity  | PostingEntity | ScheduleType   | ItemName                                   | Qty |
			| Max Foxworth | Foxworth Household | Foundation    | Contact | Invoice       | Simple Invoice | TermedSubwithRenewalsPIandAccessPermission | 1   |
		And User marks the created orders as ready for payment
		And User "Max Foxworth" makes "Balance Due" payment for the created order
		When User navigate to community Portal page with "maxfoxworth@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User will select the "Subscriptions" page in LT Portal
		Then User should be able to click on "renew" subscription purchased using "restService"
		And User should be able to select "TermedSubwithRenewalsPIandAccessPermission" renew item
		And User should be able to select additional items
			| name      |
			| AutoItem1 |
		And User select assign members for subscription
			| name         | role  |
			| Max Foxworth | Admin |
		And User navigate to checkout from shopping cart page
		And User successfully pays for the order using credit card
		Then User should see the "invoice" created confirmation message
		And User verifies generated receipt has the Transaction and Transaction lines created
