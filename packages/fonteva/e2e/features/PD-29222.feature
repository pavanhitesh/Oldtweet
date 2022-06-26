@REQ_PD-29222
Feature: MANUAL PASS - subscription renewals listing original term, not most recent term in 'previous term' field
	#h2. Details
	#
	#subscription renewals listing original term, not most recent term in 'previous term' field
	#
	#h2. Steps to Reproduce
	#
	#1. Create or locate a subscription with 2 or more terms (duplicate tab for subscription record)
	#2. Click on Renew button.
	#3. Complete Payment of the renewal Sales Order.
	#4. Go to the duplicated tab for the Subscription record - refresh the page.
	#5. Locate the Terms related list and view all Term records.
	#6. Verify if latest term is associated to the "previous" term.
	#
	#GCO Org ID: 00D5Y000001NCSW
	#Recording: [https://fonteva.zoom.us/rec/share/0RKSCM-8la6SeB3pIZevavdI0fN8Lx7IhtNjWYcS_FG9bRueobKpUwlWeSLHDXuZ.pfPaz173QuKNgIDc|https://fonteva.zoom.us/rec/share/0RKSCM-8la6SeB3pIZevavdI0fN8Lx7IhtNjWYcS_FG9bRueobKpUwlWeSLHDXuZ.pfPaz173QuKNgIDc]
	#
	#h2. Expected Results
	#
	#The newest should show the correct previous term
	#
	#h2. Actual Results
	#
	#The newest term has its 'previous term' value set to the value of the initial term, not the most recent.
	#
	#h2. Business Justification
	#
	#This issue corrupts the clients data and the terms will be mixed up on the subscriptions.
	#
	#
	#
	#*T3 Notes:*
	#
	#The cause of the bug is here [https://github.com/Fonteva/FDServiceVersions/blob/21Winter/src/utils/main/classes/SubscriptionUtils.cls#L544|https://github.com/Fonteva/FDServiceVersions/blob/21Winter/src/utils/main/classes/SubscriptionUtils.cls#L544]
	#
	#Need to add ORDER BY CreatedDate DESC in SOQL here [https://github.com/Fonteva/FDServiceVersions/blob/21Winter/src/utils/main/classes/SubscriptionUtils.cls#L191|https://github.com/Fonteva/FDServiceVersions/blob/21Winter/src/utils/main/classes/SubscriptionUtils.cls#L191]

	@TEST_PD-29508 @REQ_PD-29222 @21Winter @22Winter @regression @natya
	Scenario: Test previous term should be set to the most recent term in subscription renewal
		Given User creates salesOrders with information provided below:
			| Contact      | Account      | BusinessGroup | Entity  | PostingEntity | ScheduleType   | ItemName                 | Qty |
			| Mannik Gunda | Global Media | Foundation    | Contact | Invoice       | Simple Invoice | AutoAssignmentMembership | 1   |
		And User marks the created orders as ready for payment
		And User "Mannik Gunda" makes payment for the Orders created
		When User should update the term end date to the past date and renews the subscription
		And User "Mannik Gunda" makes payment for the Orders created
		When User updates the latest term end date to the past date and renews the subscription again
		And User "Mannik Gunda" makes payment for the Orders created
		Then User should be able to verify previous term date is present for new term date

