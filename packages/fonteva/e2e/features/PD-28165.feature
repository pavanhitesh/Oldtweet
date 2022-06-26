@REQ_PD-28165
Feature: Test Price Rule is not updating on SOL if changed after being created
	#h2. Details
	#Login to GCO
	#enesson-20r2b@fonteva.com
	#Fonteva703
	#
	#1. Review the Item configuration: https://gcon4qrsd.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000gTh0FQAS/view
	#
	#2. Under Price Rules for the above item select the Annual Engment Price Rule and review the criteria: https://gcon4qrsd.lightning.force.com/lightning/r/OrderApi__Price_Rule__c/a1C5Y00000FWtRFUA1/view
	#
	#3. Go to Contact notice the field Annual Engagement Score is under 500: https://gcon4qrsd.lightning.force.com/lightning/r/Contact/0035Y00003z2u9wQAA/view
	#
	#4. Now proceed and do ROE for the Item:FON-Associate Membership using the above contact ,for the Plan select FON-1 Year Anniversary and pay.
	#
	#5. From the Receipt generated go to the SO then to the SOL.
	#
	#6. Notice the Price Rule shows Default which is correct.
	#
	#7. In another tab go to the same above contact and change the number in the Annual Engagement Score to reflect any number above 500. ( to meet the price rule criteria for the price rule Annual Engment Price )
	#
	#8. Go back to the SOL and do a dummy Edit and Save. Notice the Price Rule does not update to reflect as Annual Engment Price instead it stays as Default.
	#h2. Steps to Reproduce
	#1. Create a Price Rule using the Price rule variable on Contact. In my example, Create a price rule for $500-> Add PR criteria as Contact.Annual engagement score>500.
	#
	#2.Navigate to Contact, Update Annual Engagement Score as 2000 then ROE->Create a Sales Order->Exit
	#
	#3. Now navigate to Sales Order Line in a separate tab.
	#
	#4. Now Update the Annual Engagement Score to 300 then Dummy update Sales Order Line and Save. Price Rule gets update to Default which is expected.
	#
	#5. Now again update the Engagement Score to 2000 then Dummy update Sales Order Line and Save. Price Rule do not get refreshed
	#
	#GCO Details:
	#enesson-20r2b@fonteva.com
	#Fonteva703
	#
	#Sample Sales Order Line: https://gcon4qrsd.my.salesforce.com/a1I5Y00000KPoQP
	#h2. Expected Results
	#Price Rule should get refreshed upon updating the Sales Order Line
	#h2. Actual Results
	#Price Rule not getting refreshed upon updating the Sales Order Line
	#h2. Business Justification
	#will have incorrect pricing on renewals

	#Tests h2. Details
	#Login to GCO
	#enesson-20r2b@fonteva.com
	#Fonteva703
	#
	#1. Review the Item configuration: https://gcon4qrsd.lightning.force.com/lightning/r/OrderApi__Item__c/a155Y00000gTh0FQAS/view
	#
	#2. Under Price Rules for the above item select the Annual Engment Price Rule and review the criteria: https://gcon4qrsd.lightning.force.com/lightning/r/OrderApi__Price_Rule__c/a1C5Y00000FWtRFUA1/view
	#
	#3. Go to Contact notice the field Annual Engagement Score is under 500: https://gcon4qrsd.lightning.force.com/lightning/r/Contact/0035Y00003z2u9wQAA/view
	#
	#4. Now proceed and do ROE for the Item:FON-Associate Membership using the above contact ,for the Plan select FON-1 Year Anniversary and pay.
	#
	#5. From the Receipt generated go to the SO then to the SOL.
	#
	#6. Notice the Price Rule shows Default which is correct.
	#
	#7. In another tab go to the same above contact and change the number in the Annual Engagement Score to reflect any number above 500. ( to meet the price rule criteria for the price rule Annual Engment Price )
	#
	#8. Go back to the SOL and do a dummy Edit and Save. Notice the Price Rule does not update to reflect as Annual Engment Price instead it stays as Default.
	#h2. Steps to Reproduce
	#1. Create a Price Rule using the Price rule variable on Contact. In my example, Create a price rule for $500-> Add PR criteria as Contact.Annual engagement score>500.
	#
	#2.Navigate to Contact, Update Annual Engagement Score as 2000 then ROE->Create a Sales Order->Exit
	#
	#3. Now navigate to Sales Order Line in a separate tab.
	#
	#4. Now Update the Annual Engagement Score to 300 then Dummy update Sales Order Line and Save. Price Rule gets update to Default which is expected.
	#
	#5. Now again update the Engagement Score to 2000 then Dummy update Sales Order Line and Save. Price Rule do not get refreshed
	#
	#GCO Details:
	#enesson-20r2b@fonteva.com
	#Fonteva703
	#
	#Sample Sales Order Line: https://gcon4qrsd.my.salesforce.com/a1I5Y00000KPoQP
	#h2. Expected Results
	#Price Rule should get refreshed upon updating the Sales Order Line
	#h2. Actual Results
	#Price Rule not getting refreshed upon updating the Sales Order Line
	#h2. Business Justification
	#will have incorrect pricing on renewals
	@TEST_PD-29252 @REQ_PD-28165 @regression @21Winter @22Winter @anitha
	Scenario: Test Price Rule is not updating on SOL if changed after being created
		Given User will select "David Brown" contact
		And User updates the Annual Engagement Score to 1000 for "David Brown" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "Auto_Test_ItemFON" item on rapid order entry
		And User clicks on Exit button on rapid order entry
		And User verify price rule is populated or updated to "Price Rule_Test_ItemFON" in sales order line
		When User updates the Annual Engagement Score to 300 for "David Brown" contact
		And User performs dummy edit on sales order line and click on save
		Then User verify price rule is populated or updated to "DEFAULT" in sales order line
		And User updates the Annual Engagement Score to 1000 for "David Brown" contact
		And User performs dummy edit on sales order line and click on save
		Then User verify price rule is populated or updated to "Price Rule_Test_ItemFON" in sales order line
