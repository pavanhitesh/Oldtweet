@REQ_PD-29291
Feature: Posted Date blank on adjustment sales order line that is posted
	#h2. Details
	#When you create a credit note to adjust an invoice, the Posted-Date field is populated on the credit note, but the Posted-Date field is not populated on the corresponding adjustment sales order line even though the adjustment sales order line does get updated as Is Posted = true.
	#h2. Steps to Reproduce
	#Steps to replicate:
	#1. Select any contact record
	#2. Click on Rapid Order Entry
	#3. Select the item 'POCC - Other Income'. Check the box to Override and fill in the new Price of $100
	#4. Select the option 'Proforma Invoice' and click on Go. Come back to the sales order.
	#5. Click on Convert to Invoice
	#6. Click on Ready for Payment
	#7. Hover over the Sales Order Line related list, check the box for the sales order line, and click on Create Credit Note
	#8. Open the newly created sales order line and click Edit. Change the Sale Price to -50.00 and change the Total to -50.00. Save the change
	#9. Navigate back to the sales order and open the related credit note
	#10. On the credit note click Edit. Set Is Posted to true and save
	#11. You'll notice that the Posted Date on the credit note was automatically populated with today's date, which is expected
	#12. On the credit note click on the tab for Related. Click to open the related Sales Order Line.
	#13. Now look for is posted and you will see it is set to true but still the posted date is not populated on this sales order line.
	#
	#Video recording of the issue: https://fonteva.zoom.us/rec/share/yjPC_zhu3az3YOnFvV3P5RXr1HQT6zwmXpHNgAZGLVQPsELTfbTpXpv3QqH9tjQ9.OEg-EjXZVUJ88IYu?startTime=1637260651000
	#
	#GCO Details
	#Username: enesson-20r2b@fonteva.com
	#Password: Fonteva703
	#
	#Item link in GCO: https://eligco.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000isOK7QAM/view
	#Sales order Link in GCO: https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000AN7ihUAD/view
	#h2. Expected Results
	#The posted date field on the credit note's related sales order line should be populated.
	#h2. Actual Results
	#The posted date field on the credit note's related sales order line remains blank.
	#h2. Business Justification
	#Impacts reporting.

	#Tests h2. Details
	#When you create a credit note to adjust an invoice, the Posted-Date field is populated on the credit note, but the Posted-Date field is not populated on the corresponding adjustment sales order line even though the adjustment sales order line does get updated as Is Posted = true.
	#h2. Steps to Reproduce
	#Steps to replicate:
	#1. Select any contact record
	#2. Click on Rapid Order Entry
	#3. Select the item 'POCC - Other Income'. Check the box to Override and fill in the new Price of $100
	#4. Select the option 'Proforma Invoice' and click on Go. Come back to the sales order.
	#5. Click on Convert to Invoice
	#6. Click on Ready for Payment
	#7. Hover over the Sales Order Line related list, check the box for the sales order line, and click on Create Credit Note
	#8. Open the newly created sales order line and click Edit. Change the Sale Price to -50.00 and change the Total to -50.00. Save the change
	#9. Navigate back to the sales order and open the related credit note
	#10. On the credit note click Edit. Set Is Posted to true and save
	#11. You'll notice that the Posted Date on the credit note was automatically populated with today's date, which is expected
	#12. On the credit note click on the tab for Related. Click to open the related Sales Order Line.
	#13. Now look for is posted and you will see it is set to true but still the posted date is not populated on this sales order line.
	#
	#Video recording of the issue: https://fonteva.zoom.us/rec/share/yjPC_zhu3az3YOnFvV3P5RXr1HQT6zwmXpHNgAZGLVQPsELTfbTpXpv3QqH9tjQ9.OEg-EjXZVUJ88IYu?startTime=1637260651000
	#
	#GCO Details
	#Username: enesson-20r2b@fonteva.com
	#Password: Fonteva703
	#
	#Item link in GCO: https://eligco.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000isOK7QAM/view
	#Sales order Link in GCO: https://eligco.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5Y00000AN7ihUAD/view
	#h2. Expected Results
	#The posted date field on the credit note's related sales order line should be populated.
	#h2. Actual Results
	#The posted date field on the credit note's related sales order line remains blank.
	#h2. Business Justification
	#Impacts reporting.
	@TEST_PD-29346 @REQ_PD-29291 @21Winter @22Winter @regression @ngunda
	Scenario: Test Posted Date blank on adjustment sales order line that is posted
		Given User creates salesOrders with information provided below:
			| Contact      | Account            | BusinessGroup | Entity  | PostingEntity | ScheduleType   | ItemName  | Qty |
			| Max Foxworth | Foxworth Household | Foundation    | Contact | Invoice       | Simple Invoice | AutoItem6 | 1   |
		When User marks the created orders as ready for payment
		And User creates creditNotes for the sales order Line item created using "OrderService"
		And User updates the Adjustment line Item sales Price such that Balance due is "negative"
		And User Posts the Credit Note
		Then User verifes that the posted date is populated on creditnote related salesOrderLine 

