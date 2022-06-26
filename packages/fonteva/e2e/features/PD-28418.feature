@REQ_PD-28418
Feature: Renew button in cpbase reflecting after the post term period on the expired termed Subscription
	#h2. Details
	#
	#Renew button reflecting after the post-term period on the expired termed Subscription
	#
	#
	#
	#h2. PM NOTE:
	#
	#Bug Reported against CPBASE Portal, We will validate and fixed against LT Portal
	#
	#If the field (_OrderApi__PostTerm_Renewal_Window__c_) is blank on the sub plan, I can renew. Do not disable the button
	#
	#h2. Steps to Reproduce
	#
	#Environment- 19R1
	#username - enesson-19r1b@fonteva.com
	#password - Fonteva703
	#
	#Predefined condition
	#1  Contact having membership of termed based subscription plan which is expired
	#2 And the post-term renewal days has been passed
	#
	#Steps
	#1 log in to the community as the user who has the subscription
	#2 go to the memberships
	#3 click on the expired termed subscription
	#
	#h2. Expected Results
	#
	#the renew button should not be visible after the post-term days and it should be visible as expired
	#
	#* IF _OrderApi__PostTerm_Renewal_Window__c_ is empty and Subscription is expired I can see the renew button
	#* If _OrderApi__PostTerm_Renewal_Window__c_ is NOT Empty and the subscription is expired, then we need to calculate how many days lapsed and then decide wheater or not to display renew button
	#
	#h2. Actual Results
	#
	#the renew button is enabled through the post-term renew date has passed
	#
	#h2. Business Justification
	#
	#started a campaign for the expired members and this functionality is not allowing to implement the fresh join process for the expired members. It's allows expired members to renew.

	#Tests h2. Details
	#
	#Renew button reflecting after the post-term period on the expired termed Subscription
	#
	#
	#
	#h2. PM NOTE:
	#
	#Bug Reported against CPBASE Portal, We will validate and fixed against LT Portal
	#
	#If the field (_OrderApi__PostTerm_Renewal_Window__c_) is blank on the sub plan, I can renew. Do not disable the button
	#
	#h2. Steps to Reproduce
	#
	#Environment- 19R1
	#username - enesson-19r1b@fonteva.com
	#password - Fonteva703
	#
	#Predefined condition
	#1  Contact having membership of termed based subscription plan which is expired
	#2 And the post-term renewal days has been passed
	#
	#Steps
	#1 log in to the community as the user who has the subscription
	#2 go to the memberships
	#3 click on the expired termed subscription
	#
	#h2. Expected Results
	#
	#the renew button should not be visible after the post-term days and it should be visible as expired
	#
	#* IF _OrderApi__PostTerm_Renewal_Window__c_ is empty and Subscription is expired I can see the renew button
	#* If _OrderApi__PostTerm_Renewal_Window__c_ is NOT Empty and the subscription is expired, then we need to calculate how many days lapsed and then decide wheater or not to display renew button
	#
	#h2. Actual Results
	#
	#the renew button is enabled through the post-term renew date has passed
	#
	#h2. Business Justification
	#
	#started a campaign for the expired members and this functionality is not allowing to implement the fresh join process for the expired members. It's allows expired members to renew.
	@REQ_PD-28418 @TEST_PD-28795 @regression @21Winter @22Winter @sophiya
	Scenario: Test Renew button in cpbase reflecting after the post term period on the expired termed Subscription
		Given User will select "David Brown" contact
		When User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoPostTermRenewalWindowItem" item on rapid order entry
		And User navigate to "apply payment" page for "AutoPostTermRenewalWindowItem" item from rapid order entry
		And User should be able to apply payment for "AutoPostTermRenewalWindowItem" item using "Credit Card" payment on apply payment page
		And User expires the subscription by updating date and verifies term status
		And User navigate to community Portal page with "davidbrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User will select the "Subscriptions" page in LT Portal
		Then User updates the post term renewal window as "2" in the subscription plan
		And User verifies the renew button is "displayed"
		And User updates the post term renewal window as "1" in the subscription plan
		And User verifies the renew button is "absent"
