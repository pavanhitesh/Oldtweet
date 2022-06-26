@REQ_PD-27063
Feature: Assigning group members from the Rapid Order Entry screen needs you to click Assign twice
	#*Case Reporter* Ritu Muralidhar
	#
	#*Customer* International Society for Technology in Education
	#
	#*Reproduced by* Erich Ehinger in 2019.1.0.28,20Spring.0.3
	#
	#*Reference Case#* [00024541|https://fonteva.my.salesforce.com/5004V000011Rl0zQAC]
	#
	#*Description:*
	#
	#Assigning group members from Rapid Order Entry screen needs you to click Assign twice
	#
	#*Steps to Reproduce:*
	#
	## Configure an item class that has 
	### Is Subscription = TRUE and Enable Assignments = TRUE
	### Create an assignment role under the item class (with Is Active = TRUE, Is Primary = TRUE, Is Default = TRUE)
	### Check the Is Active checkbox = TRUE
	## Create an item under the Item Class with 
	### Click on the Manage Subscription Plan button in the Subscription Plan related list and select a subscription plan from the list
	### Check the Is Active checkbox = TRUE
	### Populate the Item Price
	## Select a contact and click Rapid Order entry button under the Sales Order related list
	## Search for the above item and select the item
	## Click Add to Cart button
	## Expand the Item detail
	## Search for a contact and select the contact
	## click Assign
	#
	#*Actual Results:*
	#
	#Scrolls to the top of the page and does not add the person. You need to click Assign again to assign the contact
	#
	#*Expected Results:*
	#
	#Should add an assignment and go to the next page or assignment

	#Tests *Case Reporter* Ritu Muralidhar
	#
	#*Customer* International Society for Technology in Education
	#
	#*Reproduced by* Erich Ehinger in 2019.1.0.28,20Spring.0.3
	#
	#*Reference Case#* [00024541|https://fonteva.my.salesforce.com/5004V000011Rl0zQAC]
	#
	#*Description:*
	#
	#Assigning group members from Rapid Order Entry screen needs you to click Assign twice
	#
	#*Steps to Reproduce:*
	#
	## Configure an item class that has 
	### Is Subscription = TRUE and Enable Assignments = TRUE
	### Create an assignment role under the item class (with Is Active = TRUE, Is Primary = TRUE, Is Default = TRUE)
	### Check the Is Active checkbox = TRUE
	## Create an item under the Item Class with 
	### Click on the Manage Subscription Plan button in the Subscription Plan related list and select a subscription plan from the list
	### Check the Is Active checkbox = TRUE
	### Populate the Item Price
	## Select a contact and click Rapid Order entry button under the Sales Order related list
	## Search for the above item and select the item
	## Click Add to Cart button
	## Expand the Item detail
	## Search for a contact and select the contact
	## click Assign
	#
	#*Actual Results:*
	#
	#Scrolls to the top of the page and does not add the person. You need to click Assign again to assign the contact
	#
	#*Expected Results:*
	#
	#Should add an assignment and go to the next page or assignment
	@REQ_PD-27063 @TEST_PD-28186 @regression @21Winter @22Winter @sophiya
	Scenario: Test Assigning group members from the Rapid Order Entry screen needs you to click Assign twice
		Given User will select "David Brown" contact
		When User opens the Rapid Order Entry page from contact
		Then User should be able to add "AutoPlanWithAssignments" item on rapid order entry
		And User should be able to assign the contact "Daniela Brown" for the subscription item "AutoPlanWithAssignments"


