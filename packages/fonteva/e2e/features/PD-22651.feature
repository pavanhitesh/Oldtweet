@REQ_PD-22651
Feature: Hyperlink formula fields not displaying in Fonteva Lightning Communities (when used in Field Sets)
	#*Reproduced by* Erich Ehinger in 19.1.0.14
	#
	#*Reference Case#*[00021319|https://fonteva.my.salesforce.com/5003A00000zcexMQAQ]
	#
	#*Description:*
	#
	#Formula fields (Hyperlink/text) that would display successfully in CP Based communities "Field-Sets" now do not show up in the new Fonteva Lightning Communities
	#
	#*Steps to Reproduce:*
	#
	## Create a custom formula field on the Contact Object.
	### Make sure the new field you created is visible for the community Profile (FLS) so logged in users can see this field on their profile
	## Create a new fieldset and add the custom formula fields to the fieldset. Make sure to add this fieldset to the Community Sirte record
	### OR Use the existing fieldset on the contact where we already display on the profile page
	## Log into the lightning community and go to the profile page.
	#
	#*Actual Results:*
	#
	#Formula text fields do not populate properly on the profile page.
	#
	#*Expected Results:*
	#
	#Formula fields within the fieldset should populate in the profile
	#
	#*PM NOTE:*
	#
	#* Fix needs to go in LTE Package.
	#* See the attachments, issue is tested and confirmed by PM. The CPBASE portal works just fine, we need to fix it for LT portal.
	#
	#Estimate
	#
	#QA: 16h

	#Tests *Reproduced by* Erich Ehinger in 19.1.0.14
	#
	#*Reference Case#*[00021319|https://fonteva.my.salesforce.com/5003A00000zcexMQAQ]
	#
	#*Description:*
	#
	#Formula fields (Hyperlink/text) that would display successfully in CP Based communities "Field-Sets" now do not show up in the new Fonteva Lightning Communities
	#
	#*Steps to Reproduce:*
	#
	## Create a custom formula field on the Contact Object.
	### Make sure the new field you created is visible for the community Profile (FLS) so logged in users can see this field on their profile
	## Create a new fieldset and add the custom formula fields to the fieldset. Make sure to add this fieldset to the Community Sirte record
	### OR Use the existing fieldset on the contact where we already display on the profile page
	## Log into the lightning community and go to the profile page.
	#
	#*Actual Results:*
	#
	#Formula text fields do not populate properly on the profile page.
	#
	#*Expected Results:*
	#
	#Formula fields within the fieldset should populate in the profile
	#
	#*PM NOTE:*
	#
	#* Fix needs to go in LTE Package.
	#* See the attachments, issue is tested and confirmed by PM. The CPBASE portal works just fine, we need to fix it for LT portal.
	#
	#Estimate
	#
	#QA: 16h
	@REQ_PD-22651 @TEST_PD-27629 @regression @21Winter @22Winter
	Scenario: Test Hyperlink formula fields not displaying in Fonteva Lightning Communities (when used in Field Sets)
		Given User navigate to community Portal page with "danielabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		Then User will select the "My Info" page in LT Portal
		And User should be able to see "Hyperlink" formula field with "Salesforce" text that links to "https://www.salesforce.com" site
