@REQ_PD-26916
Feature: Creating Credit Note creates incorrect adjustment lines
	#*Case Reporter* Diego Alzugaray
	#
	#*Customer* Association for the Advancement of Medical Instrumentation
	#
	#*Reproduced by* Erich Ehinger in Spring 20
	#
	#*Reference Case#* [00023209|https://fonteva.my.salesforce.com/5004V000010l8YYQAY]
	#
	#*PM Note:*
	#
	#* Credit Note = Negative Adjustment.
	#* You can make adjustments to invoices only.
	#* On the sales order layout, you can see the Credit Note button on the related SOL list.
	#** you will make adjustments against specific lines.
	#* See the related section on the user guide to have an understanding of Credit Notes
	#** [https://docs.fonteva.com/user/Credit-Notes-(Negative-Adjustments).1473020036.html|https://docs.fonteva.com/user/Credit-Notes-(Negative-Adjustments).1473020036.html]
	#
	#*Description:*
	#
	#When creating a credit note, adjustment lines are created but *with the incorrect total.*
	#
	#If the original sales order line has a sale price of $10, and a quantity of 10, the total is $100.
	#
	#When you select the sales order line and click "Create Credit Note", the adjustment line is taking in the quantity of 10, but putting the total as the sale price. So the quantity is 10, the Sale price is $100, so the adjustment becomes -$1000, making the balance due -$900
	#
	#*Steps to Reproduce:*
	#
	#* Go to any contact on the backend
	#* Click Rapid Order Entry
	#* Search for any item (eg. FON-Book)
	#* Add a quantity of 50
	#* Add to order
	#* Change "Process Payment" dropdown to "Invoice" and select Go
	#* Click "Ready for Payment"
	#
	#*OR*
	#
	#* You can create a Sales Order Type invoice manually using SF UI.
	#* And then add an item (any item)
	#* And then Click Ready for Payment (this will post your invoice)
	#
	#*THEN*
	#
	#* Open Sales Order Lines related list
	#* Check the checkbox next to the sales order line that has book item
	#* Press Create Credit Note
	#** NoteL this is how u create negative adjustments
	#
	#*Actual Results:*
	#
	#A new sales order line is created that has the sale price of the overall total of the parent sales order line and a quantity of 50
	#
	#VIDEO: [https://fonteva.zoom.us/rec/share/2cpnH5zy-kVJGK-RwV3fBJF7Oobaeaa8gCIf_KAMmEgBOz_cGR2nQia2CrOIlmcB|https://fonteva.zoom.us/rec/share/2cpnH5zy-kVJGK-RwV3fBJF7Oobaeaa8gCIf_KAMmEgBOz_cGR2nQia2CrOIlmcB]
	#
	#*Expected Results/ Acceptance Criteria*
	#
	#* A new sales order line is created that has a sale price of the overall total of the parent sales order line and a quantity of 1
	#* New Sales Order line marked as Is Adjustment
	#
	#Estimate
	#
	#QA: 14h
	#
	#
	#
	#
	#
	#*Training Example:*
	#
	#Orginakl SOL = Sale price: 35, Quantitiy = 4 , OverA;; Toal = 140
	#
	#Then we selected this line and lcik CN button
	#
	#EXPECTATION IS: Quantity= 1, Sales Price = -140 (This should also set Total and Overall Total fields as -140)

	#Tests *Case Reporter* Diego Alzugaray
	#
	#*Customer* Association for the Advancement of Medical Instrumentation
	#
	#*Reproduced by* Erich Ehinger in Spring 20
	#
	#*Reference Case#* [00023209|https://fonteva.my.salesforce.com/5004V000010l8YYQAY]
	#
	#*PM Note:*
	#
	#* Credit Note = Negative Adjustment.
	#* You can make adjustments to invoices only.
	#* On the sales order layout, you can see the Credit Note button on the related SOL list.
	#** you will make adjustments against specific lines.
	#* See the related section on the user guide to have an understanding of Credit Notes
	#** [https://docs.fonteva.com/user/Credit-Notes-(Negative-Adjustments).1473020036.html|https://docs.fonteva.com/user/Credit-Notes-(Negative-Adjustments).1473020036.html]
	#
	#*Description:*
	#
	#When creating a credit note, adjustment lines are created but *with the incorrect total.*
	#
	#If the original sales order line has a sale price of $10, and a quantity of 10, the total is $100.
	#
	#When you select the sales order line and click "Create Credit Note", the adjustment line is taking in the quantity of 10, but putting the total as the sale price. So the quantity is 10, the Sale price is $100, so the adjustment becomes -$1000, making the balance due -$900
	#
	#*Steps to Reproduce:*
	#
	#* Go to any contact on the backend
	#* Click Rapid Order Entry
	#* Search for any item (eg. FON-Book)
	#* Add a quantity of 50
	#* Add to order
	#* Change "Process Payment" dropdown to "Invoice" and select Go
	#* Click "Ready for Payment"
	#
	#*OR*
	#
	#* You can create a Sales Order Type invoice manually using SF UI.
	#* And then add an item (any item)
	#* And then Click Ready for Payment (this will post your invoice)
	#
	#*THEN*
	#
	#* Open Sales Order Lines related list
	#* Check the checkbox next to the sales order line that has book item
	#* Press Create Credit Note
	#** NoteL this is how u create negative adjustments
	#
	#*Actual Results:*
	#
	#A new sales order line is created that has the sale price of the overall total of the parent sales order line and a quantity of 50
	#
	#VIDEO: [https://fonteva.zoom.us/rec/share/2cpnH5zy-kVJGK-RwV3fBJF7Oobaeaa8gCIf_KAMmEgBOz_cGR2nQia2CrOIlmcB|https://fonteva.zoom.us/rec/share/2cpnH5zy-kVJGK-RwV3fBJF7Oobaeaa8gCIf_KAMmEgBOz_cGR2nQia2CrOIlmcB]
	#
	#*Expected Results/ Acceptance Criteria*
	#
	#* A new sales order line is created that has a sale price of the overall total of the parent sales order line and a quantity of 1
	#* New Sales Order line marked as Is Adjustment
	#
	#Estimate
	#
	#QA: 14h
	#
	#
	#
	#
	#
	#*Training Example:*
	#
	#Orginakl SOL = Sale price: 35, Quantitiy = 4 , OverA;; Toal = 140
	#
	#Then we selected this line and lcik CN button
	#
	#EXPECTATION IS: Quantity= 1, Sales Price = -140 (This should also set Total and Overall Total fields as -140)
	@REQ_PD-26916 @TEST_PD-27783 @21winter @22Winter @regression @pavan
	Scenario: Test Creating Credit Note creates incorrect adjustment lines
		Given User will select "Coco Dulce" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoAdditionalItem" item with quantity 50 on rapid order entry
		And User selects "Invoice" as payment method and proceeds further
		When User select the sales order line item and create credit Notes
		Then User validates the newly sales Order line item with quantity as 1 and sales price as overall total of the parent sales order

