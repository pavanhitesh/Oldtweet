@REQ_PD-28029
Feature: Contact on the receipt is different from the Sales Order, Sales Order lines, and Receipt lines.
	#*Case Reporter* Himali Shah
	#
	#*Customer* Material Handling Industry
	#
	#*Reproduced by* Sandeep Bangwal in 20Spring.1.12
	#
	#*Reference Case#* [00031025|https://fonteva.my.salesforce.com/5004V000017HRxuQAG]
	#
	#*Description:*
	#
	#The client is experiencing an issue with the contact on the Receipt is being replaced with the primary contact on the Account.
	#
	#The contact on the receipt is different from the Sales Order, Sales Order lines, and Receipt lines.
	#
	#
	#
	#*PM NOTE:*
	#
	#How do we decide which contact/account gets populated on the receipt?
	#
	#Purchases from Community: {color:#ff5630}*(INFORMATION ONLY, DO NOT FIX WITH THIS TICKET)*{color}
	#
	#* We always populate the contact and account from the context
	#** If the user is logged IN: logged in user’s contact/account
	#** If the user is guest: the contact created before payment (the contact matched or created during continue as guest option)
	#
	#Purchases from Backend apply Payment Page: {color:#00b8d9}*THIS IS WHAT WE ARE VALIDATING AND FIXING WITH THIS TICKET*{color}
	#
	#* The page has a section on the top, whoever is selected on that section.
	#
	#*DEV NOTE:*
	#
	#* When payment gets created, we create E-payment first then receipt so the fix should start with fixing e-payment
	#* And this code is likely to be in FDService Version.
	#
	#
	#
	#*Steps to Reproduce:*
	#
	## Process an order using ROE under an account,
	### Apply payment page
	## Change the contact on the order from Bob Kelley (Primary) to Caroline Qureshi.
	## Process the order.
	## The contact on the Sales order, sales order lines, and receipt lines is set to Caroline Qureshi, but the contact on the Receipt defaults to the primary contact on the Account i.e., Bob Kelley.
	#
	#
	#
	#*Link to the screen recording:*
	#
	# [https://drive.google.com/file/d/19uo_3OpRheURsG38r0fmlHWDqLTYLTRh/view?usp=sharing|https://drive.google.com/file/d/19uo_3OpRheURsG38r0fmlHWDqLTYLTRh/view?usp=sharing]
	#
	#
	#
	#*Actual Results:*
	#
	#We have changed the contact from Bob Kelley (Primary) to Caroline Qureshi while placing an order using ROE, but upon completing the processing the contact on Receipt defaults to the primary contact on the account i.e., Bob Kelley, however, the contact on the Sales Order, Sales Order lines, and Receipt lines is set to Caroline Qureshi.
	#
	#*Expected Results:*
	#
	#The contact on the Receipt should not default to the Primary Contact on the account and should be the same as we have on the Sales Order, Sales Order lines, and Receipt lines.
	#
	#*CS Note:*
	#GCO Details: 20Spring.1.13 Org ID: 00D5e000002IZqd
	#
	#
	#
	#*T3 Notes:*
	#
	#[https://github.com/Fonteva/LightningLens/blob/20Spring.1/community/main/default/lwc/applyPaymentPage/applyPaymentPage.js#L372|https://github.com/Fonteva/LightningLens/blob/20Spring.1/community/main/default/lwc/applyPaymentPage/applyPaymentPage.js#L372]
	#We should pass {{this.contactId}}`, not {{this.customerInfo.customerId}}

	#Tests *Case Reporter* Himali Shah
	#
	#*Customer* Material Handling Industry
	#
	#*Reproduced by* Sandeep Bangwal in 20Spring.1.12
	#
	#*Reference Case#* [00031025|https://fonteva.my.salesforce.com/5004V000017HRxuQAG]
	#
	#*Description:*
	#
	#The client is experiencing an issue with the contact on the Receipt is being replaced with the primary contact on the Account.
	#
	#The contact on the receipt is different from the Sales Order, Sales Order lines, and Receipt lines.
	#
	#
	#
	#*PM NOTE:*
	#
	#How do we decide which contact/account gets populated on the receipt?
	#
	#Purchases from Community: {color:#ff5630}*(INFORMATION ONLY, DO NOT FIX WITH THIS TICKET)*{color}
	#
	#* We always populate the contact and account from the context
	#** If the user is logged IN: logged in user’s contact/account
	#** If the user is guest: the contact created before payment (the contact matched or created during continue as guest option)
	#
	#Purchases from Backend apply Payment Page: {color:#00b8d9}*THIS IS WHAT WE ARE VALIDATING AND FIXING WITH THIS TICKET*{color}
	#
	#* The page has a section on the top, whoever is selected on that section.
	#
	#*DEV NOTE:*
	#
	#* When payment gets created, we create E-payment first then receipt so the fix should start with fixing e-payment
	#* And this code is likely to be in FDService Version.
	#
	#
	#
	#*Steps to Reproduce:*
	#
	## Process an order using ROE under an account,
	### Apply payment page
	## Change the contact on the order from Bob Kelley (Primary) to Caroline Qureshi.
	## Process the order.
	## The contact on the Sales order, sales order lines, and receipt lines is set to Caroline Qureshi, but the contact on the Receipt defaults to the primary contact on the Account i.e., Bob Kelley.
	#
	#
	#
	#*Link to the screen recording:*
	#
	# [https://drive.google.com/file/d/19uo_3OpRheURsG38r0fmlHWDqLTYLTRh/view?usp=sharing|https://drive.google.com/file/d/19uo_3OpRheURsG38r0fmlHWDqLTYLTRh/view?usp=sharing]
	#
	#
	#
	#*Actual Results:*
	#
	#We have changed the contact from Bob Kelley (Primary) to Caroline Qureshi while placing an order using ROE, but upon completing the processing the contact on Receipt defaults to the primary contact on the account i.e., Bob Kelley, however, the contact on the Sales Order, Sales Order lines, and Receipt lines is set to Caroline Qureshi.
	#
	#*Expected Results:*
	#
	#The contact on the Receipt should not default to the Primary Contact on the account and should be the same as we have on the Sales Order, Sales Order lines, and Receipt lines.
	#
	#*CS Note:*
	#GCO Details: 20Spring.1.13 Org ID: 00D5e000002IZqd
	#
	#
	#
	#*T3 Notes:*
	#
	#[https://github.com/Fonteva/LightningLens/blob/20Spring.1/community/main/default/lwc/applyPaymentPage/applyPaymentPage.js#L372|https://github.com/Fonteva/LightningLens/blob/20Spring.1/community/main/default/lwc/applyPaymentPage/applyPaymentPage.js#L372]
	#We should pass {{this.contactId}}`, not {{this.customerInfo.customerId}}
	@TEST_PD-28342 @REQ_PD-28029 @regression @21Winter @22Winter @ngunda
	Scenario: Test Contact on the receipt is different from the Sales Order, Sales Order lines, and Receipt lines.
		Given User will select "Foxworth Household" account
		When User opens the Rapid Order Entry page from account
		And User changes the order contact to non-primary contact of the selected account
		And User should be able to add "AutoItem6" item on rapid order entry
		When User selects Payment type as "Process Payment" and Navigate to Apply payment pages
		And User Selects the "Offline - Check" as payment mode and applies payment
		Then User verifies that the selected contact is associated to created SalesOrder, SalesOrderLines, Receipt and Receipt Lines
