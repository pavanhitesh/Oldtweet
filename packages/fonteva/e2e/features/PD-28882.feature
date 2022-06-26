@REQ_PD-28882
Feature: ROE Transaction shows SO SF id instead of SO number in orderId
	#h2. Details
	#
	#When staff members process a transaction, the 18c sales order ID is passed to the invoice number field in Payflow. All other transactions via the member portal pass the sales order number instead. This issue has been consistent since our upgrade on June 7 - 8, 2021. Prior to the upgrade, all transactions posted the sales order number to our payflow account.
	#
	#I'm attaching a payflow report from June 8 and if you select the sorted tab and view rows 32 and 33 column K displays the issue. All transactions above are from the community portal. As you might imagine, this does mess up our reporting and settlement for each day.
	#
	#I'm also attaching a video of the staff transaction process at the request of Abdalla when we briefly discussed the issue. Thank you so much for your assistance.
	#
	#Salesforce Org ID: 00D3i000000D36Z
	#
	#login to demo org
	#create/enable Payflow pro gateway
	#Go to any contact
	#go to ROE
	#Purchase an Item
	#Grab the transaction token and pull the transaction from gateway
	#
	#
	#
	#h2. Steps to Reproduce for Dev and QA
	#
	#* Go to a contact > ROE
	#* Purchase any Item
	#* Use CC to pay
	#* See ePayment - orderId is passed as SO Salesforce ID instead of SO number (note if we do FE flow we do pass SO number correctly)
	#
	#
	#
	#*Expected result*: for ROE transactions we should pass SO number in orderId
	#
	#*Actual result:* for ROE transactions we are currently passing SO salesforce id
	#
	#
	#
	#----
	#
	#h2. Business Justification
	#
	#All credit card entries that are processed by payflow and entered by staff are showing as incorrect in payflow.
	#Their payflow Pro account shows the 18 character SO ID instead of the Sales Order number.

	#Tests h2. Details
	#
	#When staff members process a transaction, the 18c sales order ID is passed to the invoice number field in Payflow. All other transactions via the member portal pass the sales order number instead. This issue has been consistent since our upgrade on June 7 - 8, 2021. Prior to the upgrade, all transactions posted the sales order number to our payflow account.
	#
	#I'm attaching a payflow report from June 8 and if you select the sorted tab and view rows 32 and 33 column K displays the issue. All transactions above are from the community portal. As you might imagine, this does mess up our reporting and settlement for each day.
	#
	#I'm also attaching a video of the staff transaction process at the request of Abdalla when we briefly discussed the issue. Thank you so much for your assistance.
	#
	#Salesforce Org ID: 00D3i000000D36Z
	#
	#login to demo org
	#create/enable Payflow pro gateway
	#Go to any contact
	#go to ROE
	#Purchase an Item
	#Grab the transaction token and pull the transaction from gateway
	#
	#
	#
	#h2. Steps to Reproduce for Dev and QA
	#
	#* Go to a contact > ROE
	#* Purchase any Item
	#* Use CC to pay
	#* See ePayment - orderId is passed as SO Salesforce ID instead of SO number (note if we do FE flow we do pass SO number correctly)
	#
	#
	#
	#*Expected result*: for ROE transactions we should pass SO number in orderId
	#
	#*Actual result:* for ROE transactions we are currently passing SO salesforce id
	#
	#
	#
	#----
	#
	#h2. Business Justification
	#
	#All credit card entries that are processed by payflow and entered by staff are showing as incorrect in payflow.
	#Their payflow Pro account shows the 18 character SO ID instead of the Sales Order number.
	@TEST_PD-28910 @REQ_PD-28882 @regression @21Winter @22Winter @ngunda
	Scenario: Test ROE Transaction shows SO SF id instead of SO number in orderId
		Given User will select "Mannik Gunda" contact
		When User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoItem6" item on rapid order entry
		And User navigate to "apply payment" page for "AutoItem6" item from rapid order entry
		And User should be able to apply payment for "AutoItem6" item using "Credit Card" payment on apply payment page
		Then User verifies the OrderId value in ePayment record
