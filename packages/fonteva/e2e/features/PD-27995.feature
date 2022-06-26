@REQ_PD-27995
Feature: RESEARCH: Removed required item for a Subscription item appears when the Subscription item is renewed
	#*Case Reporter* Ritu Muralidhar
	#
	#*Customer* International Society for Technology in Education
	#
	#*Reproduced by* -Erich Ehinger in 2019.1.0.28- Cannot reproduce.
	#
	#Only seeing the issue in ISTE prod 2019.1.0.29
	#
	#*Reference Case#* [00024734|https://fonteva.my.salesforce.com/5004V000011rkV9QAI]
	#
	#*Description:*
	#
	#Here is the recording :
	#[https://fonteva.zoom.us/rec/share/y6Vp2wDEiXQ2FTFgzGW3swo9UFtcIQxyj2HUpD_cgTMbylBJZdKd0yLxUfOotk4.Vy7oxHZIWuWG2ryr?startTime=1626190355000|https://fonteva.zoom.us/rec/share/y6Vp2wDEiXQ2FTFgzGW3swo9UFtcIQxyj2HUpD_cgTMbylBJZdKd0yLxUfOotk4.Vy7oxHZIWuWG2ryr?startTime=1626190355000]
	#
	#*Steps to reproduce in 19R1*
	#
	#
	#* Create a subscription Item
	#* Add 2 advanced items for the subscription (Included Item / Required)
	#* Purchase the sales order
	#* See the new Subscription record created
	#* Deactivate one of the items that is packaged (Item Is Active checkbox = false)
	#* Click Renew button the subscription
	#
	#
	#
	#*Expected results*:
	#
	#Renewal sales order should be smart enough to know that the item is no longer active, and not add it to sales order at renew through the portal, backend, or subscription batchable.
	#
	#
	#
	#*Actual Results*:
	#
	#The deactivated item is still in the SO on any renewal. This causes expectation on delivery of items that are no longer available by the end contact/user.
	#
	#
	#
	#*Business Justification:*
	#
	#If a required package item is discontinued, and an individual has that item as part of their original membership, users should not see old required package item when renewing from the lightning portal
	#
	#*T3 Notes:*
	#
	#Only reproducible in 19R1 and 20Spring.0. Not an issue in 20Spring.1 and 21Winter

	#Tests *Case Reporter* Ritu Muralidhar
	#
	#*Customer* International Society for Technology in Education
	#
	#*Reproduced by* -Erich Ehinger in 2019.1.0.28- Cannot reproduce.
	#
	#Only seeing the issue in ISTE prod 2019.1.0.29
	#
	#*Reference Case#* [00024734|https://fonteva.my.salesforce.com/5004V000011rkV9QAI]
	#
	#*Description:*
	#
	#Here is the recording :
	#[https://fonteva.zoom.us/rec/share/y6Vp2wDEiXQ2FTFgzGW3swo9UFtcIQxyj2HUpD_cgTMbylBJZdKd0yLxUfOotk4.Vy7oxHZIWuWG2ryr?startTime=1626190355000|https://fonteva.zoom.us/rec/share/y6Vp2wDEiXQ2FTFgzGW3swo9UFtcIQxyj2HUpD_cgTMbylBJZdKd0yLxUfOotk4.Vy7oxHZIWuWG2ryr?startTime=1626190355000]
	#
	#*Steps to reproduce in 19R1*
	#
	#
	#* Create a subscription Item
	#* Add 2 advanced items for the subscription (Included Item / Required)
	#* Purchase the sales order
	#* See the new Subscription record created
	#* Deactivate one of the items that is packaged (Item Is Active checkbox = false)
	#* Click Renew button the subscription
	#
	#
	#
	#*Expected results*:
	#
	#Renewal sales order should be smart enough to know that the item is no longer active, and not add it to sales order at renew through the portal, backend, or subscription batchable.
	#
	#
	#
	#*Actual Results*:
	#
	#The deactivated item is still in the SO on any renewal. This causes expectation on delivery of items that are no longer available by the end contact/user.
	#
	#
	#
	#*Business Justification:*
	#
	#If a required package item is discontinued, and an individual has that item as part of their original membership, users should not see old required package item when renewing from the lightning portal
	#
	#*T3 Notes:*
	#
	#Only reproducible in 19R1 and 20Spring.0. Not an issue in 20Spring.1 and 21Winter
	@TEST_PD-28469 @REQ_PD-27995 @21Winter @22Winter @regression @ngunda
	Scenario: Test RESEARCH: Removed required item for a Subscription item appears when the Subscription item is renewed
		Given User will select "Max Foxworth" contact
		When User opens the Rapid Order Entry page from contact
		And User should be able to add "autoSubcriptionWithPackagedSubcriptionItem" item on rapid order entry
		And User navigate to "apply payment" page for "autoSubcriptionWithPackagedSubcriptionItem" item from rapid order entry
		And User should be able to apply payment for "autoSubcriptionWithPackagedSubcriptionItem" item using "Credit Card" payment on apply payment page
		When User makes one of the Included Item of "autoSubcriptionWithPackagedSubcriptionItem" to Inactive
		And User renews the Subscription created from backend
		Then User verifies the newly created Sales Order doesn't include the inactive Included Item
