@REQ_PD-26906
Feature: Incorrect Paid Date and Posted Date are populated on Sales Order when offline payment is applied with a backdated date.
	#*Case Reporter* Sandeep Vakkalagadda
	#
	#*Customer* American Public Power Association
	#
	#*Reproduced by* Gavin Britto in 20Spring.1.5,20Spring.0.13-,2019.1.0.36-
	#
	#*Reference Case#* [00028985|https://fonteva.my.salesforce.com/5004V000014LVdAQAW]
	#
	#*Description:*
	#
	#Incorrect Dates are populated on the Sales Orders
	#
	#*Org to Reproduce*
	#
	#Replicated GCO: sandeepspring20org@fondash.io
	#
	#Fonteva703
	#
	#Sample Records:
	#
	#SO: a1J3t000007viMiEAI
	#
	#Receipt: a1E3t000007SCeXEAW
	#
	#
	#
	#*Steps to Reproduce:*
	#
	## Create Order via ROE
	## Navigate to the Check out page, select Offline Payment.
	## Select Paid Date and Posted Date in the past (Jan1 2021) and complete the purchase
	## Navigate to Receipt, Dates are populated as expected
	## Now Navigate to Sales Order, Paid Date, and Posted Date is populated with Today's Date which is not expected
	#
	#
	#
	#*Actual Results:*
	#
	#Paid Date and Posted Date are populated with Today's Date
	#
	#*Expected Results:*
	#
	#Paid Date and Posted Date are populated with the Date selected during Checkout
	#
	#
	#
	#*PM NOTE:*
	#
	#* Check the screenshots added. The Payment page has fields to capture paid date and posted date, these values should be saved on the Sales Order.
	#* {color:#ff5630}*The fix should only be applicable for sales order type receipts.* {color}
	#* {color:#ff5630}*If the user is paying an invoice (SO type Invoice) which means the sales order is already posted and we should not update the Posted-Date field on the SO.*{color}
	#
	#
	#
	#Estimate
	#
	#QA: 16h

	#Tests *Case Reporter* Sandeep Vakkalagadda
	#
	#*Customer* American Public Power Association
	#
	#*Reproduced by* Gavin Britto in 20Spring.1.5,20Spring.0.13-,2019.1.0.36-
	#
	#*Reference Case#* [00028985|https://fonteva.my.salesforce.com/5004V000014LVdAQAW]
	#
	#*Description:*
	#
	#Incorrect Dates are populated on the Sales Orders
	#
	#*Org to Reproduce*
	#
	#Replicated GCO: sandeepspring20org@fondash.io
	#
	#Fonteva703
	#
	#Sample Records:
	#
	#SO: a1J3t000007viMiEAI
	#
	#Receipt: a1E3t000007SCeXEAW
	#
	#
	#
	#*Steps to Reproduce:*
	#
	## Create Order via ROE
	## Navigate to the Check out page, select Offline Payment.
	## Select Paid Date and Posted Date in the past (Jan1 2021) and complete the purchase
	## Navigate to Receipt, Dates are populated as expected
	## Now Navigate to Sales Order, Paid Date, and Posted Date is populated with Today's Date which is not expected
	#
	#
	#
	#*Actual Results:*
	#
	#Paid Date and Posted Date are populated with Today's Date
	#
	#*Expected Results:*
	#
	#Paid Date and Posted Date are populated with the Date selected during Checkout
	#
	#
	#
	#*PM NOTE:*
	#
	#* Check the screenshots added. The Payment page has fields to capture paid date and posted date, these values should be saved on the Sales Order.
	#* {color:#ff5630}*The fix should only be applicable for sales order type receipts.* {color}
	#* {color:#ff5630}*If the user is paying an invoice (SO type Invoice) which means the sales order is already posted and we should not update the Posted-Date field on the SO.*{color}
	#
	#
	#
	#Estimate
	#
	#QA: 16h
 @REQ_PD-26906 @TEST_PD-27146 @regression @21Winter @22Winter
 Scenario: Test Incorrect Paid Date and Posted Date are populated on Sales Order when offline payment is applied with a backdated date.
		Given User will select "Coco Dulce" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoAdditionalItem" item on rapid order entry
		And User navigate to "apply payment" page for "AutoAdditionalItem" item from rapid order entry
		And User selects Payment Mode as "Offline - Check"
		And User select the Reference Number , Paid Date "12/12/2020" and Posted Date "12/13/2020" and complete the payment
		Then User validate the Paid Date and Post Date in Receipt
		And User validate the Paid Date and Post Date in SalesOrder




