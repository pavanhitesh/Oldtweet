@REQ_PD-29942
Feature: Respond to a form with skip logic for picklist field, in ROE
	#C100060
	#
	#PRE-CONDITIONS:
	#Create a form with a picklist field type (say Q1)
	#Add four values to the picklist field type (say V1,V2,V3,V4)
	#Add five other fields (say Q2,Q3,Q4,Q5 and Q6)
	#Note: Q1, Q2, Q3, Q4, Q5 and Q6 are ordered successively in the form
	#Use Skip Logic for Q1 (V1 maps to Q2; V2 maps to Q3; V3 maps to Q4; V4 maps to Q5)
	#Add this form to an item
	#
	#STEPS:
	#
	## 1. Create ROE Sales Order
	## Add the above item to the Order
	## Expand the item panel
	#
	#Expected Result:
	#Form with Q1 and Q6 fields should be displayed to the user
	#
	## 1. Select V1 for the picklist field for Q1
	#
	#Expected Result:
	#
	#* Q2 should be displayed on the form, along with the Q1 and Q6 fields only
	#3. 1. Select V2 for the picklist field for Q1
	#Expected Result:
	#* Q3 should be displayed on the form, along with the Q1 and Q6 fields only
	#4. 1. Select V4 for the picklist field for Q1
	#Expected Result:
	#* Q4 should be displayed on the form, along with the Q1 and Q6 fields only
	#5. 1. Select V4 for the picklist field for Q1
	#Expected Result:
	#* Q5 should be displayed on the form, along with the Q1 and Q6 fields only
	#EXPECTED RESULTS:
	#
	#ALTERNATE FLOW(S):

	#Tests C100060
	#
	#PRE-CONDITIONS:
	#Create a form with a picklist field type (say Q1)
	#Add four values to the picklist field type (say V1,V2,V3,V4)
	#Add five other fields (say Q2,Q3,Q4,Q5 and Q6)
	#Note: Q1, Q2, Q3, Q4, Q5 and Q6 are ordered successively in the form
	#Use Skip Logic for Q1 (V1 maps to Q2; V2 maps to Q3; V3 maps to Q4; V4 maps to Q5)
	#Add this form to an item
	#
	#STEPS:
	#
	## 1. Create ROE Sales Order
	## Add the above item to the Order
	## Expand the item panel
	#
	#Expected Result:
	#Form with Q1 and Q6 fields should be displayed to the user
	#
	## 1. Select V1 for the picklist field for Q1
	#
	#Expected Result:
	#
	#* Q2 should be displayed on the form, along with the Q1 and Q6 fields only
	#3. 1. Select V2 for the picklist field for Q1
	#Expected Result:
	#* Q3 should be displayed on the form, along with the Q1 and Q6 fields only
	#4. 1. Select V4 for the picklist field for Q1
	#Expected Result:
	#* Q4 should be displayed on the form, along with the Q1 and Q6 fields only
	#5. 1. Select V4 for the picklist field for Q1
	#Expected Result:
	#* Q5 should be displayed on the form, along with the Q1 and Q6 fields only
	#EXPECTED RESULTS:
	#
	#ALTERNATE FLOW(S):
	@TEST_PD-29943 @REQ_PD-29442 @regression @21Winter @22Winter @lakshman
	Scenario: Test Respond to a form with skip logic for picklist field, in ROE
		Given User will select "George Washington" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoPickListSkipLogicItem" item on rapid order entry
		Then User verifies the display of fields based on the Skip logic for "Car Brand" with the field "Car Model"
			| brandName   | originCountry            |
			| Tata Motors | INDIA                    |
			| Tesla       | UNITED STATES OF AMERICA |
			| Rolls Royce | UNITED KINGDOM           |
			| Porsche     | GERMANY                  |
