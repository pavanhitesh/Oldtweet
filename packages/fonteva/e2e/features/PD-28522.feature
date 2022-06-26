@REQ_PD-28522
Feature: Login button on event microsite doesn't allow creation of user account
	#h2. Details
	#Login button on event microsite doesn't allow creation of user account
	#h2. Steps to Reproduce
	#1. Navigate to event microsite
	#2. Click Login button on top right
	#3. Click Not a Member
	#
	#
	#Recording from customer environment: https://avid-my.sharepoint.com/:v:/g/personal/mgonzalez_avid_org/Ec0_-eH1lCNEurIsONx8FuUB20x7IdxOvGkN2AO-0OUQ7A?e=9BTYHw
	#
	#Example from FTO:https://master-fto.force.com/s/lt-event?id=a1m3t0000092BmvAAE
	#FTO creds:
	#fontevaebz9@922.training
	#Fon21winter!
	#h2. Expected Results
	#Displayed fields are First Name, Last Name, Email, Username, and Password
	#h2. Actual Results
	#Displayed fields are First Name, Last Name, and Email
	#h2. Business Justification
	#Go-live blocker

	#Tests h2. Details
	#Login button on event microsite doesn't allow creation of user account
	#h2. Steps to Reproduce
	#1. Navigate to event microsite
	#2. Click Login button on top right
	#3. Click Not a Member
	#
	#
	#Recording from customer environment: https://avid-my.sharepoint.com/:v:/g/personal/mgonzalez_avid_org/Ec0_-eH1lCNEurIsONx8FuUB20x7IdxOvGkN2AO-0OUQ7A?e=9BTYHw
	#
	#Example from FTO:https://master-fto.force.com/s/lt-event?id=a1m3t0000092BmvAAE
	#FTO creds:
	#fontevaebz9@922.training
	#Fon21winter!
	#h2. Expected Results
	#Displayed fields are First Name, Last Name, Email, Username, and Password
	#h2. Actual Results
	#Displayed fields are First Name, Last Name, and Email
	#h2. Business Justification
	#Go-live blocker
 @TEST_PD-29190 @REQ_PD-28522 @21Winter @22Winter @alex @regression
 Scenario: Test Login button on event microsite doesn't allow creation of user account
  Given User navigate to community Portal page
  And User selects event "Auto FreeEvent SingleFormMulTickets" and event type "MultiTicket" on LT portal
  And User tries to login as guest and verifies the presence of username and password fields
