@REQ_PD-27906
Feature: No Validation for "Deferred Revenue Adjustment" on 21Winter Sales Order Lines VS 19R1 LEGACY SO ISSUE
	#*Case Reporter* Paul Walstrom
	#
	#*Customer* American Academy of Family Physicians
	#
	#*Reproduced by* Aaron Gremillion in 21Winter.0.5
	#
	#*Reference Case#* [00031462|https://fonteva.my.salesforce.com/5004V000017KeQPQA0]
	#
	#*Description:*
	#
	#(21Winter) No Validation for "Deferred Revenue Adjustment" on 21Winter Sales Order Lines
	#
	#While making an adjustment: When the checkbox "*Deferred Revenue Adjustment*" is checked on a 21Winter Sales Order Line, and that Sales Order Line *does NOT contain a deferred Item*, an error message *SHOULD* display, and you should be prevented from saving the change. This is important because if you mistakenly save and Post an adjustment line with this box checked, *and the line does NOT contain a deferred item, a full set of empty Deferment Adjustment Transactions is created.*
	#
	#A video is attached of how it works differently with 19R1 and 21Winter records.
	#
	#
	#
	#*PM NOTE:*
	#The validation rule exists on the Invoice line object and it is written via apex. 
	#
	#This should go to FD service Version. We should be able to test there.
	#
	#SOL has *OrderApi__Deferred_Revenue_Adjustment__c* checkbox
	#
	#Item has *OrderApi__Defer_Revenue__c* checkbox
	#
	#See this label ==> [https://github.com/Fonteva/orderapi/blob/c80755c97e100fb3d74bd68331bed5dbd7518b5b/src/labels/CustomLabels.labels-meta.xml#L3346|https://github.com/Fonteva/orderapi/blob/c80755c97e100fb3d74bd68331bed5dbd7518b5b/src/labels/CustomLabels.labels-meta.xml#L3346] we can use this label since it is already there in 21winter versions.
	#
	#See this validation on the *Invoice line*:
	#
	#[https://github.com/Fonteva/orderapi/blob/c80755c97e100fb3d74bd68331bed5dbd7518b5b/src/classes/InvoiceLines.cls#L117|https://github.com/Fonteva/orderapi/blob/c80755c97e100fb3d74bd68331bed5dbd7518b5b/src/classes/InvoiceLines.cls#L117] 
	#
	#*We want the same validation rule on the SALES ORDER LINE OBJECT*
	#
	#No need to test old invoices, we just need to test new invoices (SO type invoices)
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#*PRE-REQ*
	#
	#Need to create a packaged item (the solution should not be hinged on this, it is just easier to set up this way for testing) on an item that has deferred revenue to be an additional item that is NOT deferred.
	#
	#1. Create a new 21W Sales Order, of type: Simple Invoice. Make sure there is at least one Sales Order Line containing a non-deferred item. Post the Invoice.
	#
	#2. Select the Sales Order Line in the Related List, and choose to Create Credit Note. This will create a new Credit Note, and will also create a new Sales Order Line with "Is Adjustment"
	#
	#3. Edit the new 'adjustment' Sales Order Line. Set the checkbox "Deferred Revenue Adjustment", and click Save
	#
	#4. No warning/error message displays, and you are allowed to save the record with the irrelevant "Deferred Revenue Adjustment" box checked.
	#
	#*Actual Results:*
	#
	#There's nothing stopping the user from progressing and it should halt them.
	#
	#*Expected Results:*
	#
	#The expected behavior here is that there's a validation message that prevents a user from using the deferred revenue adjustment check box, where the item is not set up for def rev.
	#
	#*Business Justification:*
	#
	#may cause revenue issues
	#
	#*CS Note:*
	#Note, the video is from the customer, but the issue is easily repro'd in a GCO Gremw21@fondash.io 1Emm@3089 Additionally, the error message still exists, but doesn't fire. – Found in custom lables.

	#Tests *Case Reporter* Paul Walstrom
	#
	#*Customer* American Academy of Family Physicians
	#
	#*Reproduced by* Aaron Gremillion in 21Winter.0.5
	#
	#*Reference Case#* [00031462|https://fonteva.my.salesforce.com/5004V000017KeQPQA0]
	#
	#*Description:*
	#
	#(21Winter) No Validation for "Deferred Revenue Adjustment" on 21Winter Sales Order Lines
	#
	#While making an adjustment: When the checkbox "*Deferred Revenue Adjustment*" is checked on a 21Winter Sales Order Line, and that Sales Order Line *does NOT contain a deferred Item*, an error message *SHOULD* display, and you should be prevented from saving the change. This is important because if you mistakenly save and Post an adjustment line with this box checked, *and the line does NOT contain a deferred item, a full set of empty Deferment Adjustment Transactions is created.*
	#
	#A video is attached of how it works differently with 19R1 and 21Winter records.
	#
	#
	#
	#*PM NOTE:*
	#The validation rule exists on the Invoice line object and it is written via apex. 
	#
	#This should go to FD service Version. We should be able to test there.
	#
	#SOL has *OrderApi__Deferred_Revenue_Adjustment__c* checkbox
	#
	#Item has *OrderApi__Defer_Revenue__c* checkbox
	#
	#See this label ==> [https://github.com/Fonteva/orderapi/blob/c80755c97e100fb3d74bd68331bed5dbd7518b5b/src/labels/CustomLabels.labels-meta.xml#L3346|https://github.com/Fonteva/orderapi/blob/c80755c97e100fb3d74bd68331bed5dbd7518b5b/src/labels/CustomLabels.labels-meta.xml#L3346] we can use this label since it is already there in 21winter versions.
	#
	#See this validation on the *Invoice line*:
	#
	#[https://github.com/Fonteva/orderapi/blob/c80755c97e100fb3d74bd68331bed5dbd7518b5b/src/classes/InvoiceLines.cls#L117|https://github.com/Fonteva/orderapi/blob/c80755c97e100fb3d74bd68331bed5dbd7518b5b/src/classes/InvoiceLines.cls#L117] 
	#
	#*We want the same validation rule on the SALES ORDER LINE OBJECT*
	#
	#No need to test old invoices, we just need to test new invoices (SO type invoices)
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#*PRE-REQ*
	#
	#Need to create a packaged item (the solution should not be hinged on this, it is just easier to set up this way for testing) on an item that has deferred revenue to be an additional item that is NOT deferred.
	#
	#1. Create a new 21W Sales Order, of type: Simple Invoice. Make sure there is at least one Sales Order Line containing a non-deferred item. Post the Invoice.
	#
	#2. Select the Sales Order Line in the Related List, and choose to Create Credit Note. This will create a new Credit Note, and will also create a new Sales Order Line with "Is Adjustment"
	#
	#3. Edit the new 'adjustment' Sales Order Line. Set the checkbox "Deferred Revenue Adjustment", and click Save
	#
	#4. No warning/error message displays, and you are allowed to save the record with the irrelevant "Deferred Revenue Adjustment" box checked.
	#
	#*Actual Results:*
	#
	#There's nothing stopping the user from progressing and it should halt them.
	#
	#*Expected Results:*
	#
	#The expected behavior here is that there's a validation message that prevents a user from using the deferred revenue adjustment check box, where the item is not set up for def rev.
	#
	#*Business Justification:*
	#
	#may cause revenue issues
	#
	#*CS Note:*
	#Note, the video is from the customer, but the issue is easily repro'd in a GCO Gremw21@fondash.io 1Emm@3089 Additionally, the error message still exists, but doesn't fire. – Found in custom lables.
	@REQ_PD-27906 @TEST_PD-28237 @regression @21Winter @22Winter @sophiya
	Scenario: Test No Validation for "Deferred Revenue Adjustment" on 21Winter Sales Order Lines VS 19R1 LEGACY SO ISSUE
		Given User will select "David Brown" contact
		When User opens the Rapid Order Entry page from contact
		And User should be able to add "RTD_SI6_1" item on rapid order entry
		And User selects "Invoice" as payment method and proceeds further
		And User creates creditNotes for the packaged sales order Line item
		Then User updates the Adjustment line Item Deffered revenue and verify
