@REQ_PD-28401
Feature: Purchase Organization Membership with Paid Advanced Calendar days
	#C89499
	#PRE-CONDITIONS:
	#
	#STEPS:
	#
	## NOTE: The following steps will be used to purchase a membership from the portal as an authenticated user:
	#
	## Login to the portal as an authenticated user
	## Select the Store page
	## Add "Organization Membership with Paid Advanced Calendar Days" to cart
	## Assign Members and Roles for the list of Contacts as follows:
	#
	#* Assign Contact A to role of "Role x", where Contact A = first contact in list
	#* Assign Contact B  to "Role y", where Contact B = second contact in list
	#* Assign Contact C  to "Role z", where Contact C = third contact in list
	#1. Click View Shopping Cart
	#1. Continue to checkout page
	#1. Complete payment using credit card , credit card number = 4111111111111111, CVV=111, select expiry year as the second value in the dropdown
	#1. Click Pay
	#Expected Result:
	#A receipt should be generated for the Membership Item
	#2. NOTE: The following steps will be used to purchase a membership from the portal as a guest user:
	#
	## Navigate to the portal as guest user
	## Select the Store page
	## Add "Organization Membership with Paid Advanced Calendar Days" to cart
	## Proceed to checkout
	## Continue to Checkout as Guest filling in First Name, Last Name and Email
	#
	#* NOTE:  Be sure to use different contact information that is not related to the authenticated portal user used in Step 1
	#1. Complete payment using credit card , credit card number = 4111111111111111, CVV=111, select expiry year as the second value in the dropdown
	#1. Click Pay
	#Expected Result:
	#A receipt should be generated for the Membership Item
	#3. NOTE: The following steps will be used to purchase a membership on the backend:
	#
	## Navigate to the backend
	## Search for the contact in the search bar
	#
	#* NOTE:  Be sure to use a different contact not used in Step 1 (authenticated portal user) or Step 2 (guest portal user)
	#1. Click New Sales Order under the Sales Orders related list
	#1. Select the Posting Entity as Receipt and Schedule Type as Simple Receipt
	#1. Click Save
	#1. Click View All for Sales Orders
	#1. Select the new Sales Order record with today's date, Status = Open and Total = 0.00
	#1. Select Rapid Order Entry button for the created Sales Order
	#1. Search for and select "Organization Membership with Paid Advanced Calendar Days"
	#1. Select "Calendar Membership Plan with Adv Calendar Days & Adv Calendar Paid"
	#1. Click Add to Order
	#1. Select Process Payment and click Go
	#1. Complete payment using credit card , credit card number = 4111111111111111, CVV = 111, select expiry year as the second value in the dropdown
	#1. Click Process Payment
	#Expected Result:
	#Sales Order saved with payment processed
	#4. NOTE: The remaining steps within this test case should be repeated for each contact used: authenticated portal user, guest portal user and contact used to purchase membership on the backend:
	#
	## From the backend, search for the contact used to purchase the membership in the search bar
	## Click View All for Sales Orders
	## Select the Sales Order record created today with Total = <Prorated Price> or < Advanced Price> (see NOTE)
	#
	#NOTE:
	#If today's date is > 10 days from 12/31/<Current Year>, then the price with be prorated, therefore:
	#Prorated Price = (Months remaining * Item Price)/(Total Months in a year), where Months remaining includes the current month
	#
	#i.e. If the current month is August, Months remaining including August = 5, therefore:
	#Prorated Price = (440.00 * 5) / 12 = 183.33
	#
	#If today's date <= 10 days from 12/31/<Current Year>, then the price will be the full item price for the next year plus the price for the month of December for the current year (Advanced Price), therefore:
	#Advanced Price = Item Price + (Item Price / 12)
	#
	#i.e. If the current date is Dec 26th, then:
	#Advanced Price = 440.00 + (440.00 / 12) = 476.67
	#Expected Result:
	#
	#* Sales Order should have Posting Status as Posted
	#5. 1. Select Related tab for the Sales Order record
	#Expected Result:
	#* Sales Order Line record created under Sales Order Lines related list for "Organization Membership with Paid Advanced Calendar Days" with List Price = 440.00 and Sale Price = <Prorated Price> OR <Advanced Price> (depending on the date)
	#* Receipt record created under the Receipts related list should list Total = <Prorated Price> OR <Advanced Price> (depending on the date)
	#* ePayments record created with Message of "Succeeded\!" and Total = <Prorated Price> OR <Advanced Price> (depending on the date)
	#6. 1. Select the Sales Order Line record for the "Organization Membership with Paid Advanced Calendar Days" under the Sales Order Lines related list within the Sales Order record
	#1. Select Related tab for the Sales Order Line record
	#Expected Result:
	#* Subscription record should be listed under the Subscriptions related list for the "Organization Membership with Paid Advanced Calendar Days"
	#* Assignment record(s) should be listed under the Assignments related list listing correct Contact name and Assignment role - see NOTES
	#
	#* NOTES:
	#
	#* For authenticated portal user, there should be 3 Assignment records as follows:
	#* Contact = Contact A, Assignment Role = Role x, Is Primary = true, Is Active = true
	#* Contact = Contact B, Assignment Role = Role y, Is Primary = true, Is Active = true
	#* Contact = Contact C, Assignment Role = Role z, Is Primary = false, Is Active = true
	#
	#* For guest portal user, there should be a single Assignment record with Contact = name entered at checkout, Assignment Role = Role x, Is Primary = true, Is Active = true
	#
	#* For backend purchase, there should be a single Assignment record with Contact = name of contact used to make purchase, Assignment Role = Role x, Is Primary = true, Is Active = true
	#7. 1. Select the Subscription record for the "Organization Membership with Paid Advanced Calendar Days" under the Subscriptions related list within the Sales Order Line record
	#Expected Result:
	#* Subscription should have a Status of Active with:
	#* Subscription Plan = Calendar Membership Plan with Adv Calendar Days & Adv Calendar Paid
	#* Paid Through Date =
	#* 12/31/<Current Year>, if today's date is > 10 days from 12/31
	#* 12/31/<Next Year>, if today's date <= 10 days from 12/31
	#* Current Term Start Date = today's date
	#* Current Term End Date =
	#* 12/31/<Current Year>, if today's date is > 10 days from 12/31
	#* 12/31/<Next Year>, if today's date <= 10 days from 12/31
	#* Activated Date = today's date
	#* Days to Lapse =
	#* # of days between today's date and 12/31/<Current Year>, if today's date is > 10 days from 12/31
	#* # of days between today's date and 12/31/<Current Year> + 365, if today's date is <= 10 days from 12/31
	#
	## 1. Select Related tab for the Subscription record
	#
	#Expected Result:
	#
	#* Term record should be listed under Terms related list with:
	#*  Paid Date = today's date
	#* Term Start Date = today's date,
	#* Term End Date =
	#* 12/31/<Current Year>, if today's date is > 10 days from 12/31
	#* 12/31/<Next Year>, if today's date <= 10 days from 12/31
	#EXPECTED RESULTS:
	#
	#ALTERNATE FLOW(S):

	#Tests C89499
	#PRE-CONDITIONS:
	#
	#STEPS:
	#
	## NOTE: The following steps will be used to purchase a membership from the portal as an authenticated user:
	#
	## Login to the portal as an authenticated user
	## Select the Store page
	## Add "Organization Membership with Paid Advanced Calendar Days" to cart
	## Assign Members and Roles for the list of Contacts as follows:
	#
	#* Assign Contact A to role of "Role x", where Contact A = first contact in list
	#* Assign Contact B  to "Role y", where Contact B = second contact in list
	#* Assign Contact C  to "Role z", where Contact C = third contact in list
	#1. Click View Shopping Cart
	#1. Continue to checkout page
	#1. Complete payment using credit card , credit card number = 4111111111111111, CVV=111, select expiry year as the second value in the dropdown
	#1. Click Pay
	#Expected Result:
	#A receipt should be generated for the Membership Item
	#2. NOTE: The following steps will be used to purchase a membership from the portal as a guest user:
	#
	## Navigate to the portal as guest user
	## Select the Store page
	## Add "Organization Membership with Paid Advanced Calendar Days" to cart
	## Proceed to checkout
	## Continue to Checkout as Guest filling in First Name, Last Name and Email
	#
	#* NOTE:  Be sure to use different contact information that is not related to the authenticated portal user used in Step 1
	#1. Complete payment using credit card , credit card number = 4111111111111111, CVV=111, select expiry year as the second value in the dropdown
	#1. Click Pay
	#Expected Result:
	#A receipt should be generated for the Membership Item
	#3. NOTE: The following steps will be used to purchase a membership on the backend:
	#
	## Navigate to the backend
	## Search for the contact in the search bar
	#
	#* NOTE:  Be sure to use a different contact not used in Step 1 (authenticated portal user) or Step 2 (guest portal user)
	#1. Click New Sales Order under the Sales Orders related list
	#1. Select the Posting Entity as Receipt and Schedule Type as Simple Receipt
	#1. Click Save
	#1. Click View All for Sales Orders
	#1. Select the new Sales Order record with today's date, Status = Open and Total = 0.00
	#1. Select Rapid Order Entry button for the created Sales Order
	#1. Search for and select "Organization Membership with Paid Advanced Calendar Days"
	#1. Select "Calendar Membership Plan with Adv Calendar Days & Adv Calendar Paid"
	#1. Click Add to Order
	#1. Select Process Payment and click Go
	#1. Complete payment using credit card , credit card number = 4111111111111111, CVV = 111, select expiry year as the second value in the dropdown
	#1. Click Process Payment
	#Expected Result:
	#Sales Order saved with payment processed
	#4. NOTE: The remaining steps within this test case should be repeated for each contact used: authenticated portal user, guest portal user and contact used to purchase membership on the backend:
	#
	## From the backend, search for the contact used to purchase the membership in the search bar
	## Click View All for Sales Orders
	## Select the Sales Order record created today with Total = <Prorated Price> or < Advanced Price> (see NOTE)
	#
	#NOTE:
	#If today's date is > 10 days from 12/31/<Current Year>, then the price with be prorated, therefore:
	#Prorated Price = (Months remaining * Item Price)/(Total Months in a year), where Months remaining includes the current month
	#
	#i.e. If the current month is August, Months remaining including August = 5, therefore:
	#Prorated Price = (440.00 * 5) / 12 = 183.33
	#
	#If today's date <= 10 days from 12/31/<Current Year>, then the price will be the full item price for the next year plus the price for the month of December for the current year (Advanced Price), therefore:
	#Advanced Price = Item Price + (Item Price / 12)
	#
	#i.e. If the current date is Dec 26th, then:
	#Advanced Price = 440.00 + (440.00 / 12) = 476.67
	#Expected Result:
	#
	#* Sales Order should have Posting Status as Posted
	#5. 1. Select Related tab for the Sales Order record
	#Expected Result:
	#* Sales Order Line record created under Sales Order Lines related list for "Organization Membership with Paid Advanced Calendar Days" with List Price = 440.00 and Sale Price = <Prorated Price> OR <Advanced Price> (depending on the date)
	#* Receipt record created under the Receipts related list should list Total = <Prorated Price> OR <Advanced Price> (depending on the date)
	#* ePayments record created with Message of "Succeeded\!" and Total = <Prorated Price> OR <Advanced Price> (depending on the date)
	#6. 1. Select the Sales Order Line record for the "Organization Membership with Paid Advanced Calendar Days" under the Sales Order Lines related list within the Sales Order record
	#1. Select Related tab for the Sales Order Line record
	#Expected Result:
	#* Subscription record should be listed under the Subscriptions related list for the "Organization Membership with Paid Advanced Calendar Days"
	#* Assignment record(s) should be listed under the Assignments related list listing correct Contact name and Assignment role - see NOTES
	#
	#* NOTES:
	#
	#* For authenticated portal user, there should be 3 Assignment records as follows:
	#* Contact = Contact A, Assignment Role = Role x, Is Primary = true, Is Active = true
	#* Contact = Contact B, Assignment Role = Role y, Is Primary = true, Is Active = true
	#* Contact = Contact C, Assignment Role = Role z, Is Primary = false, Is Active = true
	#
	#* For guest portal user, there should be a single Assignment record with Contact = name entered at checkout, Assignment Role = Role x, Is Primary = true, Is Active = true
	#
	#* For backend purchase, there should be a single Assignment record with Contact = name of contact used to make purchase, Assignment Role = Role x, Is Primary = true, Is Active = true
	#7. 1. Select the Subscription record for the "Organization Membership with Paid Advanced Calendar Days" under the Subscriptions related list within the Sales Order Line record
	#Expected Result:
	#* Subscription should have a Status of Active with:
	#* Subscription Plan = Calendar Membership Plan with Adv Calendar Days & Adv Calendar Paid
	#* Paid Through Date =
	#* 12/31/<Current Year>, if today's date is > 10 days from 12/31
	#* 12/31/<Next Year>, if today's date <= 10 days from 12/31
	#* Current Term Start Date = today's date
	#* Current Term End Date =
	#* 12/31/<Current Year>, if today's date is > 10 days from 12/31
	#* 12/31/<Next Year>, if today's date <= 10 days from 12/31
	#* Activated Date = today's date
	#* Days to Lapse =
	#* # of days between today's date and 12/31/<Current Year>, if today's date is > 10 days from 12/31
	#* # of days between today's date and 12/31/<Current Year> + 365, if today's date is <= 10 days from 12/31
	#
	## 1. Select Related tab for the Subscription record
	#
	#Expected Result:
	#
	#* Term record should be listed under Terms related list with:
	#*  Paid Date = today's date
	#* Term Start Date = today's date,
	#* Term End Date =
	#* 12/31/<Current Year>, if today's date is > 10 days from 12/31
	#* 12/31/<Next Year>, if today's date <= 10 days from 12/31
	#EXPECTED RESULTS:
	#
	#ALTERNATE FLOW(S):
	@TEST_PD-28402 @REQ_PD-28401 @regression @21Winter @22Winter @akash
	Scenario: Test Purchase Organization Membership with Paid Advanced Calendar days = 180 (authenticated user)
		Given User navigate to community Portal page with "danielabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User updates "4" months to Calender End Month and "180" days to advance calender days for "AutoAdvCalenderDaysPlan" plan
		And User should be able to select "AutoAdvCalenderDaysPlan" item with quantity "1" on store
		And User select assign members for subscription
			| name          | role  |
			| Daniela Brown | Admin |
		And User should click on the checkout button
		And User successfully pays for the order using credit card
		And User should see the "receipt" created confirmation message
		Then User verifies "AutoAdvCalenderDaysPlan" item Total Dues, Paid Date, Term Start Date and Term End Date for "portal" checkout

	@TEST_PD-28403 @REQ_PD-28401 @regression @21Winter @22Winter @akash
	Scenario: Test Purchase Organization Membership with Paid Advanced Calendar days = 180( guest user)
		Given User navigate to community Portal page
		And User updates "4" months to Calender End Month and "180" days to advance calender days for "AutoAdvCalenderDaysPlan" plan
		And User should be able to select "AutoAdvCalenderDaysPlan" item with quantity "1" on store
		And User should click on the checkout button
		When User select Continue as a Guest option
		And User fills in First, Last Name and Email
		And User navigates to checkout page as guest
		And User successfully pays for the order using credit card
		And User should see the "receipt" created confirmation message
		Then User verifies "AutoAdvCalenderDaysPlan" item Total Dues, Paid Date, Term Start Date and Term End Date for "portal" checkout

	@TEST_PD-28404 @REQ_PD-28401 @regression @21Winter @22Winter @akash
	Scenario: Test Purchase Organization Membership with Paid Advanced Calendar days = 30(backend)
		Given User will select "Daniela Brown" contact
		And User updates "4" months to Calender End Month and "30" days to advance calender days for "AutoAdvCalenderDaysPlan" plan
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoAdvCalenderDaysPlan" item on rapid order entry
		And User navigate to "apply payment" page for "AutoAdvCalenderDaysPlan" item from rapid order entry
		And User should be able to apply payment for "AutoAdvCalenderDaysPlan" item using "Credit Card" payment on apply payment page
		Then User verifies "AutoAdvCalenderDaysPlan" item Total Dues, Paid Date, Term Start Date and Term End Date for "backend" checkout
