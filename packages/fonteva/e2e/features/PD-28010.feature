@REQ_PD-28010
Feature: Inserted a credit memo as posted and it is not available to be used - Credit Memo should not be applied
	#*Case Reporter* Julie Smith
	#
	#*Customer* Military Officers Association of America
	#
	#*Reproduced by* Aaron Gremillion in 2019.1.0.32,20Spring.0.7,20Spring.1.2,21Winter.0.0
	#
	#*Reference Case#* [00029471|https://fonteva.my.salesforce.com/5004V000014kRxvQAE]
	#
	#*Description:*
	#Incorrectly created a Posted Credit Memo (did not follow directions and bypassed saving in a draft status so no transactions are created). After applying it to an Invoice, when the Invoice record displays, the credit memo has not been applied (Credits Applied field is empty) and the Invoice's Accounts receivable is not credited.
	#
	#*Steps to Reproduce:*
	#
	#
	#*STEP1*
	#
	#* Create an Invoice for a Contact (SO type invoice)
	#* Mark as ready for payment
	#
	#*STEP2*
	#
	#* *_Create a Posted Credit Memo: (We are manually creating a credit memo)_*
	#** Status = Posted
	#**  {color:#00b8d9}*Important*{color}: Do Not identify as Draft then post because it will create new Transactions and that’s already been done when staff created a Refund).
	#*  Entity = Contact
	#*  Amount = 100
	#* Credit Account = Credit Memo Liability Account
	#* Debit Account = Doesn’t Matter (this field isn't being referenced so it doesn't matter what you enter)
	#* Posted Date = Today
	#
	#
	#*STEP3*
	#
	#* Access the Invoice you created
	#* Click, Apply Payment
	#* Validate the Available Credit field displays the Credit Memo amount entered in step 1
	#* Check the checkbox, Apply Credit to Payment
	#*  In the field, Payment Amount or Check Amount, zero out the enter (field value = $0)
	#** {color:#00b8d9}*This mean pay the whole thing with a credit*{color}
	#* Scroll to the bottom of the page and validate the 'CREDIT APPLIED' displays the credit amount entered and the BALANCE DUE correctly displays the anticipated net balance due
	#* Click the button, Apply Payment
	#
	#
	#
	#*Actual Results:*
	#When the Invoice displays:
	#
	#* The field, Credits Applied, displays a $0 value
	#* The field, Balance Due, displays the full balance due
	#
	#
	#
	#*Expected Results:*
	#
	#When the Invoice displays:
	#
	#* The field, Credits Applied, displays the credit memo amount
	#* The field, Balance Due, displays the net balance due displayed on the Payment page

	#Tests *Case Reporter* Julie Smith
	#
	#*Customer* Military Officers Association of America
	#
	#*Reproduced by* Aaron Gremillion in 2019.1.0.32,20Spring.0.7,20Spring.1.2,21Winter.0.0
	#
	#*Reference Case#* [00029471|https://fonteva.my.salesforce.com/5004V000014kRxvQAE]
	#
	#*Description:*
	#Incorrectly created a Posted Credit Memo (did not follow directions and bypassed saving in a draft status so no transactions are created). After applying it to an Invoice, when the Invoice record displays, the credit memo has not been applied (Credits Applied field is empty) and the Invoice's Accounts receivable is not credited.
	#
	#*Steps to Reproduce:*
	#
	#
	#*STEP1*
	#
	#* Create an Invoice for a Contact (SO type invoice)
	#* Mark as ready for payment
	#
	#*STEP2*
	#
	#* *_Create a Posted Credit Memo: (We are manually creating a credit memo)_*
	#** Status = Posted
	#**  {color:#00b8d9}*Important*{color}: Do Not identify as Draft then post because it will create new Transactions and that’s already been done when staff created a Refund).
	#*  Entity = Contact
	#*  Amount = 100
	#* Credit Account = Credit Memo Liability Account
	#* Debit Account = Doesn’t Matter (this field isn't being referenced so it doesn't matter what you enter)
	#* Posted Date = Today
	#
	#
	#*STEP3*
	#
	#* Access the Invoice you created
	#* Click, Apply Payment
	#* Validate the Available Credit field displays the Credit Memo amount entered in step 1
	#* Check the checkbox, Apply Credit to Payment
	#*  In the field, Payment Amount or Check Amount, zero out the enter (field value = $0)
	#** {color:#00b8d9}*This mean pay the whole thing with a credit*{color}
	#* Scroll to the bottom of the page and validate the 'CREDIT APPLIED' displays the credit amount entered and the BALANCE DUE correctly displays the anticipated net balance due
	#* Click the button, Apply Payment
	#
	#
	#
	#*Actual Results:*
	#When the Invoice displays:
	#
	#* The field, Credits Applied, displays a $0 value
	#* The field, Balance Due, displays the full balance due
	#
	#
	#
	#*Expected Results:*
	#
	#When the Invoice displays:
	#
	#* The field, Credits Applied, displays the credit memo amount
	#* The field, Balance Due, displays the net balance due displayed on the Payment page
	@TEST_PD-28781 @REQ_PD-28010 @21Winter @22Winter @regression @ngunda
	Scenario Outline: Test Inserted a credit memo as posted and it is not available to be used - Credit Memo should not be applied
		Given User creates salesOrders with information provided below:
			| Contact   | Account   | BusinessGroup   | Entity   | PostingEntity | ScheduleType   | ItemName   | Qty |
			| <Contact> | <Account> | <BusinessGroup> | <Entity> | Invoice       | Simple Invoice | <ItemName> | 1   |
		And User marks the created orders as ready for payment
		When User creates Credit Memo with below information:
			| Account   | BusinessGroup   | Contact   | Status | Entity   | Amount   | PostedDate  | isPosted | DebitAccount | CreditAccount                     |
			| <Account> | <BusinessGroup> | <Contact> | Posted | <Entity> | <Amount> | CurrentDate | true     | 1000 - Cash  | 5000-01 - Foundation Credit Memos |
		And User opens the SalesOrder created and navigates to apply payment page and verifies available credit is "<Amount>"
		And User makes payment for "<ItemName>" using credits
		Then User verifies the credits applied and Balance due values

		Examples:
			| Contact      | Account          | BusinessGroup | Entity  | ItemName  | Amount |
			| Mannik Gunda | Gundas HouseHold | Foundation    | Contact | AutoItem6 | 100    |
