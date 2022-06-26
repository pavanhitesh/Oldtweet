@REQ_PD-29869
Feature: ROE - Apply Payment Page - Balance Due and Current Due values are wrongly calculated
	#*Steps:*
	#
	## Go to ROE from any Contact (ex: Max Foxworth)
	## Add Subscription Item which is Taxable and also has a Packaged Item (Packaged Item should also be a Subscription Item which is Taxable)
	#Sample Item : [https://gdohlxt8l.lightning.force.com/lightning/r/OrderApi__Item__c/a185Y00001cAyNGQA0/view|https://gdohlxt8l.lightning.force.com/lightning/r/OrderApi__Item__c/a185Y00001cAyNGQA0/view]
	## Expand the Item Details in ROE and Select Packaged Item
	## Select Process Payment and Click on Go.
	## Observe the Balance Due and Current Due Fields
	#
	#*Expected*: Balance Due and Current Due values should be calculated properly
	#
	#*Actual*: Excess Amount is added and displayed in Balance Due and Current Due values.
	#For instance mentioned Items Price along with Tax is - 3520 USD, but the balance due shown in 3640 (which is 120 USD more) assume the packed item tax is being calculated twice here.
	#
	#ORG Details:
	#--url="[https://gdohlxt8l.my.salesforce.com|https://gdohlxt8l.my.salesforce.com/]"
	#--username="21summernightlyauto@fondash.io"
	#--password="Fonteva703"
	#
	#Please refer the attached Sample Screenshots document.
	#
	#[^BalnceDue and Current Due Calculation Issue.docx]

	#Tests *Steps:*
	#
	## Go to ROE from any Contact (ex: Max Foxworth)
	## Add Subscription Item which is Taxable and also has a Packaged Item (Packaged Item should also be a Subscription Item which is Taxable)
	#Sample Item : [https://gdohlxt8l.lightning.force.com/lightning/r/OrderApi__Item__c/a185Y00001cAyNGQA0/view|https://gdohlxt8l.lightning.force.com/lightning/r/OrderApi__Item__c/a185Y00001cAyNGQA0/view]
	## Expand the Item Details in ROE and Select Packaged Item
	## Select Process Payment and Click on Go.
	## Observe the Balance Due and Current Due Fields
	#
	#*Expected*: Balance Due and Current Due values should be calculated properly
	#
	#*Actual*: Excess Amount is added and displayed in Balance Due and Current Due values.
	#For instance mentioned Items Price along with Tax is - 3520 USD, but the balance due shown in 3640 (which is 120 USD more) assume the packed item tax is being calculated twice here.
	#
	#ORG Details:
	#--url="[https://gdohlxt8l.my.salesforce.com|https://gdohlxt8l.my.salesforce.com/]"
	#--username="21summernightlyauto@fondash.io"
	#--password="Fonteva703"
	#
	#Please refer the attached Sample Screenshots document.
	#
	#[^BalnceDue and Current Due Calculation Issue.docx]
	@TEST_PD-30037 @REQ_PD-29869 @regression @21Winter @22Winter @ngunda 
	Scenario: Test ROE - Apply Payment Page - Balance Due and Current Due values are wrongly calculated
		Given User will select "Max Foxworth" contact
		When User opens the Rapid Order Entry page from contact
		And User should be able to add "Auto_TaxSub_TaxPackagedSubItem" item with "AutoMonthlyProrationTermed" plan on rapid order entry
		And User is able to expand the Item details of "Auto_TaxSub_TaxPackagedSubItem" and select the Additional Package item
		And User navigate to "apply payment" page for "Auto_TaxSub_TaxPackagedSubItem" item from rapid order entry
		Then User verifies the Balance due, current due, payment and Remaining balance are populated properly
