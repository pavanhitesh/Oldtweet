@REQ_PD-28879
Feature: Currency field does not update when input is large numbers (billions +)
	#h2. Details
	#- An Authenticated User logs in to the community and updates the field through the Company Info tab
	#
	#Screen recording example:
	#https://www.screencast.com/t/ngO2vlbBV
	#
	#19R1 GCO Ord ID (latest patch): 	00D5Y000001M3PW
	#21Winter GCO Org ID (latest patch): 00D5Y000002Vp4H
	#h2. Steps to Reproduce
	#Preconfiguration needed to reproduce:
	#- A currency field is created on the Account object (18 digits, 0 decimals)
	#- The currency field is added to the "Company_Info" field set on the Account object
	#- Run Access Manager
	#
	#End User steps to reproduce:
	#- Login to the Lightning Community as Bob Kelley
	#- Select Company Info tab
	#- Select Change to modify the fields
	#- Input a revenue value equal or greater than 1 billion (eg 3 billion)
	#- Select Save
	#h2. Expected Results
	#The End User can update the currency field through the portal Company Info tab.
	#h2. Actual Results
	#- Error message generates and reads:
	#Custom Most Recently Reported Annual Rev: value not of required type: 222000000000
	#- dml exception error
	#- Happens when a value greater than 2,000,000,000 is entered (no commas)
	#- If the field is updated in the backend from the account record, the currency displays on the frontend
	#h2. Business Justification
	#Customers report this is not expected behavior for their high revenue clients.

	#Tests h2. Details
	#- An Authenticated User logs in to the community and updates the field through the Company Info tab
	#
	#Screen recording example:
	#https://www.screencast.com/t/ngO2vlbBV
	#
	#19R1 GCO Ord ID (latest patch): 	00D5Y000001M3PW
	#21Winter GCO Org ID (latest patch): 00D5Y000002Vp4H
	#h2. Steps to Reproduce
	#Preconfiguration needed to reproduce:
	#- A currency field is created on the Account object (18 digits, 0 decimals)
	#- The currency field is added to the "Company_Info" field set on the Account object
	#- Run Access Manager
	#
	#End User steps to reproduce:
	#- Login to the Lightning Community as Bob Kelley
	#- Select Company Info tab
	#- Select Change to modify the fields
	#- Input a revenue value equal or greater than 1 billion (eg 3 billion)
	#- Select Save
	#h2. Expected Results
	#The End User can update the currency field through the portal Company Info tab.
	#h2. Actual Results
	#- Error message generates and reads:
	#Custom Most Recently Reported Annual Rev: value not of required type: 222000000000
	#- dml exception error
	#- Happens when a value greater than 2,000,000,000 is entered (no commas)
	#- If the field is updated in the backend from the account record, the currency displays on the frontend
	#h2. Business Justification
	#Customers report this is not expected behavior for their high revenue clients.
	@TEST_PD-29533 @REQ_PD-28879 @regression @21Winter @22Winter @ngunda
	Scenario: Test Currency field does not update when input is large numbers (billions +)
		Given User navigate to community Portal page with "maxfoxworth@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User will select the "My Company Info" page in LT Portal
		When User tries to change data for the fieldset "Auto Account Field Set"
		Then User updates annual revenue of the account "Foxworth Household" to 442000000000 and verifies the value in portal and backend
