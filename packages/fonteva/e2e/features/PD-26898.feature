@REQ_PD-26898
Feature: Cancelled Sales Orders should not show in portal
	#*Case Reporter* Dragana Brighton
	#
	#*Customer* International Institute of Business Analysis
	#
	#*Reproduced by* Aaron Gremillion in2019 R1 1..0.23
	#
	#*Reference Case#* [00022198|https://fonteva.my.salesforce.com/5003A000010CwAMQA0]
	#
	#*Description:*
	#
	#Customers feel that orders that have a status of "CANCELLED" should not show in the portal. –
	#
	#Instead, they do, and they can be paid for, leading to a bad check out, and other errors.
	#
	#
	#
	#*PM Note:*
	#
	#With Order Smash (20Spring.0), users will not be able to cancel orders anymore. We will be fixing this bug to protect their existing data. If the order is created and canceled before the upgrade, the system should not show those orders on the Order Summary Builder.
	#
	#Sales Order has a checkbox called "Is Cancelled" it is *not on the layout and it is not in use*. {color:#ff5630}*But we did not delete the field on purpose*{color}. So we just need to make sure, if a Sales Order marked as Is Cancelled = true, we should not show it on the Order Summary builder.
	#
	#Order Summary builder lives in LTE Package.
	#
	#
	#
	#*Steps to Reproduce:*
	#
	## Create a Sales Order and add any item to this order
	### You can create the order manually on the backend.
	## Update the layout for SO and add Is Cancelled checkbox to the layout
	## Check the checkbox
	## Now login to the community using the contact on the sales order
	### Or you can use backend Order Summary builder since it is the same component/page (Order Summary Builder)
	## Go to the Invoice/Orders tab under my profile
	#
	#*Actual Results:*
	#
	#Canceled orders showing in the portal.
	#
	#*Expected Results:*
	#
	#Cancelled SOs should not appear in the portal. Neither under “Open” or “All” tabs
	#
	#*Dev Notes:*
	#
	#This is where we need to adjust our query
	#[https://github.com/Fonteva/LightningLens/blob/22e352af6a820828159f5671ed9a6a239c91f0e7/community/main/default/classes/StatementBuilderController.cls#L685|https://github.com/Fonteva/LightningLens/blob/22e352af6a820828159f5671ed9a6a239c91f0e7/community/main/default/classes/StatementBuilderController.cls#L685]
	#
	#
	#
	#*Estimates:*
	#
	#DEV: 20h
	#
	#QA: 20h

	#Tests *Case Reporter* Dragana Brighton
	#
	#*Customer* International Institute of Business Analysis
	#
	#*Reproduced by* Aaron Gremillion in2019 R1 1..0.23
	#
	#*Reference Case#* [00022198|https://fonteva.my.salesforce.com/5003A000010CwAMQA0]
	#
	#*Description:*
	#
	#Customers feel that orders that have a status of "CANCELLED" should not show in the portal. –
	#
	#Instead, they do, and they can be paid for, leading to a bad check out, and other errors.
	#
	#
	#
	#*PM Note:*
	#
	#With Order Smash (20Spring.0), users will not be able to cancel orders anymore. We will be fixing this bug to protect their existing data. If the order is created and canceled before the upgrade, the system should not show those orders on the Order Summary Builder.
	#
	#Sales Order has a checkbox called "Is Cancelled" it is *not on the layout and it is not in use*. {color:#ff5630}*But we did not delete the field on purpose*{color}. So we just need to make sure, if a Sales Order marked as Is Cancelled = true, we should not show it on the Order Summary builder.
	#
	#Order Summary builder lives in LTE Package.
	#
	#
	#
	#*Steps to Reproduce:*
	#
	## Create a Sales Order and add any item to this order
	### You can create the order manually on the backend.
	## Update the layout for SO and add Is Cancelled checkbox to the layout
	## Check the checkbox
	## Now login to the community using the contact on the sales order
	### Or you can use backend Order Summary builder since it is the same component/page (Order Summary Builder)
	## Go to the Invoice/Orders tab under my profile
	#
	#*Actual Results:*
	#
	#Canceled orders showing in the portal.
	#
	#*Expected Results:*
	#
	#Cancelled SOs should not appear in the portal. Neither under “Open” or “All” tabs
	#
	#*Dev Notes:*
	#
	#This is where we need to adjust our query
	#[https://github.com/Fonteva/LightningLens/blob/22e352af6a820828159f5671ed9a6a239c91f0e7/community/main/default/classes/StatementBuilderController.cls#L685|https://github.com/Fonteva/LightningLens/blob/22e352af6a820828159f5671ed9a6a239c91f0e7/community/main/default/classes/StatementBuilderController.cls#L685]
	#
	#
	#
	#*Estimates:*
	#
	#DEV: 20h
	#
	#QA: 20h
	@REQ_PD-26898 @TEST_PD-27605 @regression @21Winter @22Winter @pavan
	Scenario: Test Cancelled Sales Orders should not show in portal
		Given User will select "Coco Dulce" contact
		And User opens the Rapid Order Entry page from contact
		And User create a Sales Order "AutoItem1" from ROE and update IsProforma and IsCancelled as true
		When User navigate to community Portal page with "cdulce@mailinator.com" user and password "705Fonteva" as "authenticated" user
		Then User Navigated to Order Page and valiadate the Cancelled Sales Order are not displayed under Open Order Tab
		And User Validates Cancelled Sales Orders are not present under All Orders Tab
