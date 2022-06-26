@REQ_PD-23005
Feature: Contact Match Rule: "Require Contact Match Custom Field" on Store Configuration not working
	#*Reproduced by* Erich Ehinger in 2019.1.0.19
	#
	#*Reference Case#*[00022067|https://fonteva.my.salesforce.com/5003A000010COYMQA4]
	#
	#*Description:*
	#
	#"*_Require Contact Match Custom Field_*" on Store Configuration not working.
	#
	#
	#
	#*PM NOTE:*
	#
	#_Watch the video for grooming_
	#
	#The field only accepts one field, not CSV.
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#* Navigate to Store 
	#* Configure Contact Matching Rule with “OR” and add Contact Match Custom Field with some custom field
	#* Leave Require Contact Match Custom Field unchecked 
	#** _which means it's not required to enter the Custom field during Registration._
	#
	#2. Navigate to [https://us-tdm-tso-15eb63ff4c6-1626e-171ea893366.force.com/LightningMemberPortal/s/login/SelfRegister|https://us-tdm-tso-15eb63ff4c6-1626e-171ea893366.force.com/LightningMemberPortal/s/login/SelfRegister] (UPDATE THE BASE URL FOR YOU ORG)
	#
	#3. Fill in all details and leave Member Number Blank.
	#
	#4. User not able to click "Create Account" as it is disabled.
	#
	#Or go to store click login and then create an account.
	#
	#VIDEO ATTACHED
	#
	#*Actual Results:*
	#
	#User, not able to register without entering the Custom field.
	#
	#*Expected Results:*
	#
	#Users should be able to proceed with Registration without entering Custom field in Self Register page.

	#Tests *Reproduced by* Erich Ehinger in 2019.1.0.19
	#
	#*Reference Case#*[00022067|https://fonteva.my.salesforce.com/5003A000010COYMQA4]
	#
	#*Description:*
	#
	#"*_Require Contact Match Custom Field_*" on Store Configuration not working.
	#
	#
	#
	#*PM NOTE:*
	#
	#_Watch the video for grooming_
	#
	#The field only accepts one field, not CSV.
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#* Navigate to Store 
	#* Configure Contact Matching Rule with “OR” and add Contact Match Custom Field with some custom field
	#* Leave Require Contact Match Custom Field unchecked 
	#** _which means it's not required to enter the Custom field during Registration._
	#
	#2. Navigate to [https://us-tdm-tso-15eb63ff4c6-1626e-171ea893366.force.com/LightningMemberPortal/s/login/SelfRegister|https://us-tdm-tso-15eb63ff4c6-1626e-171ea893366.force.com/LightningMemberPortal/s/login/SelfRegister] (UPDATE THE BASE URL FOR YOU ORG)
	#
	#3. Fill in all details and leave Member Number Blank.
	#
	#4. User not able to click "Create Account" as it is disabled.
	#
	#Or go to store click login and then create an account.
	#
	#VIDEO ATTACHED
	#
	#*Actual Results:*
	#
	#User, not able to register without entering the Custom field.
	#
	#*Expected Results:*
	#
	#Users should be able to proceed with Registration without entering Custom field in Self Register page.
	@REQ_PD-23005 @TEST_PD-28369 @regression @21Winter @22Winter @sophiya
	Scenario: Test Contact Match Rule: "Require Contact Match Custom Field" on Store Configuration not working
		Given User should update the contact match rule as "<matchRule>" "<matchField>" "<isRequired>" "<backup>" in "Foundation Store" store
		When User navigate to community Portal Self register page
		And User should fill required fields and "<matchRuleField>" and verify button is "<isClickable>"
		Examples:
			| matchRule | matchField                      | isRequired | backup | matchRuleField  | isClickable |
			| OR        | OrderApi__Preferred_Language__c | false      | true   | Active Language | true      |
			| OR        | OrderApi__Preferred_Language__c | true       | false  | Active Language | false     |
