@REQ_PD-14495
Feature: Prevent Negative Quantity on Receipt Line Object
	#*CS Note:*
	#
	#Adding Validation to the quantity field. "Value needs to be greater than 1"
	#
	#*Reproduced by* Ewa Imtiaz in 2019.1.0.3
	#
	#*Reference Case#*[00016869|https://fonteva.my.salesforce.com/5003A00000vj4YYQAY]
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#* In your org go to the Contact object
	#* Select Contact
	#* Click Rapid Order Entry
	#* Add any item
	#* Click Process Payment
	#* Click Offline
	#** Or u can pay with any payment option
	#* Go Back to the Receipt
	#* Select: Create Refund
	#* For each Receipt Line enter a quantity of -2 to be Refunded
	#
	#
	#
	#*Actual Results:*
	#
	#The system allows users to enter negative values without alerting them this is already a Refund and a negative value is not required
	#
	#
	#
	#*Expected Results:*
	#
	#The system should not allow a Negative value to be entered in the quantity if the Receipt is Type: Refund
	#
	#
	#
	#*PM NOTE:*
	#
	#* See how you can create a refund and process a refund: [https://docs.fonteva.com/user/Creating-and-Processing-a-Refund.1474101477.html|https://docs.fonteva.com/user/Creating-and-Processing-a-Refund.1474101477.html|smart-link] 
	#* The way we will solve this problem is, we will add a validation rule on the Receipt Line object
	#** Do not allow users to enter negative numbers for quantity.
	#** Please note that we do not use standard salesforce validations. Please see the other examples and how we create validations.
	#** Validate Method under ReceiptLines.cls 
	#*** It is in OrderApi.
	#** Error Msg: “You cannot enter a negative quantity“
	#* The test class already exists.
	#** You can introduce a new method within this class.

	#Tests *CS Note:*
	#
	#Adding Validation to the quantity field. "Value needs to be greater than 1"
	#
	#*Reproduced by* Ewa Imtiaz in 2019.1.0.3
	#
	#*Reference Case#*[00016869|https://fonteva.my.salesforce.com/5003A00000vj4YYQAY]
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#* In your org go to the Contact object
	#* Select Contact
	#* Click Rapid Order Entry
	#* Add any item
	#* Click Process Payment
	#* Click Offline
	#** Or u can pay with any payment option
	#* Go Back to the Receipt
	#* Select: Create Refund
	#* For each Receipt Line enter a quantity of -2 to be Refunded
	#
	#
	#
	#*Actual Results:*
	#
	#The system allows users to enter negative values without alerting them this is already a Refund and a negative value is not required
	#
	#
	#
	#*Expected Results:*
	#
	#The system should not allow a Negative value to be entered in the quantity if the Receipt is Type: Refund
	#
	#
	#
	#*PM NOTE:*
	#
	#* See how you can create a refund and process a refund: [https://docs.fonteva.com/user/Creating-and-Processing-a-Refund.1474101477.html|https://docs.fonteva.com/user/Creating-and-Processing-a-Refund.1474101477.html|smart-link] 
	#* The way we will solve this problem is, we will add a validation rule on the Receipt Line object
	#** Do not allow users to enter negative numbers for quantity.
	#** Please note that we do not use standard salesforce validations. Please see the other examples and how we create validations.
	#** Validate Method under ReceiptLines.cls 
	#*** It is in OrderApi.
	#** Error Msg: “You cannot enter a negative quantity“
	#* The test class already exists.
	#** You can introduce a new method within this class.
 @REQ_PD-14495 @TEST_PD-27170 @regression @21Winter @22Winter @akash
 Scenario: Test Prevent Negative Quantity on Receipt Line Object
  Given User will select "Daniela Brown" contact
  And User opens the Rapid Order Entry page from contact
  And User should be able to add "AutoItem1" item on rapid order entry
  And User navigate to "apply payment" page for "AutoItem1" item from rapid order entry
  And User should be able to apply payment for "AutoItem1" item using "Credit Card" payment on apply payment page
  And User should create the refund for the item
  Then User verifies validation message when negative quantity is entered on the receipt

	

