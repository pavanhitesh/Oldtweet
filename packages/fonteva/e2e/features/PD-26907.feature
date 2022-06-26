@REQ_PD-26907
Feature: Unable to update the subscriber's field while processing order in ROE.
	#*Case Reporter* Kassandra Najjar
	#
	#*Customer* ZERO TO THREE: National Center for Infants, Toddlers and Families
	#
	#*Reproduced by* Sandeep Bangwal in 21Winter.0.3
	#
	#*Reference Case#* [00030762|https://fonteva.my.salesforce.com/5004V000016NF1GQAW]
	#
	#*Description:*
	#
	#When purchasing a subscription through ROE, and you update the Subscriber contact to another contact record, you get a "List Index Out Of Bounds" error.
	#
	#*Org to Reproduce:*
	#Username: enesson-20r2b@fonteva.com
	#
	#Password: Fonteva703
	#
	#Reproduced in 21Winter.0.3
	#
	#*Steps to Reproduce:*
	#
	## Used Bob Kelley's record to purchase a subscription through ROE.
	## Add subscription item FON - National Membership
	### Make sure the subscription item is enabled for assignment.
	### Item has a checkbox called "Enable Assignment"
	## Expand the Item to reveal Subscriber field and Qty, etc.
	## Update Subscriber field to another contact (tested with Bill Adama) and it throws the error on the screen.
	#
	#Link to the screen recording: [https://drive.google.com/file/d/1jFv\_pD2mSp4d4vyu5Sl-zfIquQV-0BlO/view?usp=sharing |https://drive.google.com/file/d/1jFv_pD2mSp4d4vyu5Sl-zfIquQV-0BlO/view?usp=sharing]
	#
	#*Actual Results:*
	#
	#When we try to update the subscriber field in ROE it throws an error. Video Attached.
	#
	#*Expected Results*
	#
	#The client should be able to update the subscriber's field while processing an order through ROE.
	#
	#*Acceptance Criteria*
	#
	#The user should be able to change the subscriber on the ROE.
	#
	#Complete the Order and Check the Subscription record created as a result and verify the subscriber created with the newly selected contact on the ROE Page.
	#
	#*Business Justification:*
	#
	#Unable to update the subscriber's field while processing order in ROE.
	#
	#*T3 Notes:*
	#
	#{color:#881391}message{color}: {color:#C41A16}"Error getting Sales Order Line. List index out of bounds: 0
	#nClass.FDSSPR20.OrderService: line 296, column 1
	#nClass.ROEApi.ItemsBaseController.updateAssignmentObj: line 152, column 1
	#nClass.ROEApi.SubscriptionItemDetailsController.updateAssignment: line 37, column 1"{color}
	#
	#Estimate
	#
	#QA: 22h

	#Tests *Case Reporter* Kassandra Najjar
	#
	#*Customer* ZERO TO THREE: National Center for Infants, Toddlers and Families
	#
	#*Reproduced by* Sandeep Bangwal in 21Winter.0.3
	#
	#*Reference Case#* [00030762|https://fonteva.my.salesforce.com/5004V000016NF1GQAW]
	#
	#*Description:*
	#
	#When purchasing a subscription through ROE, and you update the Subscriber contact to another contact record, you get a "List Index Out Of Bounds" error.
	#
	#*Org to Reproduce:*
	#Username: enesson-20r2b@fonteva.com
	#
	#Password: Fonteva703
	#
	#Reproduced in 21Winter.0.3
	#
	#*Steps to Reproduce:*
	#
	## Used Bob Kelley's record to purchase a subscription through ROE.
	## Add subscription item FON - National Membership
	### Make sure the subscription item is enabled for assignment.
	### Item has a checkbox called "Enable Assignment"
	## Expand the Item to reveal Subscriber field and Qty, etc.
	## Update Subscriber field to another contact (tested with Bill Adama) and it throws the error on the screen.
	#
	#Link to the screen recording: [https://drive.google.com/file/d/1jFv\_pD2mSp4d4vyu5Sl-zfIquQV-0BlO/view?usp=sharing |https://drive.google.com/file/d/1jFv_pD2mSp4d4vyu5Sl-zfIquQV-0BlO/view?usp=sharing]
	#
	#*Actual Results:*
	#
	#When we try to update the subscriber field in ROE it throws an error. Video Attached.
	#
	#*Expected Results*
	#
	#The client should be able to update the subscriber's field while processing an order through ROE.
	#
	#*Acceptance Criteria*
	#
	#The user should be able to change the subscriber on the ROE.
	#
	#Complete the Order and Check the Subscription record created as a result and verify the subscriber created with the newly selected contact on the ROE Page.
	#
	#*Business Justification:*
	#
	#Unable to update the subscriber's field while processing order in ROE.
	#
	#*T3 Notes:*
	#
	#{color:#881391}message{color}: {color:#C41A16}"Error getting Sales Order Line. List index out of bounds: 0
	#nClass.FDSSPR20.OrderService: line 296, column 1
	#nClass.ROEApi.ItemsBaseController.updateAssignmentObj: line 152, column 1
	#nClass.ROEApi.SubscriptionItemDetailsController.updateAssignment: line 37, column 1"{color}
	#
	#Estimate
	#
	#QA: 22h
	@REQ_PD-26907 @TEST_PD-27755 @regression @21Winter @22Winter @santosh
	Scenario: Test Unable to update the subscriber's field while processing order in ROE.
		Given User will select "Bob Kelley" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoSubscriptionWithAlternativeClass2" item on rapid order entry
		When User updates subscriber contact to other contact "Coco Dulce" for a item "AutoSubscriptionWithAlternativeClass2"
		And User navigate to "apply payment" page for "AutoSubscriptionWithAlternativeClass2" item from rapid order entry
		And User should be able to apply payment for "AutoSubscriptionWithAlternativeClass2" item using "Credit Card" payment on apply payment page
		Then User verifies the sales order assignment is assigned to "Coco Dulce" contact

