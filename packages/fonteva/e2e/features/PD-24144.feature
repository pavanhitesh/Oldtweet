@REQ_PD-24144
Feature: When processing as Proforma in ROE if the email is not sent the Is Proforma checkbox on the Sales Order is not checked
	#*Case Reporter* Julie Smith
	#
	#*Customer* National Business Aviation Association
	#
	#*Reproduced by* Eli Nesson in 20Spring.0.0,20Spring.0.4
	#
	#*Reference Case#* [00023259|https://fonteva.my.salesforce.com/5004V000010lKMsQAM]
	#
	#*Description:*
	#
	#When processing as Proforma in ROE, if the email is not sent, the "Is Proforma" checkbox on the Sales Order is not checked
	#
	#VIDEO: Screen recording: [https://www.screencast.com/t/9F1LfnxR32h|https://www.screencast.com/t/9F1LfnxR32h]
	#
	#*Steps to Reproduce:*
	#
	## Open ROE from a Contact record
	## Add an Item
	## Select Proforma Invoice and click Go
	## Exit to Sales Order without sending the email
	## Check the newly created Sales order
	#
	#*Actual Results:*
	#
	#Sales Order has "Is Proforma" set to FALSE
	#
	#*Expected Results:*
	#
	#* Sales Order has "Is Proforma" set to TRUE
	#* On the ROE page, when user click "Proforma Invoice" option, on the button click we should check the "Is Proforma Checkbox" on the related Sales Order.
	#
	#Estimate
	#
	#QA: 14h

	#Tests *Case Reporter* Julie Smith
	#
	#*Customer* National Business Aviation Association
	#
	#*Reproduced by* Eli Nesson in 20Spring.0.0,20Spring.0.4
	#
	#*Reference Case#* [00023259|https://fonteva.my.salesforce.com/5004V000010lKMsQAM]
	#
	#*Description:*
	#
	#When processing as Proforma in ROE, if the email is not sent, the "Is Proforma" checkbox on the Sales Order is not checked
	#
	#VIDEO: Screen recording: [https://www.screencast.com/t/9F1LfnxR32h|https://www.screencast.com/t/9F1LfnxR32h]
	#
	#*Steps to Reproduce:*
	#
	## Open ROE from a Contact record
	## Add an Item
	## Select Proforma Invoice and click Go
	## Exit to Sales Order without sending the email
	## Check the newly created Sales order
	#
	#*Actual Results:*
	#
	#Sales Order has "Is Proforma" set to FALSE
	#
	#*Expected Results:*
	#
	#* Sales Order has "Is Proforma" set to TRUE
	#* On the ROE page, when user click "Proforma Invoice" option, on the button click we should check the "Is Proforma Checkbox" on the related Sales Order.
	#
	#Estimate
	#
	#QA: 14h
	@TEST_PD-27062 @REQ_PD-24144 @regression @21Winter @22Winter @ngunda
	Scenario: When processing as Proforma in ROE if the email is not sent the Is Proforma checkbox on the Sales Order is not checked
		Given User will select "Mannik Gunda" contact
		And User opens the Rapid Order Entry page from contact
		When User should be able to add "AutoLTItem" item on rapid order entry
		And User selects "Proforma Invoice" as payment method and proceeds further
		Then User exits to sales order and verifies the sales order is marked as proforma order
