@REQ_PD-28174
Feature: Purchase Organization Membership with Termed Plan with Scheduling = Automatic Payment and Auto Renew Required
	#C89454
	#PRE-CONDITIONS:
	#
	#STEPS:
	#
	## NOTE: The following steps will be used to purchase a membership from the portal as an authenticated user:
	#
	## Login to the portal as an authenticated user
	## Select the Store page
	## Add "Org Termed Membership with Scheduling = Automatic Payment & Auto Renew Required" to cart
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
	## Add "Org Termed Membership with Scheduling = Automatic Payment & Auto Renew Required" to cart
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
	#1. Search for and select "Org Termed Membership with Scheduling = Automatic Payment & Auto Renew Required"
	#1. Select "Termed Membership Plan with Scheduling = Automatic Payment & Auto Renew Required"
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
	## Select the Sales Order record created today withTotal = 27.50
	#
	#Expected Result:
	#
	#* Sales Order should have:
	#* Posting Status as Posted
	#* Require Payment Method = true (checked)
	#5. 1. Select Related tab for the Sales Order record
	#Expected Result:
	#* Sales Order Line record created under Sales Order Lines related list for the "Org Termed Membership with Scheduling = Automatic Payment & Auto Renew Required" with List Price = 220.00 and Sale Price = 27.50
	#* 7 Scheduled Payment records should be listed under Scheduled Payments related list as follows:
	#* Schedule Payment record 1 has Scheduled Date = today's date + 1 month, Amount = 27.50
	#* Schedule Payment record 2 has Scheduled Date = today's date + 2 months, Amount = 27.50
	#* Schedule Payment record 3 has Scheduled Date = today's date + 3 months, Amount = 27.50
	#* Schedule Payment record 4 has Scheduled Date = today's date + 4 months, Amount = 27.50
	#* Schedule Payment record 5 has Scheduled Date = today's date + 5 months, Amount = 27.50
	#* Schedule Payment record 6 has Scheduled Date = today's date + 6 months, Amount = 27.50
	#* Schedule Payment record 7 has Scheduled Date = today's date + 7 months, Amount = 27.50
	#* Receipt record created under the Receipts related list should list Total = 27.50
	#* ePayments record created with Message of "Succeeded\!" and Total = 27.50
	#6. 1. Select the Sales Order Line record for the "Org Termed Membership with Scheduling = Automatic Payment & Auto Renew Required" under the Sales Order Lines related list within the Sales Order record
	#Expected Result:
	#* Sales Order Line record should have:
	#* Enable Auto Renew = true (checked)
	#7. 1. Select Related tab for the Sales Order Line record
	#Expected Result:
	#* Subscription record should be listed under the Subscriptions related list for the "Org Termed Membership with Scheduling = Automatic Payment & Auto Renew Required"
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
	#
	#
	#
	## 1. Select the Subscription record for the "Org Termed Membership with Scheduling = Automatic Payment & Auto Renew Required" under the Subscriptions related list within the Sales Order Line record
	#
	#Expected Result:
	#
	#* Subscription should have a Status of Active with:
	#* Subscription Plan = Termed Membership Plan with Scheduling = Automatic Payment & Auto Renew Required
	#* Subscription Dues Total = 27.50
	#* Paid Through Date = today's date + 364
	#* Current Term Start Date = today's date
	#* Current Term End Date = today's date + 364
	#* Activated Date = today's date
	#* Days to Lapse = 364
	#* Enable Auto Renew = true (checked)
	#* Payment Method contains a link to a payment method record that matches the method chosen at checkout
	#* Valid Payment Method = true (checked)
	#9. 1. Select Related tab for the Subscription record
	#Expected Result:
	#* Term record should be listed under Terms related list with Paid Date = today's date, Term Start Date = today's date, Term End Date = today's date + 364
	#EXPECTED RESULTS:
	#
	#ALTERNATE FLOW(S):
	#
	#Estimate
	#
	#QA: 24h

	#Tests C89454
	#PRE-CONDITIONS:
	#
	#STEPS:
	#
	## NOTE: The following steps will be used to purchase a membership from the portal as an authenticated user:
	#
	## Login to the portal as an authenticated user
	## Select the Store page
	## Add "Org Termed Membership with Scheduling = Automatic Payment & Auto Renew Required" to cart
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
	## Add "Org Termed Membership with Scheduling = Automatic Payment & Auto Renew Required" to cart
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
	#1. Search for and select "Org Termed Membership with Scheduling = Automatic Payment & Auto Renew Required"
	#1. Select "Termed Membership Plan with Scheduling = Automatic Payment & Auto Renew Required"
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
	## Select the Sales Order record created today withTotal = 27.50
	#
	#Expected Result:
	#
	#* Sales Order should have:
	#* Posting Status as Posted
	#* Require Payment Method = true (checked)
	#5. 1. Select Related tab for the Sales Order record
	#Expected Result:
	#* Sales Order Line record created under Sales Order Lines related list for the "Org Termed Membership with Scheduling = Automatic Payment & Auto Renew Required" with List Price = 220.00 and Sale Price = 27.50
	#* 7 Scheduled Payment records should be listed under Scheduled Payments related list as follows:
	#* Schedule Payment record 1 has Scheduled Date = today's date + 1 month, Amount = 27.50
	#* Schedule Payment record 2 has Scheduled Date = today's date + 2 months, Amount = 27.50
	#* Schedule Payment record 3 has Scheduled Date = today's date + 3 months, Amount = 27.50
	#* Schedule Payment record 4 has Scheduled Date = today's date + 4 months, Amount = 27.50
	#* Schedule Payment record 5 has Scheduled Date = today's date + 5 months, Amount = 27.50
	#* Schedule Payment record 6 has Scheduled Date = today's date + 6 months, Amount = 27.50
	#* Schedule Payment record 7 has Scheduled Date = today's date + 7 months, Amount = 27.50
	#* Receipt record created under the Receipts related list should list Total = 27.50
	#* ePayments record created with Message of "Succeeded\!" and Total = 27.50
	#6. 1. Select the Sales Order Line record for the "Org Termed Membership with Scheduling = Automatic Payment & Auto Renew Required" under the Sales Order Lines related list within the Sales Order record
	#Expected Result:
	#* Sales Order Line record should have:
	#* Enable Auto Renew = true (checked)
	#7. 1. Select Related tab for the Sales Order Line record
	#Expected Result:
	#* Subscription record should be listed under the Subscriptions related list for the "Org Termed Membership with Scheduling = Automatic Payment & Auto Renew Required"
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
	#
	#
	#
	## 1. Select the Subscription record for the "Org Termed Membership with Scheduling = Automatic Payment & Auto Renew Required" under the Subscriptions related list within the Sales Order Line record
	#
	#Expected Result:
	#
	#* Subscription should have a Status of Active with:
	#* Subscription Plan = Termed Membership Plan with Scheduling = Automatic Payment & Auto Renew Required
	#* Subscription Dues Total = 27.50
	#* Paid Through Date = today's date + 364
	#* Current Term Start Date = today's date
	#* Current Term End Date = today's date + 364
	#* Activated Date = today's date
	#* Days to Lapse = 364
	#* Enable Auto Renew = true (checked)
	#* Payment Method contains a link to a payment method record that matches the method chosen at checkout
	#* Valid Payment Method = true (checked)
	#9. 1. Select Related tab for the Subscription record
	#Expected Result:
	#* Term record should be listed under Terms related list with Paid Date = today's date, Term Start Date = today's date, Term End Date = today's date + 364
	#EXPECTED RESULTS:
	#
	#ALTERNATE FLOW(S):
	#
	#Estimate
	#
	#QA: 24h
	@TEST_PD-28175 @REQ_PD-28174 @regression @22Winter @21Winter @akash
	Scenario: Test Purchase Organization Membership with Termed Plan with Scheduling = Automatic Payment and Auto Renew Required (authenticated user)
		Given User navigate to community Portal page with "danielabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User should be able to select "AutoTermedSubsPlan" item with quantity "1" on store
		And User select assign members for subscription
			| name          | role      |
			| Daniela Brown | Admin     |
			| David Brown   | Non Admin |
		And User should click on the checkout button
		And User successfully pays for the order using credit card
		And User should see the "invoice" created confirmation message
		Then User verifies salesOrder and salesOrderLine total for "portal" checkout
		And User verifies "12" Schedule payment is created
		And User verifies receipt and epayment total
		And User verifies assignments and only "1" term is created
			| name          | role      | isActive | isPrimary |
			| Daniela Brown | Admin     | true     | true      |
			| David Brown   | Non Admin | true     | false     |

	@TEST_PD-28176 @REQ_PD-28174 @regression @22Winter @21Winter @akash
	Scenario: Test Purchase Organization Membership with Termed Plan with Scheduling = Automatic Payment and Auto Renew Required (guest user)
		Given User navigate to community Portal page
		And User should be able to select "AutoTermedSubsPlan" item with quantity "1" on store
		And User should click on the checkout button
		When User select Continue as a Guest option
		And User fills in First, Last Name and Email
		And User navigates to checkout page as guest
		And User successfully pays for the order using credit card
		And User should see the "invoice" created confirmation message
		Then User verifies salesOrder and salesOrderLine total for "portal" checkout
		And User verifies "12" Schedule payment is created
		And User verifies receipt and epayment total
		And User verifies assignments and only "1" term is created
			| name  | role  | isActive | isPrimary |
			| Guest | Admin | true     | true      |

	@TEST_PD-28177 @REQ_PD-28174 @regression @22Winter @21Winter @akash
	Scenario: Test Purchase Organization Membership with Termed Plan with Scheduling = Automatic Payment and Auto Renew Required (backend)
		Given User will select "Daniela Brown" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoTermedSubsPlan" item on rapid order entry
		And User navigate to "apply payment" page for "AutoTermedSubsPlan" item from rapid order entry
		Then User should be able to apply payment for "AutoTermedSubsPlan" item using "Credit Card" payment on apply payment page
		And User verifies salesOrder and salesOrderLine total for "backend" checkout
		And User verifies "12" Schedule payment is created
		And User verifies receipt and epayment total
		And User verifies assignments and only "1" term is created
			| name          | role  | isActive | isPrimary |
			| Daniela Brown | Admin | true     | true      |
