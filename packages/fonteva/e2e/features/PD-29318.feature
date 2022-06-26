@REQ_PD-29318
Feature: Manage Button on Company subscription is not working.
	#h2. Details
	#When we log in to the portal for a contact having a Primary assignment role and try to manage its Organizational/Affiliate Membership by clicking on the manage button, the manage button does not work at all and hence assignment is not able to manage the subscription.
	#h2. Steps to Reproduce
	#Steps to Replicate:
	#
	#1) Go to this (https://cgillc.lightning.force.com/lightning/r/OrderApi__Subscription__c/a2A1Y0000035tUBUAY/view) subscription record.
	#2) Open its subscriber records and try to login to the portal using the primary assignment having Organizational Assignment role named Crystal Squires (https://cgillc.lightning.force.com/lightning/r/Contact/0032A00002XTkT6QAL/view)
	#3) Now go to the Organizational/Affiliate Membership and then try to click the manage button and see that it doesn't work.
	#
	#Refer to this video to replicate the issue:  https://fonteva.zoom.us/rec/share/_uKq52JK81lxy2r-3qzerxs-1_qyVJld655SPixqg_EbRpv8pDKpedcpnn8AYUva.Okq4P83GQPzBYVu8
	#
	#Steps were taken so far:
	#
	#1) Checked all the data populated for this subscription record.
	#2) Removed all the custom CSS used by the client and then tried using the manage button but it didn't work.
	#2) Deleted all the existing assignments on this subscription and made a new primary assignment with the Organizational Administrator assignment role and then tried to manage the assignment using the manage button on the portal but the manage button was still not working.
	#h2. Expected Results
	#After clicking the manage button it should open a new page where we should be able to manage the assignments for this subscription record.
	#h2. Actual Results
	#When we click the manage button than nothing happens.
	#h2. Business Justification
	#The client is not able to manage the assignments for this subscription.

	#Tests h2. Details
	#When we log in to the portal for a contact having a Primary assignment role and try to manage its Organizational/Affiliate Membership by clicking on the manage button, the manage button does not work at all and hence assignment is not able to manage the subscription.
	#h2. Steps to Reproduce
	#Steps to Replicate:
	#
	#1) Go to this (https://cgillc.lightning.force.com/lightning/r/OrderApi__Subscription__c/a2A1Y0000035tUBUAY/view) subscription record.
	#2) Open its subscriber records and try to login to the portal using the primary assignment having Organizational Assignment role named Crystal Squires (https://cgillc.lightning.force.com/lightning/r/Contact/0032A00002XTkT6QAL/view)
	#3) Now go to the Organizational/Affiliate Membership and then try to click the manage button and see that it doesn't work.
	#
	#Refer to this video to replicate the issue:  https://fonteva.zoom.us/rec/share/_uKq52JK81lxy2r-3qzerxs-1_qyVJld655SPixqg_EbRpv8pDKpedcpnn8AYUva.Okq4P83GQPzBYVu8
	#
	#Steps were taken so far:
	#
	#1) Checked all the data populated for this subscription record.
	#2) Removed all the custom CSS used by the client and then tried using the manage button but it didn't work.
	#2) Deleted all the existing assignments on this subscription and made a new primary assignment with the Organizational Administrator assignment role and then tried to manage the assignment using the manage button on the portal but the manage button was still not working.
	#h2. Expected Results
	#After clicking the manage button it should open a new page where we should be able to manage the assignments for this subscription record.
	#h2. Actual Results
	#When we click the manage button than nothing happens.
	#h2. Business Justification
	#The client is not able to manage the assignments for this subscription.
	@REQ_PD-29318 @TEST_PD-29444 @regression @21Winter @22Winter @santosh
	Scenario: Test Manage Button on Company subscription is not working.
		Given User will select "Global Media" account
		When User opens the Rapid Order Entry page from account
		And User should be able to add "autoSubscriptionItem" item on rapid order entry
		And User navigate to "apply payment" page for "autoSubscriptionItem" item from rapid order entry
		And User should be able to apply payment for "autoSubscriptionItem" item using "Credit Card" payment on apply payment page
		And User navigate to community Portal page with "carolework@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User will select the "Account Subscriptions" page in LT Portal
		And User should be able to click on manage subscription and verify renew button is displayed
