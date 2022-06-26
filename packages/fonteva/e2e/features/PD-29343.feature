@REQ_PD-29343
Feature: MANUAL PASS - badge creation failing for contacts given assignments after initial subscription purchase
	#h2. Details
	#On contacts created/assigned mid-term, assignment is created correctly but badges are not created
	#h2. Steps to Reproduce
	#1- select a subscription with an active term
	#2- login as contact listed as admin on active term for subscription from 1)
	#3- as contact from 2), go to Profile > Manage Org. Membership > Manage button for subscription > Members tab
	#4- add member (enter information in contact popup - new contact created)
	#5- assign new contact from 4) as a member (checkbox)
	#6- confirm that assignment is associated with the new contact from 4)
	#7- ensure program badge and active membership badge are associated with the contact created in 4)
	#
	#Replicated in demo org: 00D5Y000001NCSW
	#Subscriber Access granted.
	#h2. Expected Results
	#The badge should be created
	#h2. Actual Results
	#The badge is not created
	#h2. Business Justification
	#Client's cannot deliver the purchased to their respective customers with the badge.

	#Ensure program badge and active membership badge are associated with the new member after initial subscription purchase
	@TEST_PD-29440 @REQ_PD-29343 @ngunda @regression @21Winter @22Winter @membership @ordercreation
	Scenario: Test badge created for contacts given assignments after initial subscription purchase
		Given User will select "David Brown" contact
		When User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoRenewCalendarPlanWithBadgeWorkFlow" item on rapid order entry
		And User navigate to "apply payment" page for "AutoRenewCalendarPlanWithBadgeWorkFlow" item from rapid order entry
		And User should be able to apply payment for "AutoRenewCalendarPlanWithBadgeWorkFlow" item using "Credit Card" payment on apply payment page
		And User navigate to community Portal page with "davidbrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User will select the "Subscriptions" page in LT Portal
		And User should be able to click on "manage" subscription purchased using "backend"
		And User manages the assign members for the existing subscription
			| newContact | name                  | role      |
			| Yes        | delete_Auto_EttaBrown | Non Admin |
		Then User verifies badge "Auto_MenuItem_Badge" is added and assignment is created for contact "delete_Auto_EttaBrown"

