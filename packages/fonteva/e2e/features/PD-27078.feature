@REQ_PD-27078
Feature: When processing a refund in backend from a payment sometimes there is a blank box that appears and does not go away on its own, when this happens there is no green pop up message indicating the refund processed successfully.
	#*Case Reporter* Himali Shah
	#
	#*Customer* National Business Aviation Association
	#
	#*Reproduced by* Linda Diemer in 20Spring.1.6,20Spring.1.5
	#
	#*Reference Case#* [00029333|https://fonteva.my.salesforce.com/5004V000014ja65QAA]
	#
	#*Description:*
	#
	#When we have to create a refund from an ROE payment sometimes upon selecting process refund a blank screen pops up and does not go away without us clicking X. When this occurs there is no green pop-up message letting us know the refund was processed and no refund record shows created unless we refresh the screen. This is causing confusion for our users.
	#
	#
	#
	#*PM NOTE:*
	#
	#* See the related section of the user guide regarding how to create a refund and how to process them
	#** [https://docs.fonteva.com/user/Creating-and-Processing-a-Refund.1474101477.html|https://docs.fonteva.com/user/Creating-and-Processing-a-Refund.1474101477.html|smart-link]
	#* On the receipt record, there are buttons called create refunds and process refunds
	#* Creating a refund basically creates another receipt record but the type picklist is set as “Refund“, not “Payment“
	#* Make sure to test this Lightning, not Classic
	#* With the 21Winter release, we have moved these buttons to LTE from Orderapi, we have to make sure that we are testing with the latest and correct buttons.
	#** Buttons may not be on the layout automatically
	#* Video attached for the issue
	#
	#
	#
	#*Steps to Reproduce:*
	#
	## Go to a Contact ex Bob Kelley
	## Select ROE
	## Add any item and Checkout with Credit Card or Check
	### You dont have to use ROE, you can create orders manually and mark as ready then click apply payment
	## Then while on the Receipt record Select Create Refund
	### This will create a Refund (Receipt type refund)
	## Click View Refund
	## Select Process Refund
	### This checks a checkbox called process refund (may not be on the layout) and makes the actual call-out
	## This is where the white screen pops up and sometimes it does not go away, so when this happens there is no green message indicating the refund processed successfully.
	## If the blank screen did not go away, you need to then refresh the screen to see the refund did in fact process. Since users do not know they need to refresh the page there is confusion on if the refund was processed or not.
	#
	#
	#
	#*Actual Results:*
	#
	#Sometimes there is a blank white box that does not go away on its own after processing a refund and no pop-up message appears confirming the refund was successfully processed.
	#
	#*Expected Results:*
	#
	#For the blank white box to disappear right away and be able to see the green popup message confirming refund processed successfully.
	#
	#
	#
	#*CS Note:*
	#*Note this issue is intermittent & has been seen when processing refunds from Credit card payments and Checks In my attached video I was able to reproduce the issue on my 2nd attempt of processing a refund.

	#Tests *Case Reporter* Himali Shah
	#
	#*Customer* National Business Aviation Association
	#
	#*Reproduced by* Linda Diemer in 20Spring.1.6,20Spring.1.5
	#
	#*Reference Case#* [00029333|https://fonteva.my.salesforce.com/5004V000014ja65QAA]
	#
	#*Description:*
	#
	#When we have to create a refund from an ROE payment sometimes upon selecting process refund a blank screen pops up and does not go away without us clicking X. When this occurs there is no green pop-up message letting us know the refund was processed and no refund record shows created unless we refresh the screen. This is causing confusion for our users.
	#
	#
	#
	#*PM NOTE:*
	#
	#* See the related section of the user guide regarding how to create a refund and how to process them
	#** [https://docs.fonteva.com/user/Creating-and-Processing-a-Refund.1474101477.html|https://docs.fonteva.com/user/Creating-and-Processing-a-Refund.1474101477.html|smart-link]
	#* On the receipt record, there are buttons called create refunds and process refunds
	#* Creating a refund basically creates another receipt record but the type picklist is set as “Refund“, not “Payment“
	#* Make sure to test this Lightning, not Classic
	#* With the 21Winter release, we have moved these buttons to LTE from Orderapi, we have to make sure that we are testing with the latest and correct buttons.
	#** Buttons may not be on the layout automatically
	#* Video attached for the issue
	#
	#
	#
	#*Steps to Reproduce:*
	#
	## Go to a Contact ex Bob Kelley
	## Select ROE
	## Add any item and Checkout with Credit Card or Check
	### You dont have to use ROE, you can create orders manually and mark as ready then click apply payment
	## Then while on the Receipt record Select Create Refund
	### This will create a Refund (Receipt type refund)
	## Click View Refund
	## Select Process Refund
	### This checks a checkbox called process refund (may not be on the layout) and makes the actual call-out
	## This is where the white screen pops up and sometimes it does not go away, so when this happens there is no green message indicating the refund processed successfully.
	## If the blank screen did not go away, you need to then refresh the screen to see the refund did in fact process. Since users do not know they need to refresh the page there is confusion on if the refund was processed or not.
	#
	#
	#
	#*Actual Results:*
	#
	#Sometimes there is a blank white box that does not go away on its own after processing a refund and no pop-up message appears confirming the refund was successfully processed.
	#
	#*Expected Results:*
	#
	#For the blank white box to disappear right away and be able to see the green popup message confirming refund processed successfully.
	#
	#
	#
	#*CS Note:*
	#*Note this issue is intermittent & has been seen when processing refunds from Credit card payments and Checks In my attached video I was able to reproduce the issue on my 2nd attempt of processing a refund.
	@REQ_PD-27078 @TEST_PD-27737 @21winter @regression @pavan
	Scenario: Test When processing a refund in backend from a payment sometimes there is a blank box that appears and does not go away on its own, when this happens there is no green pop up message indicating the refund processed successfully.
		Given User will select "Coco Dulce" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoAdditionalItem" item on rapid order entry
		And User navigate to "apply payment" page for "AutoAdditionalItem" item from rapid order entry
		When User should be able to apply payment for "AutoAdditionalItem" item using "Credit Card" payment on apply payment page
		Then User should be able to process refund successfully
