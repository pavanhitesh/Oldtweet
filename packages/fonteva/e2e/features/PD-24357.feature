@REQ_PD-24357
Feature: Wrong discount code in rapid order entry results in endless loop
	#*Case Reporter* Tina Ruetsche
	#
	#*Customer* AO Foundation
	#
	#*Reproduced by* Kapil Patel in 2019.1.0.31
	#
	#*Reference Case#* [00025294|https://fonteva.my.salesforce.com/5004V000011tdMiQAI]
	#
	#*Description:*
	#
	#If a business user enters the discount code by mistake, it should show the error only, not freeze the page.
	#
	#Video Link Here:
	#
	#[https://fonteva.zoom.us/rec/play/O1o3gLiHeTWIwUQxayp_nvyxdaB2zfmkRloInZRAYAJ-8fGMi5aA7TygTavMZ_JEJhzpxz0qIqiQbz7f.75YJsDLvh6zua85e?continueMode=true|https://fonteva.zoom.us/rec/play/O1o3gLiHeTWIwUQxayp_nvyxdaB2zfmkRloInZRAYAJ-8fGMi5aA7TygTavMZ_JEJhzpxz0qIqiQbz7f.75YJsDLvh6zua85e?continueMode=true]
	#
	#
	#
	#*PM NOTE:*
	#
	#After 20Spring.0 Release, a new payment page has been introduced for the backend. With that being said, {color:#ff5630}now enter the "Discount Code" option as part of the ROE page. Not part of the checkout.{color} We will need to test and fix this ticket within the ROE package.
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#1. Open rapid order entry for a contact
	#
	#2. Select any membership item
	#
	#3. Apply a discount code that is not valid
	#
	#*Actual Results:*
	#
	#Page freezes and customer cannot continue
	#
	#*Expected Results:*
	#
	#"Discount Code is not valid" msg displayed to the customer.
	#
	#
	#
	#*T3 Notes:*
	#
	#Not always reproducible, behavior inconsistent.
	#
	#In this recording, the first 2 tries did not hit the issue - processing changes were completed in a few second,s and Payment button re-enabled.
	#
	#From 1:00, once the new source code was entered, it kept processing changes and the Payment button kept being disabled.
	#
	#
	#
	#Estimate
	#
	#QA: 20h

	#Tests *Case Reporter* Tina Ruetsche
	#
	#*Customer* AO Foundation
	#
	#*Reproduced by* Kapil Patel in 2019.1.0.31
	#
	#*Reference Case#* [00025294|https://fonteva.my.salesforce.com/5004V000011tdMiQAI]
	#
	#*Description:*
	#
	#If a business user enters the discount code by mistake, it should show the error only, not freeze the page.
	#
	#Video Link Here:
	#
	#[https://fonteva.zoom.us/rec/play/O1o3gLiHeTWIwUQxayp_nvyxdaB2zfmkRloInZRAYAJ-8fGMi5aA7TygTavMZ_JEJhzpxz0qIqiQbz7f.75YJsDLvh6zua85e?continueMode=true|https://fonteva.zoom.us/rec/play/O1o3gLiHeTWIwUQxayp_nvyxdaB2zfmkRloInZRAYAJ-8fGMi5aA7TygTavMZ_JEJhzpxz0qIqiQbz7f.75YJsDLvh6zua85e?continueMode=true]
	#
	#
	#
	#*PM NOTE:*
	#
	#After 20Spring.0 Release, a new payment page has been introduced for the backend. With that being said, {color:#ff5630}now enter the "Discount Code" option as part of the ROE page. Not part of the checkout.{color} We will need to test and fix this ticket within the ROE package.
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#1. Open rapid order entry for a contact
	#
	#2. Select any membership item
	#
	#3. Apply a discount code that is not valid
	#
	#*Actual Results:*
	#
	#Page freezes and customer cannot continue
	#
	#*Expected Results:*
	#
	#"Discount Code is not valid" msg displayed to the customer.
	#
	#
	#
	#*T3 Notes:*
	#
	#Not always reproducible, behavior inconsistent.
	#
	#In this recording, the first 2 tries did not hit the issue - processing changes were completed in a few second,s and Payment button re-enabled.
	#
	#From 1:00, once the new source code was entered, it kept processing changes and the Payment button kept being disabled.
	#
	#
	#
	#Estimate
	#
	#QA: 20h
	@REQ_PD-24357 @TEST_PD-27072 @regression @21Winter @22Winter @akash
	Scenario: Test Wrong discount code in rapid order entry results in endless loop
		Given User will select "David Brown" contact
		Then User should be able to select "AutoItem1" and verify the "invalid" discount code at roe
