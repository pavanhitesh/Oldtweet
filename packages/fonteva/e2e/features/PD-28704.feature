@REQ_PD-28704
Feature: When move through screens quickly in ROE Shipping tax is not added to the SO
	#h2. Details
	#In 21Winter.0.9 & 21Winter.0.10 when we create an invoice or proforma invoice, after adding the item if we Exit to Salesorder too quick the Shipping tax is not being added to the SO.
	#h2. Steps to Reproduce
	#In my 21Winter.0.10 GCO
	#
	#21Winter@fondash.io / Fonteva2021
	#
	#
	#1. Go to Contact Wakko A. - https://gco9kjpim.my.salesforce.com/0035Y00003jZ8UK
	#
	#2. Do ROE, add item: TAXED B00k
	#
	#3. Select Invoice or Proforma then Go (In the next screen immediately Exit to Sales Order to see issue)
	#
	#4. Now on the SO check the SOL, notice there is no SOL for Shipping Tax
	#
	#5. Repeat the above but this time instead of exiting out immediately wait until the Shipping Tax populates then Exit the SO. When doing this the Shipping Tax is included in the SOL.
	#
	#
	#Recording of Issue: https://drive.google.com/file/d/15N-kv5LMym4GRCpxflCy1xZI4A26iP__/view?usp=sharing
	#h2. Expected Results
	#If they Exit to Salesorder the Shipping tax should be included no matter how quick they move through screens.
	#h2. Actual Results
	#The Shipping Tax is not included because staff users Exit to Salesorder immediately after clicking Go.
	#h2. Business Justification
	#Wrong amounts are billed to customers via invoice and proforma email because the Staff users do not know to wait until the Shipping populates before exiting to the SO.

	#Tests h2. Details
	#In 21Winter.0.9 & 21Winter.0.10 when we create an invoice or proforma invoice, after adding the item if we Exit to Salesorder too quick the Shipping tax is not being added to the SO.
	#h2. Steps to Reproduce
	#In my 21Winter.0.10 GCO
	#
	#21Winter@fondash.io / Fonteva2021
	#
	#
	#1. Go to Contact Wakko A. - https://gco9kjpim.my.salesforce.com/0035Y00003jZ8UK
	#
	#2. Do ROE, add item: TAXED B00k
	#
	#3. Select Invoice or Proforma then Go (In the next screen immediately Exit to Sales Order to see issue)
	#
	#4. Now on the SO check the SOL, notice there is no SOL for Shipping Tax
	#
	#5. Repeat the above but this time instead of exiting out immediately wait until the Shipping Tax populates then Exit the SO. When doing this the Shipping Tax is included in the SOL.
	#
	#
	#Recording of Issue: https://drive.google.com/file/d/15N-kv5LMym4GRCpxflCy1xZI4A26iP__/view?usp=sharing
	#h2. Expected Results
	#If they Exit to Salesorder the Shipping tax should be included no matter how quick they move through screens.
	#h2. Actual Results
	#The Shipping Tax is not included because staff users Exit to Salesorder immediately after clicking Go.
	#h2. Business Justification
	#Wrong amounts are billed to customers via invoice and proforma email because the Staff users do not know to wait until the Shipping populates before exiting to the SO.
	@TEST_PD-28942 @REQ_PD-28704 @21Winter @22Winter @Santosh @regression
	Scenario: When move through screens quickly in ROE Shipping tax is not added to the SO
		Given User will select "Wakko A." contact
		And User opens the Rapid Order Entry page from contact
		When User should be able to add "TAXEDD B00k" item on rapid order entry
		And User selects "Proforma Invoice" as payment method and proceeds further
		Then User exits to sales order and verifies the sales order line is created with tax and shipping item "FON-Default Shipping Rate"
