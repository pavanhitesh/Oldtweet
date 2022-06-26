@REQ_PD-28045
Feature: 21WINTER PASSED - Venues without address cause errors in event builder
	#*Case Reporter* Sunita Kode
	#
	#*Customer* American Academy of Family Physicians
	#
	#*Reproduced by* Ewa Imtiaz in 21Winter.0.0
	#
	#*Reference Case#* [00029211|https://fonteva.my.salesforce.com/5004V000014ipsKQAQ]
	#
	#*Description:*
	#
	#Creating a venue
	#
	#*Steps to Reproduce:*
	#
	#1.Create a new event or navigate to the existing one
	#
	#2.Go to the venue tab and select the Create new Venue link
	#
	#3.Enter the Venue name and check the checkbox for the Primary Venu to true
	#
	#4.Click on Save and Continue without populating an address
	#
	#*Actual Results:*
	#
	#There is no validation msg displayed on the page. The page does not close or refresh. The user is presented with an endless spinner.
	#
	#Once the page is closed and reopen the endless spinner is still present on the page.
	#
	#After closing the event builder and navigating to the SF view the incomplete venue is created.
	#
	#*Expected Results:*
	#
	#The venue should not be created without the valid address
	#
	#Validation msg should be displayed
	#
	#*Business Justification:*
	#
	#When there is no Address entered for a venue in event builder, it does not show a validation error. But this is causing a component error or endless spinning on the Save and Continue button and the venues tab does not load thereafter. I had to delete the venue to be able to work in the event builder venues tab.
	#
	#*T3 Notes:*
	#
	#Issue seems in function "saveVenue" of EventBuilderVenuesHelper.js (EventApi).
	#Reason spinner is not stopped -> function "wrangleVenuesStreetNumbersAndNames" is faling due to absense of venue street\_name and street\_number Which is called inside of the saveVenue function.
	#
	#[+{color:#1155CC}https://github.com/Fonteva/eventapi/blob/21Winter/src/aura/EventBuilderVenues/EventBuilderVenuesHelper.js#L86{color}+|https://github.com/Fonteva/eventapi/blob/21Winter/src/aura/EventBuilderVenues/EventBuilderVenuesHelper.js#L86]
	#Note -: In previous version venue record is inserted without the address.
	#
	#
	#Need to call the function 'wrangleVenuesStreetNumbersAndNames' based on valid conditions , so we can get expected result.

	#Tests *Case Reporter* Sunita Kode
	#
	#*Customer* American Academy of Family Physicians
	#
	#*Reproduced by* Ewa Imtiaz in 21Winter.0.0
	#
	#*Reference Case#* [00029211|https://fonteva.my.salesforce.com/5004V000014ipsKQAQ]
	#
	#*Description:*
	#
	#Creating a venue
	#
	#*Steps to Reproduce:*
	#
	#1.Create a new event or navigate to the existing one
	#
	#2.Go to the venue tab and select the Create new Venue link
	#
	#3.Enter the Venue name and check the checkbox for the Primary Venu to true
	#
	#4.Click on Save and Continue without populating an address
	#
	#*Actual Results:*
	#
	#There is no validation msg displayed on the page. The page does not close or refresh. The user is presented with an endless spinner.
	#
	#Once the page is closed and reopen the endless spinner is still present on the page.
	#
	#After closing the event builder and navigating to the SF view the incomplete venue is created.
	#
	#*Expected Results:*
	#
	#The venue should not be created without the valid address
	#
	#Validation msg should be displayed
	#
	#*Business Justification:*
	#
	#When there is no Address entered for a venue in event builder, it does not show a validation error. But this is causing a component error or endless spinning on the Save and Continue button and the venues tab does not load thereafter. I had to delete the venue to be able to work in the event builder venues tab.
	#
	#*T3 Notes:*
	#
	#Issue seems in function "saveVenue" of EventBuilderVenuesHelper.js (EventApi).
	#Reason spinner is not stopped -> function "wrangleVenuesStreetNumbersAndNames" is faling due to absense of venue street\_name and street\_number Which is called inside of the saveVenue function.
	#
	#[+{color:#1155CC}https://github.com/Fonteva/eventapi/blob/21Winter/src/aura/EventBuilderVenues/EventBuilderVenuesHelper.js#L86{color}+|https://github.com/Fonteva/eventapi/blob/21Winter/src/aura/EventBuilderVenues/EventBuilderVenuesHelper.js#L86]
	#Note -: In previous version venue record is inserted without the address.
	#
	#
	#Need to call the function 'wrangleVenuesStreetNumbersAndNames' based on valid conditions , so we can get expected result.
 @TEST_PD-29209 @REQ_PD-28045 @Event_Builder @21Winter @22Winter @alex @regression
 Scenario: Test 21WINTER PASSED - Venues without address cause errors in event builder
  Given User creates new primary venue "Primary venue without address" without address for "AutoEvent1" event
  Then User validates that primary venue "Primary venue without address" without address for "saved event" event is created
