@REQ_PD-27921
Feature: BALANCE DUE 2 - Creating a credit memo from an adjusted invoice with a negative balance due is incorrectly updating Sales Order Lines causing bad data on both Sales Order and Sales Order Lines.
	#*Case Reporter* Diego Alzugaray
	#
	#*Customer* The Association For Manufacturing Technology
	#
	#*Reproduced by* Diego Alzugaray in 21Winter.0.4
	#
	#*Reference Case#* [00031223|https://fonteva.my.salesforce.com/5004V000017IvOYQA0]
	#
	#*Description:*
	#
	#Cancelling out an order (negative adjustment) to bring the balance due to a negative amount, and then creating a credit memo.
	#
	#*Steps to Reproduce:*
	#
	#1) Create a Sales Order with any Contact and Account
	#
	#2) Change Posting Entity to Invoice
	#
	#3) Change Schedule Type to Simple Invoice
	#
	#4) Save Sales Order
	#
	#5) Create new Sales Order Line with any Item that has Sale Price greater than 0 or mark Price Override = TRUE and make the sale price $100
	#
	#6) Save the Sales Order Line
	#
	#7) Press "Ready for Payment" on Sales Order
	#
	#8) Go to related Sales Order Lines and click Create Credit Note
	#
	#9) Open the new Adjustment Sales Order Line
	#
	#10) {color:#00b8d9}*NEGATIVE ADJUSTMENT HERE:* {color}Edit the Sale Price to be a greater negative amount than the original SOL (I.E. if the original SOL was $100, change Sales Price on adjustment SOL to $-150) and save
	#
	#11) Scroll down to Credit Note field on Adjustment SOL and open Credit Note
	#
	#12) Post the Credit Note
	#
	#13) Go back to original Sales Order
	#
	#14) {color:#00b8d9}*CREDIT MEMO CREATION HERE:* {color}Press Create Credit Memo
	#
	#*Actual Results:*
	#
	#Sales Order Line summary values are incorrectly adjusted, which is causing the Sales Order to have a negative balance due when it should be 0
	#
	#*Expected Results:*
	#
	#The balance due on the S/O should be 0
	#
	#The SOL's should be adjusted correctly so that the balance due on the S/O is correct
	#
	#*SALES ORDER*
	#
	#* Overall total= 100
	#* Amount Paid =0
	#* Amount Refunded=0
	#* Credit Notes/Adjustments= -150 + 50
	#* Credits Applied = 0
	#* Balance = 0
	#
	#*SOL 1 (MAIN ITEM)*
	#
	#* Overall total= 100
	#* Amount Paid =0
	#* Amount Refunded=0
	#* Credit Notes/Adjustments= -150 + 50
	#* Credits Applied = 0
	#* Balance = 0
	#
	#*SOL2 -CHILD SOL (NEGATIVE ADJUSTMENT - CREDIT NOTE)*
	#
	#* Overall total= -150
	#* Amount Paid =0
	#* Amount Refunded=0
	#* Credit Notes/Adjustments= 0
	#* Credits Applied = 0
	#* Balance = 0
	#
	#*SOL3 - CHILD SOL (CREDIT MEMO - POSITIVE ADJUSTMENT)*
	#
	#* Overall total = 50
	#* Amount Paid =0
	#* Amount Refunded=0
	#* Credit Notes/Adjustments= 0
	#* Credits Applied = 0
	#* Balance = 0
	#
	#
	#*PM NOTE:*
	#
	#DIFFERENCE FROM THIS TICKET [https://fonteva.atlassian.net/browse/PD-27172|https://fonteva.atlassian.net/browse/PD-27172|smart-link] , no payment is involved in this example; wait. for previous ticket to be closed and test this ticket after that.
	#
	#
	#
	#*Business Justification:*
	#
	#AMT goes live first week of August, and this use case is very common for AMT's show orders, which is a significant portion of their revenue. This will be a go-live blocker.

	#Tests *Case Reporter* Diego Alzugaray
	#
	#*Customer* The Association For Manufacturing Technology
	#
	#*Reproduced by* Diego Alzugaray in 21Winter.0.4
	#
	#*Reference Case#* [00031223|https://fonteva.my.salesforce.com/5004V000017IvOYQA0]
	#
	#*Description:*
	#
	#Cancelling out an order (negative adjustment) to bring the balance due to a negative amount, and then creating a credit memo.
	#
	#*Steps to Reproduce:*
	#
	#1) Create a Sales Order with any Contact and Account
	#
	#2) Change Posting Entity to Invoice
	#
	#3) Change Schedule Type to Simple Invoice
	#
	#4) Save Sales Order
	#
	#5) Create new Sales Order Line with any Item that has Sale Price greater than 0 or mark Price Override = TRUE and make the sale price $100
	#
	#6) Save the Sales Order Line
	#
	#7) Press "Ready for Payment" on Sales Order
	#
	#8) Go to related Sales Order Lines and click Create Credit Note
	#
	#9) Open the new Adjustment Sales Order Line
	#
	#10) {color:#00b8d9}*NEGATIVE ADJUSTMENT HERE:* {color}Edit the Sale Price to be a greater negative amount than the original SOL (I.E. if the original SOL was $100, change Sales Price on adjustment SOL to $-150) and save
	#
	#11) Scroll down to Credit Note field on Adjustment SOL and open Credit Note
	#
	#12) Post the Credit Note
	#
	#13) Go back to original Sales Order
	#
	#14) {color:#00b8d9}*CREDIT MEMO CREATION HERE:* {color}Press Create Credit Memo
	#
	#*Actual Results:*
	#
	#Sales Order Line summary values are incorrectly adjusted, which is causing the Sales Order to have a negative balance due when it should be 0
	#
	#*Expected Results:*
	#
	#The balance due on the S/O should be 0
	#
	#The SOL's should be adjusted correctly so that the balance due on the S/O is correct
	#
	#*SALES ORDER*
	#
	#* Overall total= 100
	#* Amount Paid =0
	#* Amount Refunded=0
	#* Credit Notes/Adjustments= -150 + 50
	#* Credits Applied = 0
	#* Balance = 0
	#
	#*SOL 1 (MAIN ITEM)*
	#
	#* Overall total= 100
	#* Amount Paid =0
	#* Amount Refunded=0
	#* Credit Notes/Adjustments= -150 + 50
	#* Credits Applied = 0
	#* Balance = 0
	#
	#*SOL2 -CHILD SOL (NEGATIVE ADJUSTMENT - CREDIT NOTE)*
	#
	#* Overall total= -150
	#* Amount Paid =0
	#* Amount Refunded=0
	#* Credit Notes/Adjustments= 0
	#* Credits Applied = 0
	#* Balance = 0
	#
	#*SOL3 - CHILD SOL (CREDIT MEMO - POSITIVE ADJUSTMENT)*
	#
	#* Overall total = 50
	#* Amount Paid =0
	#* Amount Refunded=0
	#* Credit Notes/Adjustments= 0
	#* Credits Applied = 0
	#* Balance = 0
	#
	#
	#*PM NOTE:*
	#
	#DIFFERENCE FROM THIS TICKET [https://fonteva.atlassian.net/browse/PD-27172|https://fonteva.atlassian.net/browse/PD-27172|smart-link] , no payment is involved in this example; wait. for previous ticket to be closed and test this ticket after that.
	#
	#
	#
	#*Business Justification:*
	#
	#AMT goes live first week of August, and this use case is very common for AMT's show orders, which is a significant portion of their revenue. This will be a go-live blocker.
	@TEST_PD-28534 @REQ_PD-27921 @21Winter @22Winter @regression @ngunda
	Scenario: Test BALANCE DUE 2 - Creating a credit memo from an adjusted invoice with a negative balance due is incorrectly updating Sales Order Lines causing bad data on both Sales Order and Sales Order Lines.
		Given User will select "Max Foxworth" contact
		And User opens the Rapid Order Entry page from contact
		When User should be able to add "AutoItem6" item on rapid order entry
		And User selects "Invoice" as payment method and proceeds further
		And User creates creditNotes for the sales order Line item created using "ROE"
		And User updates the Adjustment line Item sales Price such that Balance due is "positive"
		And User Posts the Credit Note
		Then User creates Credit Memo for the order
		And User verifies there is no Balance Due on SalesOrder
