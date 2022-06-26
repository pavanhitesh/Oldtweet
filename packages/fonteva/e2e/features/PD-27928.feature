@REQ_PD-27928
Feature: Posting Staus on Sales Order is not getting posted if the item is an installment type.
	#*Case Reporter* Jaspreet Siran
	#
	#*Customer* Royal College of General Practitioners
	#
	#*Reproduced by* Shilpa Gupta in 20Spring.0.20,20Spring.0.22
	#
	#*Reference Case#* [00031448|https://fonteva.my.salesforce.com/5004V000017KaF8QAK]
	#
	#*Description:*
	#
	#Org Id: 00D3h000007oxTa Access Granted for 1 Month
	#
	#*Steps to Reproduce:*
	#
	#* Item Config-
	#** Is Subscription=True
	#* Subscription Plan Config-
	#** Type-Calendar
	#** Enable Schedule=True
	#** Schedule Type=Automatic Payment
	#** Schedule Frequency=Monthly
	#
	#*Steps to Reproduce-*
	#
	#* BUYING THE SUBSCRIPTION THE FIRST TIME
	#** Go to Rapid Order Entry and add the item to the cart
	#** Select process payment and click on Go
	#** Process the payment using a credit card
	#* OR
	#** RENEW THIS SUBSCRIPTION
	#*** Navigate to a member in Salesforce
	#*** Find a subscription to renew - ensure it is monthly
	#*** Click on Renew
	#*** Pay by CC
	#
	#*Actual Results:*
	#
	#Posting Staus on Sales Order shows Pending status
	#
	#*Expected Results:*
	#
	#Posting Staus on salesOrder should be posted
	#
	#*Business Justification:*
	#
	#Sales Orders are not getting posted, it is difficult to report on and manage correct expectations from members
	#
	#
	#
	#*PM NOTE:*
	#
	#* Paying any order should mark the *Is Posted flag = true* on the Sales Order.
	#** We already know this is happening.
	#* That's what updates the *Posting Status* picklist (which we dont use anymore, but still confirm if the checkbox is getting posted if yes see the picklist value is posted not pending)
	#* The ask is when *Is posted = true*, make sure the *picklist value = Posted (fields are on the SO)*
	#* you can create the order manually nothing to do with ROE in this case.
	#* WITH THIS FIX WE ARE NOT BUILDING A NEW LOGIC AROUND THE PENDING STATUS FIELD, WE ARE FIXING THIS BUG BC THIS FIELD IS USED FOR CUSTOMERS EXISTING REPORTS. PM TEAM MADE TO CALL TO NOT DELETE THIS FIELD FOR THIS REASON, SO WE JUST NEED TO MAKE SURE WHEN IS POSTED FLAG IS CHECKED THIS FIELD GETS UPDATED AS POSTED
	#
	#
	#
	#*CS Note:*
	#Note: The issue is the same for renewal orders The issue is not happening when we process orders by direct debit. SO status is getting posted if Schedule frequency is Annual on the subscription plan Issue is same for backend and portal

	#Tests *Case Reporter* Jaspreet Siran
	#
	#*Customer* Royal College of General Practitioners
	#
	#*Reproduced by* Shilpa Gupta in 20Spring.0.20,20Spring.0.22
	#
	#*Reference Case#* [00031448|https://fonteva.my.salesforce.com/5004V000017KaF8QAK]
	#
	#*Description:*
	#
	#Org Id: 00D3h000007oxTa Access Granted for 1 Month
	#
	#*Steps to Reproduce:*
	#
	#* Item Config-
	#** Is Subscription=True
	#* Subscription Plan Config-
	#** Type-Calendar
	#** Enable Schedule=True
	#** Schedule Type=Automatic Payment
	#** Schedule Frequency=Monthly
	#
	#*Steps to Reproduce-*
	#
	#* BUYING THE SUBSCRIPTION THE FIRST TIME
	#** Go to Rapid Order Entry and add the item to the cart
	#** Select process payment and click on Go
	#** Process the payment using a credit card
	#* OR
	#** RENEW THIS SUBSCRIPTION
	#*** Navigate to a member in Salesforce
	#*** Find a subscription to renew - ensure it is monthly
	#*** Click on Renew
	#*** Pay by CC
	#
	#*Actual Results:*
	#
	#Posting Staus on Sales Order shows Pending status
	#
	#*Expected Results:*
	#
	#Posting Staus on salesOrder should be posted
	#
	#*Business Justification:*
	#
	#Sales Orders are not getting posted, it is difficult to report on and manage correct expectations from members
	#
	#
	#
	#*PM NOTE:*
	#
	#* Paying any order should mark the *Is Posted flag = true* on the Sales Order.
	#** We already know this is happening.
	#* That's what updates the *Posting Status* picklist (which we dont use anymore, but still confirm if the checkbox is getting posted if yes see the picklist value is posted not pending)
	#* The ask is when *Is posted = true*, make sure the *picklist value = Posted (fields are on the SO)*
	#* you can create the order manually nothing to do with ROE in this case.
	#* WITH THIS FIX WE ARE NOT BUILDING A NEW LOGIC AROUND THE PENDING STATUS FIELD, WE ARE FIXING THIS BUG BC THIS FIELD IS USED FOR CUSTOMERS EXISTING REPORTS. PM TEAM MADE TO CALL TO NOT DELETE THIS FIELD FOR THIS REASON, SO WE JUST NEED TO MAKE SURE WHEN IS POSTED FLAG IS CHECKED THIS FIELD GETS UPDATED AS POSTED
	#
	#
	#
	#*CS Note:*
	#Note: The issue is the same for renewal orders The issue is not happening when we process orders by direct debit. SO status is getting posted if Schedule frequency is Annual on the subscription plan Issue is same for backend and portal
	@TEST_PD-28341 @REQ_PD-27928 @22Winter @21winter @regression @pavan
	Scenario Outline: Test Posting Staus on Sales Order is not getting posted if the item is an installment type.
		Given User will select "Coco Dulce" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "<itemName>" item on rapid order entry
		And User navigate to "apply payment" page for "<itemName>" item from rapid order entry
		Then User should be able to apply payment for "<itemName>" item using "Credit Card" payment on apply payment page
		And User verifies the created sales Order Posting Status "Posted"

		Examples:
			| itemName             |
			| autoSubscriptionItem |
