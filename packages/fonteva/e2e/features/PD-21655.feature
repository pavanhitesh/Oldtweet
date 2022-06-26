@REQ_PD-21655
Feature: RESEARCH: Renew gives SOQL 101 on membership renewal
	#*CS Note:*
	#
	#Main issue is how package item is configured. See steps to reproduce
	#
	#*Reproduced by* Effie Zhang in 2019.1.0.6
	#
	#*Reference Case#*[00017861|https://fonteva.my.salesforce.com/5003A00000xY0iOQAS]
	#
	#*Description:*
	#
	#Renewing through ROE in lightning
	#
	#Customer has a membership setup with multiple package items. For e.g. a Broker A member would have a required RLS Listing fee and then 2 package items PAC and Manual. The manual is a merchandise product with Shipping and Tax setup. When I try to renew this membership, I get a 101-Too many SOQL queries exception.
	#
	#\*\* NOTE: package items are configured using old "New" button instead of Advanced item setting, and both required items requires price calculation \*\*
	#
	#*Steps to Reproduce:*
	#
	#*Main Subscription item -*
	#
	#* Is subscription = true
	#* Use following subscription plan
	#* 3 package items, 2 of them are required items and requires price calculation _\*\*Use old Add button instead of Advanced Item Setting to require price calculation\*\*_
	#
	#*Subscription plan -*
	#
	#* Type = calendar
	#* Calendar End Day -31
	#* Calendar End Month - 12 - December
	#* Advanced Calendar Days - 92
	#* Advanced Calendar Free/Paid - Free
	#* Enable Proration - True
	#* {color:#3E3E3C}Proration Rule - Semi Annually{color}
	#
	#*First package item, Required, Calculating price -*
	#
	#* is subscription = true
	#* use subscription plan above
	#* {color:#3E3E3C}is active = true{color}
	#* make sure this item is required and requires calculating price
	#
	#*Second package item, Required, Calculating price -*
	#
	#* merchandise item
	#* is active = true
	#* make sure this item is required and requires calculating price
	#
	#*Third package item, Optional item -*
	#
	#* {color:#3E3E3C}is active = true{color}
	#* {color:#3E3E3C}is subscription = true{color}
	#* requires shipping
	#* is taxable = true
	#
	#*Steps to repro:*
	#
	#* Purchase the main subscription, and choose to add the optional item. SO should have 5 SOL now, main subscription, package item 1, package item 2, package item 3, tax, shipping rate
	#* Renew from backend - SQOL 101 error. Attaching debug log in comment
	#** Lightning will give component error, see actual result. No SO created
	#** Classic will create a SO without any SOL
	#
	#*Actual Results:*
	#
	#Get an error "Uncaught Error in $A.getCallback() [title is not defined]
	#
	#Callback failed: apex://OrderApi.RenewSubscriptionsController/ACTION$renewSubscription" on the screen.
	#
	#The logs show error - Too many SOQL queries 101.
	#
	#In SF Classic, SO is created with no SOL.
	#
	#*Expected Results:*
	#
	#No error during renewal

	#Tests *CS Note:*
	#
	#Main issue is how package item is configured. See steps to reproduce
	#
	#*Reproduced by* Effie Zhang in 2019.1.0.6
	#
	#*Reference Case#*[00017861|https://fonteva.my.salesforce.com/5003A00000xY0iOQAS]
	#
	#*Description:*
	#
	#Renewing through ROE in lightning
	#
	#Customer has a membership setup with multiple package items. For e.g. a Broker A member would have a required RLS Listing fee and then 2 package items PAC and Manual. The manual is a merchandise product with Shipping and Tax setup. When I try to renew this membership, I get a 101-Too many SOQL queries exception.
	#
	#\*\* NOTE: package items are configured using old "New" button instead of Advanced item setting, and both required items requires price calculation \*\*
	#
	#*Steps to Reproduce:*
	#
	#*Main Subscription item -*
	#
	#* Is subscription = true
	#* Use following subscription plan
	#* 3 package items, 2 of them are required items and requires price calculation _\*\*Use old Add button instead of Advanced Item Setting to require price calculation\*\*_
	#
	#*Subscription plan -*
	#
	#* Type = calendar
	#* Calendar End Day -31
	#* Calendar End Month - 12 - December
	#* Advanced Calendar Days - 92
	#* Advanced Calendar Free/Paid - Free
	#* Enable Proration - True
	#* {color:#3E3E3C}Proration Rule - Semi Annually{color}
	#
	#*First package item, Required, Calculating price -*
	#
	#* is subscription = true
	#* use subscription plan above
	#* {color:#3E3E3C}is active = true{color}
	#* make sure this item is required and requires calculating price
	#
	#*Second package item, Required, Calculating price -*
	#
	#* merchandise item
	#* is active = true
	#* make sure this item is required and requires calculating price
	#
	#*Third package item, Optional item -*
	#
	#* {color:#3E3E3C}is active = true{color}
	#* {color:#3E3E3C}is subscription = true{color}
	#* requires shipping
	#* is taxable = true
	#
	#*Steps to repro:*
	#
	#* Purchase the main subscription, and choose to add the optional item. SO should have 5 SOL now, main subscription, package item 1, package item 2, package item 3, tax, shipping rate
	#* Renew from backend - SQOL 101 error. Attaching debug log in comment
	#** Lightning will give component error, see actual result. No SO created
	#** Classic will create a SO without any SOL
	#
	#*Actual Results:*
	#
	#Get an error "Uncaught Error in $A.getCallback() [title is not defined]
	#
	#Callback failed: apex://OrderApi.RenewSubscriptionsController/ACTION$renewSubscription" on the screen.
	#
	#The logs show error - Too many SOQL queries 101.
	#
	#In SF Classic, SO is created with no SOL.
	#
	#*Expected Results:*
	#
	#No error during renewal
 @REQ_PD-21655 @TEST_PD-27669 @regression @21Winter @22Winter @akash
 Scenario: Test RESEARCH: Renew gives SOQL 101 on membership renewal
  Given User will select "Daniela Brown" contact
  And User opens the Rapid Order Entry page from contact
  And User should be able to add "SemiAnnualCalSubsPlan" item on rapid order entry
  And User should add optional Item to "SemiAnnualCalSubsPlan" item and go to apply payment page
  And User should be able to apply payment for "SemiAnnualCalSubsPlan" item using "Credit Card" payment on apply payment page
  And User should renew the subscription to "SemiAnnualCalSubsPlan" item on backend
  And User should be able to apply payment for "SemiAnnualCalSubsPlan" item using "Credit Card" payment on apply payment page
  Then User should verify the "2" term, "6" subscription lines and "5" sales orderline is created
  
