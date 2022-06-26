@REQ_PD-23192
Feature: Using direct links to items in a store (Lt) brakes category Link
	# 	#*Case Reporter* Mark Kurtzrock
	# 	#
	# 	#*Reproduced by* Aaron Gremillion in 2019 R1 1.0.19
	# 	#
	# 	#*Reference Case#* [00021367|https://fonteva.my.salesforce.com/5003A00000zXgq8QAC]
	# 	#
	# 	#*Description:*
	# 	#
	# 	#If a user is provided a link that lands directly on a item in the store. the categories for the navigation fail.
	# 	#
	# 	#If a user accesses the store first, and goes to an item, the category nav, works.
	# 	#
	# 	#*Steps to Reproduce:*
	# 	#
	# 	## Get an item that belongs to a categories direct URL
	# 	### Login to the community and go to Store
	# 	### Click one of the category and then click any item
	# 	### You will be landed on the item detail page, copy that URL
	# 	## Go to a browser and paste in the URL
	# 	### Open a new tab, it can be incognito since store is publick a=and you dont need to be logged in to view items.
	# 	## Attempt to navigate to another category.
	# 	#
	# 	#Video link here: (Also added as attachment)
	# 	#
	# 	#[https://drive.google.com/file/d/1Psc58l8mG2SwZhHtF54jVErHNogn2n0F/view|https://drive.google.com/file/d/1Psc58l8mG2SwZhHtF54jVErHNogn2n0F/view]
	# 	#
	# 	#*Actual Results:*
	# 	#
	# 	#{color:#3e3e3c}Users not be able to navigate to categories when getting direct item links{color}
	# 	#
	# 	#*Expected Results:*
	# 	#
	# 	#Users should be able to navigate to categories when getting direct item links
	# 	#
	# 	#*PM Note:*
	# 	#
	# 	#Fix goes in to LTE Package
	# 	#
	# 	#Estimate
	# 	#
	# 	#QA: 20h

 @REQ_PD-23192 @TEST_PD-27045 @regression @21Winter @22Winter @svinjamuri
 Scenario: Validate links are not breaking when user navigate to other category without login in the community portal
  Given User will select "Etta Brown" contact
  And User navigate to community Portal page with "ettabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
  And User navigated to store of the community portal
  And User selected an item "AutoItem1" from the catalog
  And User open the current url in new window
  Then Item details page of item "AutoItem1" is displayed
  When User clicks on category "Merchandise"
  Then User verifies the URL should not be null
  
