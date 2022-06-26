@REQ_PD-24359
Feature: Community Menu Item will not save if External URL does not have a subdomain, even though valid domains without subdomains exist.
	#*Case Reporter* Beth Jennings
	#
	#*Customer* Canadian Association of Emergency Physicians
	#
	#*Reproduced by* Eli Nesson in 2019.1.0.31
	#
	#*Reference Case#* [00025270|https://fonteva.my.salesforce.com/5004V000011tZ0QQAU]
	#
	#*Description:*
	#
	#Community Menu Item will not save if External URL does not have a subdomain, even though valid domains without subdomains exist.
	#
	#Screen recording: [https://www.screencast.com/t/JJjflqQhB0r|https://www.screencast.com/t/JJjflqQhB0r]
	#
	#*Steps to Reproduce:*
	#
	## Navigate to a Community Site (Backend)
	## From the related list, add a Community Menu Item
	## Set Type to External URL
	## In the URL field, enter a valid URL with no subdomain e.g. [https://google.com|https://google.com]
	## Save
	#
	#*Actual Results:*
	#
	#Community Menu Item is not saved, and an error appears on the screen: Please enter a valid URL
	#
	#*Expected Results:*
	#
	#Community Menu Item is saved without providing www part of the URL.
	#
	#*CS Note:*
	#The URL the customer is trying to enter is [https://caep.ca/national-grand-rounds-videos-members-only/|https://caep.ca/national-grand-rounds-videos-members-only/], which is a valid URL.
	#
	#The Menu Item saves if it is changed to [https://www.caep.ca/national-grand-rounds-videos-members-only/|https://www.caep.ca/national-grand-rounds-videos-members-only/]. The Workaround is to add a subdomain.
	#
	#*T3 Notes*:
	#
	#*The Valid URL method needs to be updated.*
	#[https://github.com/Fonteva/LightningLens/blob/0aa86b0b15af415a8dd81c31864570925fc304a8/community/main/default/aura/MenuItem/MenuItemHelper.js#L80-L83|https://github.com/Fonteva/LightningLens/blob/0aa86b0b15af415a8dd81c31864570925fc304a8/community/main/default/aura/MenuItem/MenuItemHelper.js#L80-L83]
	#
	#
	#
	#Estimate
	#
	#QA: 22h

	#Tests *Case Reporter* Beth Jennings
	#
	#*Customer* Canadian Association of Emergency Physicians
	#
	#*Reproduced by* Eli Nesson in 2019.1.0.31
	#
	#*Reference Case#* [00025270|https://fonteva.my.salesforce.com/5004V000011tZ0QQAU]
	#
	#*Description:*
	#
	#Community Menu Item will not save if External URL does not have a subdomain, even though valid domains without subdomains exist.
	#
	#Screen recording: [https://www.screencast.com/t/JJjflqQhB0r|https://www.screencast.com/t/JJjflqQhB0r]
	#
	#*Steps to Reproduce:*
	#
	## Navigate to a Community Site (Backend)
	## From the related list, add a Community Menu Item
	## Set Type to External URL
	## In the URL field, enter a valid URL with no subdomain e.g. [https://google.com|https://google.com]
	## Save
	#
	#*Actual Results:*
	#
	#Community Menu Item is not saved, and an error appears on the screen: Please enter a valid URL
	#
	#*Expected Results:*
	#
	#Community Menu Item is saved without providing www part of the URL.
	#
	#*CS Note:*
	#The URL the customer is trying to enter is [https://caep.ca/national-grand-rounds-videos-members-only/|https://caep.ca/national-grand-rounds-videos-members-only/], which is a valid URL.
	#
	#The Menu Item saves if it is changed to [https://www.caep.ca/national-grand-rounds-videos-members-only/|https://www.caep.ca/national-grand-rounds-videos-members-only/]. The Workaround is to add a subdomain.
	#
	#*T3 Notes*:
	#
	#*The Valid URL method needs to be updated.*
	#[https://github.com/Fonteva/LightningLens/blob/0aa86b0b15af415a8dd81c31864570925fc304a8/community/main/default/aura/MenuItem/MenuItemHelper.js#L80-L83|https://github.com/Fonteva/LightningLens/blob/0aa86b0b15af415a8dd81c31864570925fc304a8/community/main/default/aura/MenuItem/MenuItemHelper.js#L80-L83]
	#
	#
	#
	#Estimate
	#
	#QA: 22h
	@REQ_PD-24359 @TEST_PD-27640 @regression @21Winter @22Winter
	Scenario: Test Community Menu Item will not save if External URL does not have a subdomain, even though valid domains without subdomains exist.
		Given User should navigate to "LTCommunitySite" Community Site
		And User should be able to add new custom community menu item with "<Name>" "<Type>" "<URL>"
		Examples:
			| Name      | Type         | URL                |
			| AutoName  | External URL | https://google.com |
