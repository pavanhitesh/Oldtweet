@REQ_PD-29177
Feature: Card swap/update is not working for Auto-Renew enabled subscriptions when the update to the payment method is done from the back
	#h2. Details
	#Card swap/update is not working for Auto-Renew enabled subscriptions when the update to the payment method is done from the back
	#h2. Steps to Reproduce
	#1. Create a Membership Item and create a subscription Plan with Auto-Renew Enabled.
	#2. Navigate to Contact -> ROE -> Add Item to Cart -> Enable Auto Renew -> Process Payment-> Membership is created.
	#3. Navigate to Membership in Member Portal -> Manage -> Check the Credit Card enabled for Auto-Renewal.
	#4. Create a new payment method on Contact.
	#5. Navigate to Membership in the back end -> update the new Payment method on the Membership.
	#6. Navigate to Membership in Member Portal -> Manage -> Check the Credit Card enabled for Auto-Renewal.
	#7. Verify the card is updated to the updated card.
	#h2. Expected Results
	#Card Swap should work for Auto-Renewal enabled subscriptions when updated on Membership in the back.
	#h2. Actual Results
	#Card Swap not working for Auto-Renewal enabled subscriptions when updated on Membership in the back.
	#h2. Business Justification
	#Loss of income if the card used is expired. The renewal won't be processed.

	#Tests h2. Details
	#Card swap/update is not working for Auto-Renew enabled subscriptions when the update to the payment method is done from the back
	#h2. Steps to Reproduce
	#1. Create a Membership Item and create a subscription Plan with Auto-Renew Enabled.
	#2. Navigate to Contact -> ROE -> Add Item to Cart -> Enable Auto Renew -> Process Payment-> Membership is created.
	#3. Navigate to Membership in Member Portal -> Manage -> Check the Credit Card enabled for Auto-Renewal.
	#4. Create a new payment method on Contact.
	#5. Navigate to Membership in the back end -> update the new Payment method on the Membership.
	#6. Navigate to Membership in Member Portal -> Manage -> Check the Credit Card enabled for Auto-Renewal.
	#7. Verify the card is updated to the updated card.
	#h2. Expected Results
	#Card Swap should work for Auto-Renewal enabled subscriptions when updated on Membership in the back.
	#h2. Actual Results
	#Card Swap not working for Auto-Renewal enabled subscriptions when updated on Membership in the back.
	#h2. Business Justification
	#Loss of income if the card used is expired. The renewal won't be processed.
	@REQ_PD-29177 @TEST_PD-29641 @regression @21Winter @22Winter @ngunda @Membership @OrderPayments
	Scenario: Test Card swap/update is not working for Auto-Renew enabled subscriptions when the update to the payment method is done from the back
		Given User creates salesOrders with information provided below:
			| Contact      | Account            | BusinessGroup | Entity  | PostingEntity | ScheduleType   | ItemName                 | Qty |
			| Max Foxworth | Foxworth Household | Foundation    | Contact | Invoice       | Simple Invoice | AutoAdditionalMembership | 1   |
		And User marks the created orders as ready for payment
		And User "Max Foxworth" makes payment for the Orders created
		And User enables auto Renew and updates payment method for the subscription created
		When User navigate to community Portal page with "maxfoxworth@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User will select the "Subscriptions" page in LT Portal
		And User should be able to click on "manage" subscription purchased using "restService"
		And User verifies the payment method displayed on portal is of card type "Visa" and last four digits are "1111"
		When User updates subscription with new payment method of contact "Max Foxworth" with cardtype "MasterCard" and last four digits "4444"
		Then User verifies the payment method displayed on portal is of card type "MasterCard" and last four digits are "4444"
