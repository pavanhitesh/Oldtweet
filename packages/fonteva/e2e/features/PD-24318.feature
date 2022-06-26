@REQ_PD-24318
Feature: Cancel button on the price rule does not exit the price rule.
	#*Case Reporter* Ian Shaw
	#
	#*Customer* Royal Automobile Club
	#
	#*Reproduced by* Kapil Patel in 2019.1.0.29
	#
	#*Reference Case#* [00025210|https://fonteva.my.salesforce.com/5004V000011tQsiQAE]
	#
	#*Description:*
	#
	#Not a good SFDC user experience.
	#
	#*PM NOTE:*
	#
	#See the video, the cancel button is not taking the user back to the item page. This bug is only reproducible in *Lightning* mode.
	#
	#[https://fonteva.zoom.us/rec/share/f2JHgbqyHkK4ahTYXy0ajQnNYq9rBYUNMJH1UBxYGlpUhJwZPqPBSu-5eXgJIGoc.cl_48WjtuzWUADi7|https://fonteva.zoom.us/rec/share/f2JHgbqyHkK4ahTYXy0ajQnNYq9rBYUNMJH1UBxYGlpUhJwZPqPBSu-5eXgJIGoc.cl_48WjtuzWUADi7]
	#
	#*Steps to Reproduce:*
	#
	#* Make sure you are on Lightning mode.
	#* Go to any item and scroll down to the Price Rule-related list.
	#* Go to any price rule
	#* Click on 'Cancel'
	#
	#*Actual Results:*
	#
	#It reloads the price rule.
	#
	#*Expected Results:*
	#
	#It should exit from the price rule page.
	#
	#*T3 Notes:*
	#
	#This bug is only reproducible in *Lightning* mode.
	#
	#* it does not happen when using Manage Price Rule
	#* it happens when we directly enter a Price Rule vf page by clicking the Price Rule name, then cancel out - at this point it reverts back to Price rule VF page
	#
	#When a user clicks a _Cancel_ button, it hits a line in [https://github.com/Fonteva/orderapi/blob/develop/src/aura/PriceRules/PriceRulesHelper.js#L206|https://github.com/Fonteva/orderapi/blob/develop/src/aura/PriceRules/PriceRulesHelper.js#L206]
	#
	#{noformat}if (!$A.util.isUndefinedOrNull(component.get('v.retUrl'))) {
	# window.location = '/' + decodeURIComponent(component.get('v.retUrl'));
	#}{noformat}
	#
	#and this attempts to point current URL to that given by above but this results in coming back to the same URL
	#
	#When the same action is performed in Classics, however, it hits the next condition
	#
	#{noformat}else if (!$A.util.isUndefinedOrNull(component.get('v.sObjId'))) {
	# UrlUtil.navToSObject(component.get({color:#6A8759}'v.sObjId'));
	#}{noformat}
	#
	#which successfully redirects to the correct URL after clicking a _Cancel_ button.

	#Tests *Case Reporter* Ian Shaw
	#
	#*Customer* Royal Automobile Club
	#
	#*Reproduced by* Kapil Patel in 2019.1.0.29
	#
	#*Reference Case#* [00025210|https://fonteva.my.salesforce.com/5004V000011tQsiQAE]
	#
	#*Description:*
	#
	#Not a good SFDC user experience.
	#
	#*PM NOTE:*
	#
	#See the video, the cancel button is not taking the user back to the item page. This bug is only reproducible in *Lightning* mode.
	#
	#[https://fonteva.zoom.us/rec/share/f2JHgbqyHkK4ahTYXy0ajQnNYq9rBYUNMJH1UBxYGlpUhJwZPqPBSu-5eXgJIGoc.cl_48WjtuzWUADi7|https://fonteva.zoom.us/rec/share/f2JHgbqyHkK4ahTYXy0ajQnNYq9rBYUNMJH1UBxYGlpUhJwZPqPBSu-5eXgJIGoc.cl_48WjtuzWUADi7]
	#
	#*Steps to Reproduce:*
	#
	#* Make sure you are on Lightning mode.
	#* Go to any item and scroll down to the Price Rule-related list.
	#* Go to any price rule
	#* Click on 'Cancel'
	#
	#*Actual Results:*
	#
	#It reloads the price rule.
	#
	#*Expected Results:*
	#
	#It should exit from the price rule page.
	#
	#*T3 Notes:*
	#
	#This bug is only reproducible in *Lightning* mode.
	#
	#* it does not happen when using Manage Price Rule
	#* it happens when we directly enter a Price Rule vf page by clicking the Price Rule name, then cancel out - at this point it reverts back to Price rule VF page
	#
	#When a user clicks a _Cancel_ button, it hits a line in [https://github.com/Fonteva/orderapi/blob/develop/src/aura/PriceRules/PriceRulesHelper.js#L206|https://github.com/Fonteva/orderapi/blob/develop/src/aura/PriceRules/PriceRulesHelper.js#L206]
	#
	#{noformat}if (!$A.util.isUndefinedOrNull(component.get('v.retUrl'))) {
	# window.location = '/' + decodeURIComponent(component.get('v.retUrl'));
	#}{noformat}
	#
	#and this attempts to point current URL to that given by above but this results in coming back to the same URL
	#
	#When the same action is performed in Classics, however, it hits the next condition
	#
	#{noformat}else if (!$A.util.isUndefinedOrNull(component.get('v.sObjId'))) {
	# UrlUtil.navToSObject(component.get({color:#6A8759}'v.sObjId'));
	#}{noformat}
	#
	#which successfully redirects to the correct URL after clicking a _Cancel_ button.
	@TEST_PD-27706 @REQ_PD-24318 @regression @21Winter @22Winter @ngunda
	Scenario: Test Cancel button on the price rule does not exit the price rule.
		Given User opens the Price rule for "AutoFreeSubItemWithTaxAndShipping" Item
		Then User clicks on Price rule Cancel button to exit from price rule page
