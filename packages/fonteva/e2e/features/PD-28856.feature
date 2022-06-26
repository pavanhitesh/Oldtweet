@REQ_PD-28856
Feature: Attempt to use the same Community Name on 2 community Sites(Negative)
	#If [Community1.Is|http://Community1.Is] Active = TRUE && the Community Site Id = Community2.Site Id. && [Community2.Is|http://Community2.Is] Active = TRUE
	#
	#* "You can only have one active site per community."

	#Tests If [Community1.Is|http://Community1.Is] Active = TRUE && the Community Site Id = Community2.Site Id. && [Community2.Is|http://Community2.Is] Active = TRUE
	#
	#* "You can only have one active site per community."
	@TEST_PD-28857 @REQ_PD-28856 @regression @21Winter @22Winter @akash
	Scenario: Test Attempt to use the same Community Name on 2 community Sites(Negative)
		Given User navigates to community sites page
		Then User clicks new Community Site and verifies the validation message

