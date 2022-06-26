@REQ_PD-27743
Feature: On Apply Payment Page: Credit Card component Billing Address is shown as Optional even though Validate Billing Address is enabled on Payment Gateway
	#*Case Reporter* Sandeep Vakkalagadda
	#
	#*Customer* College of American Pathologists
	#
	#*Reproduced by* Kapil Patel in 21Winter.0.0
	#
	#*Reference Case#* [00030073|https://fonteva.my.salesforce.com/5004V000015gAO0QAM]
	#
	#*Description:*
	#
	#Data without billing address is a major failure for the order to be processed.
	#
	#*Steps to Reproduce:*
	#1. Create a Payment Gateway with AVS Configuration -> Validate Billing Address
	#2. Associate this Payment Gateway with the Business Group and Store.
	#3. Navigate to Contact (without any KA) -> *BE* purchase any item (no tax no shippibg) -> navigate to Apply Payment Page.
	#4. Select Credit Card then click on Apply Payment -> Credit Card component will be displayed.
	#5. Check Billing Address section - it says "Address is optional" and I was able to successfully process the payment without entering any address
	#
	#Note: Same issue happening in *FE* *Portal* Checkout.
	#
	#
	#
	#*ORG TO REPRODUCE:*
	#
	#Able to reproduce in GCO Org: [https://gcoto95dv.lightning.force.com/lightning/r/OrderApi\\_\\_Sales\\_Order\\_\\_c/a1J5e000000gObSEAU/view|https://gcoto95dv.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5e000000gObSEAU/view]
	#pandaexp@fondash.io
	#Fonteva703
	#
	#*Actual Results:*
	#On Apply Payment Page-> Credit Card component Billing Address is shown as Optional even though Validate Billing Address is enabled on Payment Gateway
	#
	#*Expected Results:*
	#On Apply Payment Page-> Credit Card component Billing Address should not be Optional when Validate Billing Address is enabled on Payment Gateway
	#
	#*Business Justification:*
	#
	#The system should honor the BG config. It will create a lot of issues with incorrect data.
	#
	#*T3 Notes:*
	#
	#The missing billing address will cause AVS to check to fail from the gateway side.
	#
	#Only work and test backend apply payment page
	#
	#
	#
	#*PM NOTE:*
	#
	#On the BE Apply payment there is. STORE PICKER → Screen shots attached → then you find the related payment type
	#
	#On The FE Checkout, you have a COMMUNITY SITE → STORE → then you find the related payment type

	#Tests *Case Reporter* Sandeep Vakkalagadda
	#
	#*Customer* College of American Pathologists
	#
	#*Reproduced by* Kapil Patel in 21Winter.0.0
	#
	#*Reference Case#* [00030073|https://fonteva.my.salesforce.com/5004V000015gAO0QAM]
	#
	#*Description:*
	#
	#Data without billing address is a major failure for the order to be processed.
	#
	#*Steps to Reproduce:*
	#1. Create a Payment Gateway with AVS Configuration -> Validate Billing Address
	#2. Associate this Payment Gateway with the Business Group and Store.
	#3. Navigate to Contact (without any KA) -> *BE* purchase any item (no tax no shippibg) -> navigate to Apply Payment Page.
	#4. Select Credit Card then click on Apply Payment -> Credit Card component will be displayed.
	#5. Check Billing Address section - it says "Address is optional" and I was able to successfully process the payment without entering any address
	#
	#Note: Same issue happening in *FE* *Portal* Checkout.
	#
	#
	#
	#*ORG TO REPRODUCE:*
	#
	#Able to reproduce in GCO Org: [https://gcoto95dv.lightning.force.com/lightning/r/OrderApi\\_\\_Sales\\_Order\\_\\_c/a1J5e000000gObSEAU/view|https://gcoto95dv.lightning.force.com/lightning/r/OrderApi__Sales_Order__c/a1J5e000000gObSEAU/view]
	#pandaexp@fondash.io
	#Fonteva703
	#
	#*Actual Results:*
	#On Apply Payment Page-> Credit Card component Billing Address is shown as Optional even though Validate Billing Address is enabled on Payment Gateway
	#
	#*Expected Results:*
	#On Apply Payment Page-> Credit Card component Billing Address should not be Optional when Validate Billing Address is enabled on Payment Gateway
	#
	#*Business Justification:*
	#
	#The system should honor the BG config. It will create a lot of issues with incorrect data.
	#
	#*T3 Notes:*
	#
	#The missing billing address will cause AVS to check to fail from the gateway side.
	#
	#Only work and test backend apply payment page
	#
	#
	#
	#*PM NOTE:*
	#
	#On the BE Apply payment there is. STORE PICKER → Screen shots attached → then you find the related payment type
	#
	#On The FE Checkout, you have a COMMUNITY SITE → STORE → then you find the related payment type
	@REQ_PD-27743 @TEST_PD-28352 @22Winter @21Winter @svinjamuri @regression
	Scenario: Test On Apply Payment Page: Credit Card component Billing Address is shown as Optional even though Validate Billing Address is enabled on Payment Gateway
		Given User will select "Etta Brown" contact
		When User opens the Rapid Order Entry page from contact
		And User selects "US Association" from Advanced Settings
		And User should be able to add "AutoItem1" item on rapid order entry
		And User selects "Process Payment" as payment method and proceeds further
		And User selects "Credit Card" payment on apply payment page
		Then User verifies Address is optional text is not displayed for Billing Address and Process Payment button is not enabled
