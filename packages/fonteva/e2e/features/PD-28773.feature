@REQ_PD-28773
Feature: 21Winter: Cannot edit sales order line for paid invoice
	#h2. Details
	#
	#Our sandbox has been up upgraded to 21Winter.0.9.  We've discovered that in this version we cannot make any edits to a sales order line that is related to a sales order with Posting Entity of 'Invoice' and Sales Order Status of 'Paid'.  If we attempt to edit a sales order line that meets these conditions, we get this error message...
	#
	#FIELD_CUSTOM_VALIDATION_EXCEPTION: Invoice is already Paid. In order to add a new line invoice status should be Draft, Unpaid, or Overdue.
	#
	#We edit these sales order lines for a variety of reasons, including to fill in the Shipping Tracking Number after the item is shipped.
	#
	#I wondered if we had some custom automation that was updating the parent sales order when we edited the sales order line, but I confirmed we have no workflow rules, process builders, or flows that would be doing this.  We have an installed package called Declarative Lookup Rollup Summary that should only update a parent SO if the field being updated on the SOL is rolled up.  I deactivated every Declarative Lookup Rollup Summary we have so nothing would roll up, but I still got this error.
	#
	#I have granted login access to my sandbox (Org ID 00D2i0000000k2Z).
	#
	#h2. Steps to Reproduce
	#
	#Configuration : Posting Entity : Invoice , Sales Order Status : Paid 
	#
	#Steps to Replicate
	#
	#1. Create an invoice type sales order.
	#
	#2. Process the payment. 
	#
	#3. Make an edit to sol in the non financial field.
	#
	#4. Click Save. 
	#
	#Screenshot : [https://prnt.sc/1u3jzbk|https://prnt.sc/1u3jzbk]
	#
	#GCO details : [https://gco9kjpim.lightning.force.com/lightning/page/home|https://gco9kjpim.lightning.force.com/lightning/page/home] 
	#
	#User Name : 21winter@fondash.io
	#
	#Password : Fonteva2021
	#
	#Sales Order : [https://gco9kjpim.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000AVKM4UAP/view|https://gco9kjpim.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000AVKM4UAP/view]
	#
	#h2. Expected Results
	#
	#Able to update the financial field similar to pre 20spring. 
	#
	#h2. Actual Results
	#
	#Cannot update shipping tracking numbers or other needed fields on sales order lines for paid invoices.
	#
	#h2. Business Justification
	#
	#The user edit these sales order lines to fill in the Shipping Tracking Number after the item is shipped.
	#
	#
	#
	#h2. *PM NOTE:*
	#
	#HOG is reporting the same issue. [https://fonteva.atlassian.net/browse/PD-27979|https://fonteva.atlassian.net/browse/PD-27979|smart-link]
	#
	#When this ticket is fixed we can also test and close HOG ticket
	#
	#PM team worked and decided to enhance the validation rule here is the detailed design.
	#
	#[https://docs.google.com/spreadsheets/d/14kyiKTSw0ag-QlsljGivtoHYCLAzi_hoYm37107E5II/edit#gid=0|https://docs.google.com/spreadsheets/d/14kyiKTSw0ag-QlsljGivtoHYCLAzi_hoYm37107E5II/edit#gid=0|smart-link]

	#Tests h2. Details
	#
	#Our sandbox has been up upgraded to 21Winter.0.9.  We've discovered that in this version we cannot make any edits to a sales order line that is related to a sales order with Posting Entity of 'Invoice' and Sales Order Status of 'Paid'.  If we attempt to edit a sales order line that meets these conditions, we get this error message...
	#
	#FIELD_CUSTOM_VALIDATION_EXCEPTION: Invoice is already Paid. In order to add a new line invoice status should be Draft, Unpaid, or Overdue.
	#
	#We edit these sales order lines for a variety of reasons, including to fill in the Shipping Tracking Number after the item is shipped.
	#
	#I wondered if we had some custom automation that was updating the parent sales order when we edited the sales order line, but I confirmed we have no workflow rules, process builders, or flows that would be doing this.  We have an installed package called Declarative Lookup Rollup Summary that should only update a parent SO if the field being updated on the SOL is rolled up.  I deactivated every Declarative Lookup Rollup Summary we have so nothing would roll up, but I still got this error.
	#
	#I have granted login access to my sandbox (Org ID 00D2i0000000k2Z).
	#
	#h2. Steps to Reproduce
	#
	#Configuration : Posting Entity : Invoice , Sales Order Status : Paid 
	#
	#Steps to Replicate
	#
	#1. Create an invoice type sales order.
	#
	#2. Process the payment. 
	#
	#3. Make an edit to sol in the non financial field.
	#
	#4. Click Save. 
	#
	#Screenshot : [https://prnt.sc/1u3jzbk|https://prnt.sc/1u3jzbk]
	#
	#GCO details : [https://gco9kjpim.lightning.force.com/lightning/page/home|https://gco9kjpim.lightning.force.com/lightning/page/home] 
	#
	#User Name : 21winter@fondash.io
	#
	#Password : Fonteva2021
	#
	#Sales Order : [https://gco9kjpim.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000AVKM4UAP/view|https://gco9kjpim.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000AVKM4UAP/view]
	#
	#h2. Expected Results
	#
	#Able to update the financial field similar to pre 20spring. 
	#
	#h2. Actual Results
	#
	#Cannot update shipping tracking numbers or other needed fields on sales order lines for paid invoices.
	#
	#h2. Business Justification
	#
	#The user edit these sales order lines to fill in the Shipping Tracking Number after the item is shipped.
	#
	#
	#
	#h2. *PM NOTE:*
	#
	#HOG is reporting the same issue. [https://fonteva.atlassian.net/browse/PD-27979|https://fonteva.atlassian.net/browse/PD-27979|smart-link]
	#
	#When this ticket is fixed we can also test and close HOG ticket
	#
	#PM team worked and decided to enhance the validation rule here is the detailed design.
	#
	#[https://docs.google.com/spreadsheets/d/14kyiKTSw0ag-QlsljGivtoHYCLAzi_hoYm37107E5II/edit#gid=0|https://docs.google.com/spreadsheets/d/14kyiKTSw0ag-QlsljGivtoHYCLAzi_hoYm37107E5II/edit#gid=0|smart-link]
 @TEST_PD-29149 @alex @regression @21Winter @REQ_PD-28773 @22Winter
 Scenario: Test 21Winter: Cannot edit sales order line for paid invoice
  Given User will select "Max Foxworth" contact
  And User opens the Rapid Order Entry page from contact
  And User should be able to add "Baseball Hat" item on rapid order entry
  And User navigate to "apply payment" page for "Baseball Hat" item from rapid order entry
  And User should be able to apply payment for "Baseball Hat" item using "Credit Card" payment on apply payment page
  Then User validates that non-financial fields on sales order are changeable
