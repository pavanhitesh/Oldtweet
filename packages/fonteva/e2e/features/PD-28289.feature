@REQ_PD-22663
Feature: Test Advanced Calendar days does not properly update the subscription wit the correct end date
	#Tests *PM / Dev Notes*
	# *
	# ** Issue here is the client wants to override subscription start date in the future so that date is with in the advance calendar period and it should reflect that on the subscription without changing our activation date (journal entries dependencies).
	# ** So, to solve the above issue the following needs to be done
	# *** *the client needs to update the "Activation Date" with the date they want to override and our system will populate the subscription's start date with the overridden value and will calculate the activation date appropriately based on if its "Free/Paid"*
	#
	#*CS Note:*
	#
	#This issue only occurs when the Subscription start date before the Advanced Calendar Days is in the next year e.g. Current Year: 2019 Subscription Start Year: 2020 Subscription End Year: 2021
	#
	#*Reproduced by* Aaron Gremillion in 2.0.10 / R119
	#
	#*Reference Case#*[00015729|https://fonteva.my.salesforce.com/5003A00000vrPi7QAE]
	#
	#*Description:*
	#
	#Subscription with Advanced Calendar Days does not calculate the activation date correctly when the Subscription start date is in the next year
	#
	#*Steps to Reproduce:*
	# * Create a subscription plan named Test Subscription and activate it :
	# ** “End month” = January
	# ** “End day” = ’1’
	# ** “Advanced Calendar days” = ‘180’ or something that causes the activation date to today
	# ** Advanced Calendar free/paid (paid)
	# ** Enable monthly proration
	# * Create a subscription item named ‘Test item’.
	# ** Let the List price be $1089
	# ** Go for “Manage Subscription” to associate the Subscription Plan
	# ** Opt for test subscription to be active.
	# ** And enable the item to be active
	# * Go to contact/ Create contact
	# * Go for lightning ‘Rapid Order Entry’
	# * And choose the ‘Test Item’ created
	# * Complete purchase
	#
	#*Actual Results:*
	#
	#You see item start date to be today and end date is January 1 2020 and the amount is (NUMBER of MONTHS to January) * prorated price.
	#
	#*Expected Results:*
	#
	#Item start date to be today and end date to be January 1 2021 and the amount to be the List price + (NUMBER of MONTHS to January) * prorated price.

	#Tests Tests *PM / Dev Notes*
	# *
	# ** Issue here is the client wants to override subscription start date in the future so that date is with in the advance calendar period and it should reflect that on the subscription without changing our activation date (journal entries dependencies).
	# ** So, to solve the above issue the following needs to be done
	# *** *the client needs to update the "Activation Date" with the date they want to override and our system will populate the subscription's start date with the overridden value and will calculate the activation date appropriately based on if its "Free/Paid"*
	#
	#*CS Note:*
	#
	#This issue only occurs when the Subscription start date before the Advanced Calendar Days is in the next year e.g. Current Year: 2019 Subscription Start Year: 2020 Subscription End Year: 2021
	#
	#*Reproduced by* Aaron Gremillion in 2.0.10 / R119
	#
	#*Reference Case#*[00015729|https://fonteva.my.salesforce.com/5003A00000vrPi7QAE]
	#
	#*Description:*
	#
	#Subscription with Advanced Calendar Days does not calculate the activation date correctly when the Subscription start date is in the next year
	#
	#*Steps to Reproduce:*
	# * Create a subscription plan named Test Subscription and activate it :
	# ** “End month” = January
	# ** “End day” = ’1’
	# ** “Advanced Calendar days” = ‘180’ or something that causes the activation date to today
	# ** Advanced Calendar free/paid (paid)
	# ** Enable monthly proration
	# * Create a subscription item named ‘Test item’.
	# ** Let the List price be $1089
	# ** Go for “Manage Subscription” to associate the Subscription Plan
	# ** Opt for test subscription to be active.
	# ** And enable the item to be active
	# * Go to contact/ Create contact
	# * Go for lightning ‘Rapid Order Entry’
	# * And choose the ‘Test Item’ created
	# * Complete purchase
	#
	#*Actual Results:*
	#
	#You see item start date to be today and end date is January 1 2020 and the amount is (NUMBER of MONTHS to January) * prorated price.
	#
	#*Expected Results:*
	#
	#Item start date to be today and end date to be January 1 2021 and the amount to be the List price + (NUMBER of MONTHS to January) * prorated price.
	@TEST_PD-28289 @REQ_PD-22663 @regression @21Winter @22Winter @akash
	Scenario: Test Test Advanced Calendar days does not properly update the subscription wit the correct end date
		Given User will select "Daniela Brown" contact
		And User updates "4" months to Calender End Month and "180" days to advance calender days for "AutoAdvCalenderDaysPlan" plan
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoAdvCalenderDaysPlan" item on rapid order entry
		And User navigate to "apply payment" page for "AutoAdvCalenderDaysPlan" item from rapid order entry
		And User should be able to apply payment for "AutoAdvCalenderDaysPlan" item using "Credit Card" payment on apply payment page
		Then User verifies Total Dues and Term End Date for "AutoAdvCalenderDaysPlan" item



