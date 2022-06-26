@REQ_PD-23047
Feature: NYSBA Price Rule End Date Manual Entry Update
	#*Reproduced by* Erich Ehinger in 2019.1.0.19
	#
	#*Reference Case#*[00022158|https://fonteva.my.salesforce.com/5003A000010CpI4QAK]
	#
	#*Description:*
	#
	#Price Rule Criteria End Date cannot be adjusted manually in the text box
	#
	#*Steps to Reproduce:*
	#
	#Go to a price rule, Price Rule criteria, and enter a start and end date using the Calendar Picklist
	#
	#Save the price rule
	#
	#Go back to the criteria and try to manually edit the date by typing in another date
	#
	#*Actual Results:*
	#
	#The end date reverts back to the original picklist selected date
	#
	#*Expected Results:*
	#
	#The manually entered date should save in the price rule criteria
	#
	#
	#
	#*PM NOTE:*
	#
	#* It might be. in the framework, we use input field date type.
	#* Avi thinks the issue is on the page itself. Page is in Orderapi

	#Tests *Reproduced by* Erich Ehinger in 2019.1.0.19
	#
	#*Reference Case#*[00022158|https://fonteva.my.salesforce.com/5003A000010CpI4QAK]
	#
	#*Description:*
	#
	#Price Rule Criteria End Date cannot be adjusted manually in the text box
	#
	#*Steps to Reproduce:*
	#
	#Go to a price rule, Price Rule criteria, and enter a start and end date using the Calendar Picklist
	#
	#Save the price rule
	#
	#Go back to the criteria and try to manually edit the date by typing in another date
	#
	#*Actual Results:*
	#
	#The end date reverts back to the original picklist selected date
	#
	#*Expected Results:*
	#
	#The manually entered date should save in the price rule criteria
	#
	#
	#
	#*PM NOTE:*
	#
	#* It might be. in the framework, we use input field date type.
	#* Avi thinks the issue is on the page itself. Page is in Orderapi
	@TEST_PD-27754 @REQ_PD-23047 @21Winter @22Winter @ngunda
	Scenario: Test NYSBA Price Rule End Date Manual Entry Update
		Given User opens the Price rule for "AutoFreeSubItemWithTaxAndShipping" Item
		When User enters Start and End Dates for the Price rule using Calendar Picklist and saves
		Then User verifies manual updates on the start and End Dates fields are Saved and updated
