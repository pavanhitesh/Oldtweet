@REQ_PD-23355
Feature: Receipt Line field OrderApi__Tax_Percent__c not showing correct information
	#*Case Reporter* Luca Francolini
	#
	#*Customer* European Society of Medical Oncology
	#
	#*Reproduced by* Kapil Patel in2019 R1 1.0.21
	#
	#*Reference Case#* [00022683|https://fonteva.my.salesforce.com/5004V000010ioteQAA]
	#
	#*Description:*
	#
	#Receipt Line field OrderApi__Tax_Percent__c not working after upgrade to 2019 R1 1.0.21
	#
	#*Steps to Reproduce:*
	#
	#Demo org: 00D3i000000GJpz
	#
	#Configure an item with Tax
	#
	#Go to contact
	#
	#login to the community as a user
	#
	#buy an item with tax
	#
	#check the receipt line field
	#
	#{color:#3e3e3c}OrderApi__Tax_Percent__c{color}
	#
	#*Actual Results:*
	#
	#it is not showing 0
	#
	#[https://fonteva--c.na138.content.force.com/servlet/rtaImage?eid=a4p4V000000Txs1&feoid=00N3A00000ClSV0&refid=0EM4V000001fxeZ|https://fonteva--c.na138.content.force.com/servlet/rtaImage?eid=a4p4V000000Txs1&feoid=00N3A00000ClSV0&refid=0EM4V000001fxeZ]
	#
	#*Expected Results:*
	#
	#It should reflect the correct info
	#
	#*PM NOTE:*
	#
	#SOL is also missing the value on the same field.
	#
	#SOL should coy from Item (OrderApi__Tax_Percent__c) then the Receipt line should simply copy the value from SOL
	#
	#SOL has a lookup to Item, RL has a lookup to SOL so it is a direct relationship.

	#Tests *Case Reporter* Luca Francolini
	#
	#*Customer* European Society of Medical Oncology
	#
	#*Reproduced by* Kapil Patel in2019 R1 1.0.21
	#
	#*Reference Case#* [00022683|https://fonteva.my.salesforce.com/5004V000010ioteQAA]
	#
	#*Description:*
	#
	#Receipt Line field OrderApi__Tax_Percent__c not working after upgrade to 2019 R1 1.0.21
	#
	#*Steps to Reproduce:*
	#
	#Demo org: 00D3i000000GJpz
	#
	#Configure an item with Tax
	#
	#Go to contact
	#
	#login to the community as a user
	#
	#buy an item with tax
	#
	#check the receipt line field
	#
	#{color:#3e3e3c}OrderApi__Tax_Percent__c{color}
	#
	#*Actual Results:*
	#
	#it is not showing 0
	#
	#[https://fonteva--c.na138.content.force.com/servlet/rtaImage?eid=a4p4V000000Txs1&feoid=00N3A00000ClSV0&refid=0EM4V000001fxeZ|https://fonteva--c.na138.content.force.com/servlet/rtaImage?eid=a4p4V000000Txs1&feoid=00N3A00000ClSV0&refid=0EM4V000001fxeZ]
	#
	#*Expected Results:*
	#
	#It should reflect the correct info
	#
	#*PM NOTE:*
	#
	#SOL is also missing the value on the same field.
	#
	#SOL should coy from Item (OrderApi__Tax_Percent__c) then the Receipt line should simply copy the value from SOL
	#
	#SOL has a lookup to Item, RL has a lookup to SOL so it is a direct relationship.
	@TEST_PD-28236 @REQ_PD-23355 @regression @21Winter @22Winter @ngunda
	Scenario: Test Receipt Line field OrderApi__Tax_Percent__c not showing correct information
		Given User will select "Max Foxworth" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoItemwithTax" item on rapid order entry
		And User navigate to "apply payment" page for "AutoItemwithTax" item from rapid order entry
		And User should be able to apply payment for "AutoItemwithTax" item using "Credit Card" payment on apply payment page
		Then User verifies tax percentage on Sales order Lines and Receipt Lines for Item "AutoItemwithTax"
