@REQ_PD-21954
Feature: "Auto Renewal Setup" tile should not be appearing while renewing the item when the plan is disabled for auto renew.
	#*Reproduced by* Kapil Patel in 2018 R2 2.0.21, 2019 R1 1.0.13
	#
	#*Reference Case#*[00019653|https://fonteva.my.salesforce.com/5003A00000yl9R5QAI]
	#
	#*Description:*
	#
	#"Auto-Renewal Setup" tile should not be appearing while renewing the item when the plan is disabled for auto renew.
	#
	#
	#
	#*PM NOTE:*
	#
	#With this ticket, we will only test the renewal scenario, not the first-time purchase. 
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#* Go to the demo org
	#* select membership item
	#* related plan
	#* Auto-renew option = disabled
	#* go to contact
	#* login to community > profile Membership
	#* renew
	#
	#*Actual Results:*
	#
	#{color:#3e3e3c}"Auto-Renewal Setup" tile appearing while renewing the item.{color}
	#
	#
	#
	#*Expected Results:*
	#
	#{color:#3e3e3c}"Auto-Renewal Setup" tile should not be appearing while renewing the item when the plan is disabled for auto-renew.{color}

	#Tests *Reproduced by* Kapil Patel in 2018 R2 2.0.21, 2019 R1 1.0.13
	#
	#*Reference Case#*[00019653|https://fonteva.my.salesforce.com/5003A00000yl9R5QAI]
	#
	#*Description:*
	#
	#"Auto-Renewal Setup" tile should not be appearing while renewing the item when the plan is disabled for auto renew.
	#
	#
	#
	#*PM NOTE:*
	#
	#With this ticket, we will only test the renewal scenario, not the first-time purchase. 
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#* Go to the demo org
	#* select membership item
	#* related plan
	#* Auto-renew option = disabled
	#* go to contact
	#* login to community > profile Membership
	#* renew
	#
	#*Actual Results:*
	#
	#{color:#3e3e3c}"Auto-Renewal Setup" tile appearing while renewing the item.{color}
	#
	#
	#
	#*Expected Results:*
	#
	#{color:#3e3e3c}"Auto-Renewal Setup" tile should not be appearing while renewing the item when the plan is disabled for auto-renew.{color}
	@REQ_PD-21954 @TEST_PD-28843 @regression @21Winter @22Winter @sophiya
	Scenario: Test "Auto Renewal Setup" tile should not be appearing while renewing the item when the plan is disabled for auto renew.
		Given User will select "Daniela Brown" contact
		When User opens the Rapid Order Entry page from contact
		And User should be able to add "<itemName>" item on rapid order entry
		And User navigate to "apply payment" page for "<itemName>" item from rapid order entry
		And User should be able to apply payment for "<itemName>" item using "Credit Card" payment on apply payment page
		And User navigate to community Portal page with "danielabrown@mailinator.com" user and password "705Fonteva" as "<portalUserType>" user
		And User will select the "Subscriptions" page in LT Portal
		And User should be able to click on "renew" subscription purchased using "backend"
		Then User verifies auto renew tile is "<renewTile>"
		Examples:
			| itemName                          | renewTile | portalUserType |
			| AutoSubscriptionAutoRenewDisabled | absent    | authenticated  |
			| AutoSubscriptionAutoRenewEnabled  | enabled   | Not Required   |
