@REQ_PD-23277
Feature: LT Community / My Orders Page: Sales order with a Receipt that is refunded, does not reflect a balance of $0.00 in the order details in portal
	#*Reproduced by* Erich Ehinger in 2019.1.0.7
	#
	#*Reference Case#*[00018222|https://fonteva.my.salesforce.com/5003A00000xQjSnQAK]
	#
	#*Description:*
	#
	#When you refund a closed sales order with a receipt on the backend, it should be reflected as a balance of 0 within the community portal under the sales order/invoices tab. In reality, the full amount is reflected in the balance due, even after the refund has been posted.
	#
	#
	#
	#*PM NOTE:*
	#
	#Need to fix this one first [https://fonteva.atlassian.net/browse/PD-28065|https://fonteva.atlassian.net/browse/PD-28065|smart-link]
	#
	#Or decide with PM team if it needs to be fixed.
	#
	#[https://fonteva.atlassian.net/browse/PD-27976|https://fonteva.atlassian.net/browse/PD-27976|smart-link] is likely to fix this issue. So we can use the same automation [~accountid:60c9f25cb1f93b00691c3441]
	#
	#
	#
	#*Steps to Reproduce:*
	#
	## Go to a contact and create a sales order with an item and pay for the order
	## Navigate to the receipt that is generated after payment
	## Click on the Create Refund button (Note: do not use the Create Refund (Deprecated) button)
	## On the refund record that is created click on Process Refund button (Note: do not use the Process Refund (Deprecated) button)
	## Log into the community as the user and go to the Orders tab
	## You will see that the balance due for the order is 0.00 on the table
	## Click to open the drawer to view the order details and verify the balance due for the order in the drawer
	#
	#*Actual Results:*
	#
	#The balance due is the original amount when you click view order details.
	#
	#*Expected Results:*
	#
	#The balance due in the order details should reflect 0.00 as per the order line
	#
	#*Recordings:*
	#
	#[https://fusionspan.zoom.us/recording/share/YUOtDStaJ_pnDH-SAg7WSuruq4D0PiobsuMZc2Z1w3iwIumekTziMw?startTime=1573135777000|https://fusionspan.zoom.us/recording/share/YUOtDStaJ_pnDH-SAg7WSuruq4D0PiobsuMZc2Z1w3iwIumekTziMw?startTime=1573135777000]
	#
	#[https://fusionspan.zoom.us/recording/share/YUOtDStaJ_pnDH-SAg7WSuruq4D0PiobsuMZc2Z1w3iwIumekTziMw?startTime=1573135856000|https://fusionspan.zoom.us/recording/share/YUOtDStaJ_pnDH-SAg7WSuruq4D0PiobsuMZc2Z1w3iwIumekTziMw?startTime=1573135856000]

	#Tests
	#
	#*Reproduced by* Erich Ehinger in 2019.1.0.7
	#
	#*Reference Case#*[00018222|https://fonteva.my.salesforce.com/5003A00000xQjSnQAK]
	#
	#*Description:*
	#
	#When you refund a closed sales order with a receipt on the backend, it should be reflected as a balance of 0 within the community portal under the sales order/invoices tab. In reality, the full amount is reflected in the balance due, even after the refund has been posted.
	#
	#
	#
	#*PM NOTE:*
	#
	#Need to fix this one first [https://fonteva.atlassian.net/browse/PD-28065|https://fonteva.atlassian.net/browse/PD-28065|smart-link]
	#
	#Or decide with PM team if it needs to be fixed.
	#
	#[https://fonteva.atlassian.net/browse/PD-27976|https://fonteva.atlassian.net/browse/PD-27976|smart-link] is likely to fix this issue. So we can use the same automation [~accountid:60c9f25cb1f93b00691c3441]
	#
	#
	#
	#*Steps to Reproduce:*
	#
	## Go to a contact and create a sales order with an item and pay for the order
	## Navigate to the receipt that is generated after payment
	## Click on the Create Refund button (Note: do not use the Create Refund (Deprecated) button)
	## On the refund record that is created click on Process Refund button (Note: do not use the Process Refund (Deprecated) button)
	## Log into the community as the user and go to the Orders tab
	## You will see that the balance due for the order is 0.00 on the table
	## Click to open the drawer to view the order details and verify the balance due for the order in the drawer
	#
	#*Actual Results:*
	#
	#The balance due is the original amount when you click view order details.
	#
	#*Expected Results:*
	#
	#The balance due in the order details should reflect 0.00 as per the order line
	#
	#*Recordings:*
	#
	#[https://fusionspan.zoom.us/recording/share/YUOtDStaJ_pnDH-SAg7WSuruq4D0PiobsuMZc2Z1w3iwIumekTziMw?startTime=1573135777000|https://fusionspan.zoom.us/recording/share/YUOtDStaJ_pnDH-SAg7WSuruq4D0PiobsuMZc2Z1w3iwIumekTziMw?startTime=1573135777000]
	#
	#[https://fusionspan.zoom.us/recording/share/YUOtDStaJ_pnDH-SAg7WSuruq4D0PiobsuMZc2Z1w3iwIumekTziMw?startTime=1573135856000|https://fusionspan.zoom.us/recording/share/YUOtDStaJ_pnDH-SAg7WSuruq4D0PiobsuMZc2Z1w3iwIumekTziMw?startTime=1573135856000]
	@TEST_PD-28868 @REQ_PD-23277 @21Winter @22winter @svinjamuri @regression
	Scenario: Test LT Community / My Orders Page: Sales order with a Receipt that is refunded, does not reflect a balance of $0.00 in the order details in portal
		Given User will select "Etta Brown" contact
		When User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoItem1" item on rapid order entry
		And User selects "Process Payment" as payment method and proceeds further
		And User should be able to apply payment for "AutoItem1" item using "Credit Card" payment on apply payment page
		And User should be able to process refund successfully
		And  User navigate to community Portal page with "ettabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User navigate to All Orders Tab
		Then User verifies no balance due displayed for the sales order and in the document
