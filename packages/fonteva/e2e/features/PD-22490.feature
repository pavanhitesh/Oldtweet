@REQ_PD-22490
Feature: Catalog links stop working when you duplicating an Item detail page or opening Item detail on a new browser tab
	#*Reproduced by* Ewa Imtiaz in 2019.1.0.5
	#
	#*Reference Case#*[00018105|https://fonteva.my.salesforce.com/5003A00000xZ6dHQAS]
	#
	#*Description:*
	#
	#Catalog links stop working when you duplicating an Item detail page or opening Item detail on a new browser tab
	#
	#*Steps to Reproduce:*
	#
	## Create an item (Jackiet)and description add a link to another item
	### Make sure the item is linked to a category so it will show up on the community
	### Find the *Community Site* and the related *Store*
	### Make sure the newly created item is added and punished as a catalog item.
	### You can also use an existing item just make sure it is related to the catalog
	## Navigate to the community (You can log in as Bob Kelly with your GCO Org)
	## Select the item previously configured (Jackiet)
	## Click on the link in the description
	## On the new browser tab that opens, click on any catalog - Merchandise, Publication etc.
	#
	#*Actual Results:*
	#
	#Nothing happens and the URL adds a /null to the end
	#
	#*Expected Results:*
	#
	#Should go to the catalog
	#
	#*PM Note:*
	#
	#* Video Attached.
	#* Development goes into LTE Package. 
	#* Store and Item detail pages live in LTE Package.
	#
	#
	#
	#Estimate
	#
	#QA: 18h

	#Tests *Reproduced by* Ewa Imtiaz in 2019.1.0.5
	#
	#*Reference Case#*[00018105|https://fonteva.my.salesforce.com/5003A00000xZ6dHQAS]
	#
	#*Description:*
	#
	#Catalog links stop working when you duplicating an Item detail page or opening Item detail on a new browser tab
	#
	#*Steps to Reproduce:*
	#
	## Create an item (Jackiet)and description add a link to another item
	### Make sure the item is linked to a category so it will show up on the community
	### Find the *Community Site* and the related *Store*
	### Make sure the newly created item is added and punished as a catalog item.
	### You can also use an existing item just make sure it is related to the catalog
	## Navigate to the community (You can log in as Bob Kelly with your GCO Org)
	## Select the item previously configured (Jackiet)
	## Click on the link in the description
	## On the new browser tab that opens, click on any catalog - Merchandise, Publication etc.
	#
	#*Actual Results:*
	#
	#Nothing happens and the URL adds a /null to the end
	#
	#*Expected Results:*
	#
	#Should go to the catalog
	#
	#*PM Note:*
	#
	#* Video Attached.
	#* Development goes into LTE Package. 
	#* Store and Item detail pages live in LTE Package.
	#
	#
	#
	#Estimate
	#
	#QA: 18h
 @REQ_PD-22490 @TEST_PD-27708 @regression @21Winter @22Winter @svinjamuri
 Scenario: Validate links are not breaking when user navigate to other category without login in the community portal
  Given User navigate to community Portal page with "ettabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
  And User navigated to store of the community portal
  And User selected an item "AutoItem1" from the catalog
  When User clicks on the link from item description
  Then User verifies the item details page of item "AutoItem2" is opened in new window
  When User clicks on category "Merchandise"
  Then User verifies the URL should not be null
