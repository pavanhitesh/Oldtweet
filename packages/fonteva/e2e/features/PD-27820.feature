@REQ_PD-27820
Feature: LT Portal > My Profile > Subscriptions: New payment method not updating on future schedule payments and subscription
	#*Case Reporter* Tiia Schurig
	#
	#*Customer* American Institute of Graphic Arts
	#
	#*Reproduced by* Aaron Gremillion in 21Winter.0.4,2019.1.0.44
	#
	#*Reference Case#* [00029901|https://fonteva.my.salesforce.com/5004V000015fJSxQAM]
	#
	#*Description:*
	#
	#When customers attempt to update their payment method on the portal (Profile>Subscriptions>Subscription managment>Update payment method) the applicable records of subscription / scheduled payment are not updated to contain the new payment method.
	#
	#*Steps to Reproduce:*
	#
	#*PRE-REQs*
	#
	## Have a contact that has a subscription with auto renew or installments (Something that requires saved payment method)
	#
	#*STEPS TO REPRO*
	#
	## Log into the lightning portal as the contact from the pre-reqs.
	## go to subscriptions
	## select the subscription you created or had from pre-reqs
	## go to Update Payment Method
	## The modal to change a payment method should appear prompting to change. you can either select a different PM or create one.
	### Creating one has its own sets of challenges and DOES NOT ACTUALLY CHANGE TO THE NEWLY CREATED METHOD – This needs an idea as of 7/8 to improve UX.
	### If you choose to create a new one, you have to go back to step 4 to select the newly created PM ( which is what the customer is expecting here.)
	## Selecting the payment method shows and update on the portal : [https://i.imgur.com/oVMGzTR.png|https://i.imgur.com/oVMGzTR.png]
	## Looking at the back end records, nothing is updated
	### Subscription: [https://i.imgur.com/pgRjQtq.png|https://i.imgur.com/pgRjQtq.png]
	### Scheduled payment: [https://i.imgur.com/fBp7CJ4.png|https://i.imgur.com/fBp7CJ4.png]
	#
	#*Actual Results:*
	#
	#No Error Shown, Instead Subscription and scheduled payments are not updated.
	#
	#if you choose to create a NEW PM at the update payment method page, no changes are made, you have to go back into the payment method update to make the selection of the new PM.
	#
	#*Expected Results:*
	#
	#Using the above function should update *future* *Scheduled payments*. We tested it is already updating the subscription record.
	#
	#Future scheduled payment means, do not update the SPs that are already processed, use *Scheduled Date,* and only update the ones that are in the future
	#
	#
	#
	#*PM NOTE:*
	#
	#When the user updates the PM on the subscription:
	#
	#Update the Subscription record and see if it has any related Scheduled Payment Record (SP has a look up to Subscription)
	#
	#
	#
	#*Business Justification:*
	#
	#Causes disruption to the customers scheduled payments

	#Tests *Case Reporter* Tiia Schurig
	#
	#*Customer* American Institute of Graphic Arts
	#
	#*Reproduced by* Aaron Gremillion in 21Winter.0.4,2019.1.0.44
	#
	#*Reference Case#* [00029901|https://fonteva.my.salesforce.com/5004V000015fJSxQAM]
	#
	#*Description:*
	#
	#When customers attempt to update their payment method on the portal (Profile>Subscriptions>Subscription managment>Update payment method) the applicable records of subscription / scheduled payment are not updated to contain the new payment method.
	#
	#*Steps to Reproduce:*
	#
	#*PRE-REQs*
	#
	## Have a contact that has a subscription with auto renew or installments (Something that requires saved payment method)
	#
	#*STEPS TO REPRO*
	#
	## Log into the lightning portal as the contact from the pre-reqs.
	## go to subscriptions
	## select the subscription you created or had from pre-reqs
	## go to Update Payment Method
	## The modal to change a payment method should appear prompting to change. you can either select a different PM or create one.
	### Creating one has its own sets of challenges and DOES NOT ACTUALLY CHANGE TO THE NEWLY CREATED METHOD – This needs an idea as of 7/8 to improve UX.
	### If you choose to create a new one, you have to go back to step 4 to select the newly created PM ( which is what the customer is expecting here.)
	## Selecting the payment method shows and update on the portal : [https://i.imgur.com/oVMGzTR.png|https://i.imgur.com/oVMGzTR.png]
	## Looking at the back end records, nothing is updated
	### Subscription: [https://i.imgur.com/pgRjQtq.png|https://i.imgur.com/pgRjQtq.png]
	### Scheduled payment: [https://i.imgur.com/fBp7CJ4.png|https://i.imgur.com/fBp7CJ4.png]
	#
	#*Actual Results:*
	#
	#No Error Shown, Instead Subscription and scheduled payments are not updated.
	#
	#if you choose to create a NEW PM at the update payment method page, no changes are made, you have to go back into the payment method update to make the selection of the new PM.
	#
	#*Expected Results:*
	#
	#Using the above function should update *future* *Scheduled payments*. We tested it is already updating the subscription record.
	#
	#Future scheduled payment means, do not update the SPs that are already processed, use *Scheduled Date,* and only update the ones that are in the future
	#
	#
	#
	#*PM NOTE:*
	#
	#When the user updates the PM on the subscription:
	#
	#Update the Subscription record and see if it has any related Scheduled Payment Record (SP has a look up to Subscription)
	#
	#
	#
	#*Business Justification:*
	#
	#Causes disruption to the customers scheduled payments
	@REQ_PD-13256 @TEST_PD-28293 @regression @21Winter @22Winter @sophiya
	Scenario: Test LT Portal > My Profile > Subscriptions: New payment method not updating on future schedule payments and subscription
		Given User will select "Daniela Brown" contact
		When User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoTermedPlan" item on rapid order entry
		And User navigate to "apply payment" page for "AutoTermedPlan" item from rapid order entry
		And User should be able to apply payment for "AutoTermedPlan" item using "Credit Card" payment on apply payment page
		And User navigate to community Portal page with "danielabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User will select the "Subscriptions" page in LT Portal
		And User should be able to click on "manage" subscription purchased using "backend"
		Then User should be able to update payment method of subscription
		And User verifies payment method updated only in future scheduled payments
