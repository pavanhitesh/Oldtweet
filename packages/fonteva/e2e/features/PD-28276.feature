@REQ_PD-28276
Feature: Child Sales Order Line (Tax Line) missing missing GL Account Lookups
	#h2. Details
	#
	#When we buy an item that has tax, all the Sales order Tax lines are missing the GL account information.
	#
	#h2. Steps to Reproduce
	#
	#* 1Buy any item which has tax through the community portal as a logged-in user.
	#** Make sure the item you are purchasing is tax enabled
	#* Got to backend and find the Sales Order 
	#* Check the GL Account field on the Sales Order Line which is inserted as “Tax Line” (Child SOL)
	#
	#
	#
	#h2. ORG TO REPRO
	#
	#
	#enesson-19r2c@fonteva.com / Fonteva703
	#Sample Records:
	#
	#Sales Order Tax Line- [https://gdo7tbbxp.lightning.force.com/lightning/r/OrderApi__Sales_Order_Line__c/a1I3t00000DVnc0EAD/view|https://gdo7tbbxp.lightning.force.com/lightning/r/OrderApi__Sales_Order_Line__c/a1I3t00000DVnc0EAD/view]
	#
	#h2. Recording:
	#
	#[https://fonteva.zoom.us/rec/play/QsbKjkbRn3kSCXHO9DqSK1stPBQ4apALqEYeygRzg9d4ZnHBUVz4nZg7jIOa-Uc2OuCbVnf9QOA7wCHq.IC1J_4etI_LlirR4?startTime=1630684371000|https://fonteva.zoom.us/rec/play/QsbKjkbRn3kSCXHO9DqSK1stPBQ4apALqEYeygRzg9d4ZnHBUVz4nZg7jIOa-Uc2OuCbVnf9QOA7wCHq.IC1J_4etI_LlirR4?startTime=1630684371000]
	#
	#
	#h2. Expected Results
	#
	#The GL account field should be populated
	#
	#The system might insert more than one Tax SOL. GL Account must be populated for all of them
	#
	#h2. Actual Results
	#
	#The GL Account field is empty in the Sales Order Tax line
	#
	#h2. Business Justification
	#
	#The impact of this is that once the order is paid, the resulting transaction lines for tax are also missing GL information.
	#
	#
	#
	#h2. *T3 Notes:*
	#
	#This issue has been dealt with in the past in [https://fonteva.atlassian.net/browse/PD-24303|https://fonteva.atlassian.net/browse/PD-24303|smart-link] 
	#
	#We need to set GL account in {{createTaxes}} method in *FDServiceVersions.TaxService* 
	#
	#h2. PM NOTE: 
	#
	#Check the main SOL it has the GL Account and apply the same logic for child SOL

	#Tests h2. Details
	#
	#When we buy an item that has tax, all the Sales order Tax lines are missing the GL account information.
	#
	#h2. Steps to Reproduce
	#
	#* 1Buy any item which has tax through the community portal as a logged-in user.
	#** Make sure the item you are purchasing is tax enabled
	#* Got to backend and find the Sales Order 
	#* Check the GL Account field on the Sales Order Line which is inserted as “Tax Line” (Child SOL)
	#
	#
	#
	#h2. ORG TO REPRO
	#
	#
	#enesson-19r2c@fonteva.com / Fonteva703
	#Sample Records:
	#
	#Sales Order Tax Line- [https://gdo7tbbxp.lightning.force.com/lightning/r/OrderApi__Sales_Order_Line__c/a1I3t00000DVnc0EAD/view|https://gdo7tbbxp.lightning.force.com/lightning/r/OrderApi__Sales_Order_Line__c/a1I3t00000DVnc0EAD/view]
	#
	#h2. Recording:
	#
	#[https://fonteva.zoom.us/rec/play/QsbKjkbRn3kSCXHO9DqSK1stPBQ4apALqEYeygRzg9d4ZnHBUVz4nZg7jIOa-Uc2OuCbVnf9QOA7wCHq.IC1J_4etI_LlirR4?startTime=1630684371000|https://fonteva.zoom.us/rec/play/QsbKjkbRn3kSCXHO9DqSK1stPBQ4apALqEYeygRzg9d4ZnHBUVz4nZg7jIOa-Uc2OuCbVnf9QOA7wCHq.IC1J_4etI_LlirR4?startTime=1630684371000]
	#
	#
	#h2. Expected Results
	#
	#The GL account field should be populated
	#
	#The system might insert more than one Tax SOL. GL Account must be populated for all of them
	#
	#h2. Actual Results
	#
	#The GL Account field is empty in the Sales Order Tax line
	#
	#h2. Business Justification
	#
	#The impact of this is that once the order is paid, the resulting transaction lines for tax are also missing GL information.
	#
	#
	#
	#h2. *T3 Notes:*
	#
	#This issue has been dealt with in the past in [https://fonteva.atlassian.net/browse/PD-24303|https://fonteva.atlassian.net/browse/PD-24303|smart-link] 
	#
	#We need to set GL account in {{createTaxes}} method in *FDServiceVersions.TaxService* 
	#
	#h2. PM NOTE: 
	#
	#Check the main SOL it has the GL Account and apply the same logic for child SOL
	@REQ_PD-28276 @TEST_PD-28470 @regression @21Winter @22Winter @sophiya
	Scenario: Test Child Sales Order Line (Tax Line) missing missing GL Account Lookups
		Given User navigate to community Portal page with "danielabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		When User should be able to select "AutoItemwithTax" item with quantity "1" on store
		And User should click on the checkout button
		Then User verifies the GLAccount field in the tax sales order line

