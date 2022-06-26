@REQ_PD-22491
Feature: LT Community Checkout always displays "Account Login" as a default option. 
	#*Reproduced by* Effie Zhang in 2019.1.0.8
	#
	#*Reference Case#*[00017972|https://fonteva.my.salesforce.com/5003A00000xYZLFQA4]
	#
	#*Description:*
	#
	#When Default Checkout = Guest Checkout, lightning community will still default to Account Login
	#
	#
	#
	#*PM Note:*
	#
	#* When a {color:#ff5630}*guest*{color} user lands on the checkout page, the first thing we ask is contact info 
	#** They can log in (if they already have community user)
	#** They can continue as a guest (which will create contact record)
	#** They can create an account (which will create a user/contact/account)
	#* Store object has a setting called “*Default Checkout*“ this setting defines the behavior of what we display as default on the page load. And the customer can change if they want to,
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#* Got o Store Set Default Checkout = Guest Checkout in the Store settings
	#* Go to lightning community store as a guest
	#* Add an item, continue to the checkout page
	#* Account Login always pops up first
	#
	#*Actual Results:*
	#
	#{color:#3e3e3c}When Default Checkout = Guest Checkout, lightning community will still default to Account Login {color}
	#
	#*Expected Results:*
	#
	#{color:#3e3e3c}When Default Checkout = Guest Checkout, lightning community should default to Guest Checkout{color}

	#Tests *Reproduced by* Effie Zhang in 2019.1.0.8
	#
	#*Reference Case#*[00017972|https://fonteva.my.salesforce.com/5003A00000xYZLFQA4]
	#
	#*Description:*
	#
	#When Default Checkout = Guest Checkout, lightning community will still default to Account Login
	#
	#
	#
	#*PM Note:*
	#
	#* When a {color:#ff5630}*guest*{color} user lands on the checkout page, the first thing we ask is contact info 
	#** They can log in (if they already have community user)
	#** They can continue as a guest (which will create contact record)
	#** They can create an account (which will create a user/contact/account)
	#* Store object has a setting called “*Default Checkout*“ this setting defines the behavior of what we display as default on the page load. And the customer can change if they want to,
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#* Got o Store Set Default Checkout = Guest Checkout in the Store settings
	#* Go to lightning community store as a guest
	#* Add an item, continue to the checkout page
	#* Account Login always pops up first
	#
	#*Actual Results:*
	#
	#{color:#3e3e3c}When Default Checkout = Guest Checkout, lightning community will still default to Account Login {color}
	#
	#*Expected Results:*
	#
	#{color:#3e3e3c}When Default Checkout = Guest Checkout, lightning community should default to Guest Checkout{color}
	@REQ_PD-22491 @TEST_PD-27768 @regression @21Winter @22Winter @sophiya
	Scenario Outline: Test LT Community Checkout always displays "<checkoutType>" as a default option. 
		Given User should update the default checkout value as "<checkoutType>" in "Foundation Store" store
		Then User navigate to community Portal page
		Then User should be able to select "AutoItem2" item with quantity "1" on store
		Then User should click on the checkout button
		And User should see "<modalHeading>" modal for guest login

		Examples:
			| checkoutType   | modalHeading      |
			| Account Login  | Create Account    |
			| Guest Checkout | Continue as Guest |
