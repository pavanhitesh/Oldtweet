@REQ_PD-28074
Feature: Item is not populating on transaction lines created by applying a credit memo
	#*Case Reporter* Diego Alzugaray
	#
	#*Customer* Association for the Advancement of Medical Instrumentation
	#
	#*Reproduced by* Erich Ehinger in 20Spring.0.2
	#
	#*Reference Case#* [00024442|https://fonteva.my.salesforce.com/5004V000011RLFtQAO]
	#
	#*Description:*
	#
	#Item is not populating on transaction lines created by applying a credit memo
	#
	#*Steps to Reproduce:*
	#
	#1. Go to Contact.
	#
	#2. Navigate to the Related List.
	#
	#3. Credit Memos.
	#
	#4. Create a New Credit memo.
	#
	#5. Populate the Account Field.
	#
	#6. Populate the Business Group.
	#
	#7. Populate the Amount filed ( Orginal Ticket Price) that the user has purchased.
	#
	#8. Set Debit Account = 2445 - Refunds Clearing
	#
	#9. Set Credit Account = 2445 - Refunds Clearing
	#
	#10. Set Entity = Contact
	#
	#11. Status = Posted.
	#
	#12. Posted Date = Today's Date.
	#
	#13. Please see below the sample screenshot to set up the Credit memo.
	#
	#14. Go to Contact.
	#
	#15. Select Rapid Order Entry (ROE).
	#
	#16. Search for the Ticket Type (Item) that the user is willing to transfer at a later time.
	#
	#17. Hit “Add to Order”
	#
	#18. Exit Sales Order (This step is to avoid filling out the form)
	#
	#19. Edit Sales Order and change Posting Entity to Invoice and Schedule Type to Simple Invoice
	#
	#20. Press “Ready for Payment”
	#
	#21. Now copy the Sales Order Line number.
	#
	#22. Go to Contact
	#
	#23. Go to the Credit memo.
	#
	#24. Go to the New Credit Memo line.
	#
	#25. Populate the Sales Order Line.
	#
	#26. Amount = Credit Memo amount
	#
	#27. Liability Account = 1200 A/R
	#
	#28. Change the Status to “Draft” and Save.
	#
	#29. Now Edit Credit Memo Line again and change Status = Posted
	#
	#30. Save the record.
	#
	#31. Now Go back to the Sales Order to check the transaction Lines.
	#
	#*Actual Results:*
	#
	#Item is not populated on the Transaction Lines (on the Transaction with Type=Credit Memo Applied)
	#
	#*Expected Results:*
	#
	#Item should be populated on transaction line (on Transaction with Type=Credit Memo Applied)

	#Tests *Case Reporter* Diego Alzugaray
	#
	#*Customer* Association for the Advancement of Medical Instrumentation
	#
	#*Reproduced by* Erich Ehinger in 20Spring.0.2
	#
	#*Reference Case#* [00024442|https://fonteva.my.salesforce.com/5004V000011RLFtQAO]
	#
	#*Description:*
	#
	#Item is not populating on transaction lines created by applying a credit memo
	#
	#*Steps to Reproduce:*
	#
	#1. Go to Contact.
	#
	#2. Navigate to the Related List.
	#
	#3. Credit Memos.
	#
	#4. Create a New Credit memo.
	#
	#5. Populate the Account Field.
	#
	#6. Populate the Business Group.
	#
	#7. Populate the Amount filed ( Orginal Ticket Price) that the user has purchased.
	#
	#8. Set Debit Account = 2445 - Refunds Clearing
	#
	#9. Set Credit Account = 2445 - Refunds Clearing
	#
	#10. Set Entity = Contact
	#
	#11. Status = Posted.
	#
	#12. Posted Date = Today's Date.
	#
	#13. Please see below the sample screenshot to set up the Credit memo.
	#
	#14. Go to Contact.
	#
	#15. Select Rapid Order Entry (ROE).
	#
	#16. Search for the Ticket Type (Item) that the user is willing to transfer at a later time.
	#
	#17. Hit “Add to Order”
	#
	#18. Exit Sales Order (This step is to avoid filling out the form)
	#
	#19. Edit Sales Order and change Posting Entity to Invoice and Schedule Type to Simple Invoice
	#
	#20. Press “Ready for Payment”
	#
	#21. Now copy the Sales Order Line number.
	#
	#22. Go to Contact
	#
	#23. Go to the Credit memo.
	#
	#24. Go to the New Credit Memo line.
	#
	#25. Populate the Sales Order Line.
	#
	#26. Amount = Credit Memo amount
	#
	#27. Liability Account = 1200 A/R
	#
	#28. Change the Status to “Draft” and Save.
	#
	#29. Now Edit Credit Memo Line again and change Status = Posted
	#
	#30. Save the record.
	#
	#31. Now Go back to the Sales Order to check the transaction Lines.
	#
	#*Actual Results:*
	#
	#Item is not populated on the Transaction Lines (on the Transaction with Type=Credit Memo Applied)
	#
	#*Expected Results:*
	#
	#Item should be populated on transaction line (on Transaction with Type=Credit Memo Applied)
	@TEST_PD-29059 @REQ_PD-28074 @regression @21Winter @22Winter @anitha
	Scenario: Test Item is not populating on transaction lines created by applying a credit memo
		Given User creates Credit Memo with below information:
			| Account          | BusinessGroup | Contact      | Status | Entity  | Amount | PostedDate  | isPosted | DebitAccount | CreditAccount                     |
			| Brown Household  | Foundation    | David Brown  | Posted  | Contact | 150    | CurrentDate | true    | 1000 - Cash  | 1100 - Accounts Receivable        |
		And User will select "David Brown" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoItem6" item on rapid order entry
		And User clicks on Exit button on rapid order entry and change Posting Entity to "Invoice" and Schedule Type to "Simple Invoice"
		When User marks the created orders as ready for payment
		And User Creates Credit Memo line with below information
            |Amount|LiabilityAccount            |Status|Contact    |
            |100   |7100 - Foundation Write Offs|Draft |David Brown|
		And User change the credit memo line status to Posted
		Then User Navigates to transaction lines in sales order and verifies Item is populated with "AutoItem6"
