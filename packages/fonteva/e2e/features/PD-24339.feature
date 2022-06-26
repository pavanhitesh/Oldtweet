@REQ_PD-24339
Feature: Account level memberships (both new and renewals) are not created correctly.
	#*Case Reporter* Kim Gamiere
	#
	#*Customer* ASM International
	#
	#*Reproduced by* Prathyusha Pamudoorthi in 2019.1.0.29
	#
	#*Reference Case#* [00023960|https://fonteva.my.salesforce.com/5004V000011PMjtQAG]
	#
	#*Description:*
	#
	#It appears that auto-renewal can be set up at the account level, but when tested the account level memberships are not working as expected.
	#
	#This has been replicated in the ASM's org which is in 2019.1.0.20 and Demo org which is on 2019.1.0.29.
	#
	#*PM Note:*
	#
	#* SO Entry should drive the entity on the SOL (SOL has a lookup to SO)
	#* SOL Entity should drive the entity on the Subscription (Subscription has a lookup to SOL)
	#* Note to QA test this ticket for both new and renewal order
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#New Subscription :
	#
	#* Select a Contact
	#* Go to ROE
	#* Populate Contact's account on Entity 
	#** ROE page has a search box for contact or account
	#** if u pick an account it updates the entity as an account
	#** SO Entity on the SO is Account
	#* Contact will be auto-populated
	#* Select a Subscription Item
	#* Click Go
	#* Enter the Credit Card details
	#* Click process Payment.
	#* Check the below records
	#** {color:#00b8d9}*SO created with Entity Account*{color}
	#** {color:#ff5630}*SOL created with Entity Contact*{color}
	#** {color:#ff5630}*Subscription Created with Entity Contact*{color}
	#
	#Renewal Subscription :
	#
	#* For the above subscription, Make sure Days to lapse = subscription plan's invoice days variable and
	#* Last system run date = Null
	#* Go to Spark Admin
	#* Click Run on Subscription batchable job
	#* Check the below records
	#
	#SO is created with Entity "Contact"
	#
	#SOL is created with Entity "Contact"
	#
	#
	#
	#Note : Please note when the subscription is created, If I change the Entity to Account and run the subscription batchable job then the Renewal order is created with Entity "Account".
	#
	#*Actual Results:*
	#
	#Subscriptions are not created with Entity "Account" for Account level memberships
	#
	#*Expected Results:*
	#
	#Subscriptions should be created with Entity "Account" for Account level memberships.
	#
	#*T3 Notes:*
	#
	#We need to enter ROE from Contact, then change entity to Account to reproduce this error. If we enter ROE directly from Account it works correctly
	#
	#Recording: [https://fonteva.zoom.us/rec/share/dSMMf-E-uauSBnycwI4-1xMYoxrNCpvB99FTaTlXpoHZNqYpyR4NoVil7zsldg4.5a3-ouXF8EJHtvK0|https://fonteva.zoom.us/rec/share/dSMMf-E-uauSBnycwI4-1xMYoxrNCpvB99FTaTlXpoHZNqYpyR4NoVil7zsldg4.5a3-ouXF8EJHtvK0]

	#Tests *Case Reporter* Kim Gamiere
	#
	#*Customer* ASM International
	#
	#*Reproduced by* Prathyusha Pamudoorthi in 2019.1.0.29
	#
	#*Reference Case#* [00023960|https://fonteva.my.salesforce.com/5004V000011PMjtQAG]
	#
	#*Description:*
	#
	#It appears that auto-renewal can be set up at the account level, but when tested the account level memberships are not working as expected.
	#
	#This has been replicated in the ASM's org which is in 2019.1.0.20 and Demo org which is on 2019.1.0.29.
	#
	#*PM Note:*
	#
	#* SO Entry should drive the entity on the SOL (SOL has a lookup to SO)
	#* SOL Entity should drive the entity on the Subscription (Subscription has a lookup to SOL)
	#* Note to QA test this ticket for both new and renewal order
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#New Subscription :
	#
	#* Select a Contact
	#* Go to ROE
	#* Populate Contact's account on Entity 
	#** ROE page has a search box for contact or account
	#** if u pick an account it updates the entity as an account
	#** SO Entity on the SO is Account
	#* Contact will be auto-populated
	#* Select a Subscription Item
	#* Click Go
	#* Enter the Credit Card details
	#* Click process Payment.
	#* Check the below records
	#** {color:#00b8d9}*SO created with Entity Account*{color}
	#** {color:#ff5630}*SOL created with Entity Contact*{color}
	#** {color:#ff5630}*Subscription Created with Entity Contact*{color}
	#
	#Renewal Subscription :
	#
	#* For the above subscription, Make sure Days to lapse = subscription plan's invoice days variable and
	#* Last system run date = Null
	#* Go to Spark Admin
	#* Click Run on Subscription batchable job
	#* Check the below records
	#
	#SO is created with Entity "Contact"
	#
	#SOL is created with Entity "Contact"
	#
	#
	#
	#Note : Please note when the subscription is created, If I change the Entity to Account and run the subscription batchable job then the Renewal order is created with Entity "Account".
	#
	#*Actual Results:*
	#
	#Subscriptions are not created with Entity "Account" for Account level memberships
	#
	#*Expected Results:*
	#
	#Subscriptions should be created with Entity "Account" for Account level memberships.
	#
	#*T3 Notes:*
	#
	#We need to enter ROE from Contact, then change entity to Account to reproduce this error. If we enter ROE directly from Account it works correctly
	#
	#Recording: [https://fonteva.zoom.us/rec/share/dSMMf-E-uauSBnycwI4-1xMYoxrNCpvB99FTaTlXpoHZNqYpyR4NoVil7zsldg4.5a3-ouXF8EJHtvK0|https://fonteva.zoom.us/rec/share/dSMMf-E-uauSBnycwI4-1xMYoxrNCpvB99FTaTlXpoHZNqYpyR4NoVil7zsldg4.5a3-ouXF8EJHtvK0]
	@TEST_PD-28783 @REQ_PD-24339 @21winter @22winter @regression @pavan
	Scenario: Test Account level memberships (both new and renewals) are not created correctly.
		Given User will select "Coco Dulce" contact
		And User opens the Rapid Order Entry page from contact
		And User changes the customer entity from contact to account "Global Media"
		When User should be able to add "autoSubscriptionItem" item on rapid order entry
		And User navigate to "apply payment" page for "autoSubscriptionItem" item from rapid order entry
		And User should be able to apply payment for "autoSubscriptionItem" item using "Credit Card" payment on apply payment page
		Then User verifies SalesOrder,SalesOrderLine and Subscription are with entity type Account for new subscription
