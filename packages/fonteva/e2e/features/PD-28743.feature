@REQ_PD-28743
Feature: 21 Winter: Unable to add/edit/delete an multi-entry form
	#h2. Details
	#Unable to add Multi entry in Community Form Page
	#h2. Steps to Reproduce
	#Version: 21Winter.0.10
	#GCO Organization ID : 00D4L000000jPqa
	#1. Navigate to contact and click 'Log in to Experience as User'
	#2. Access form with URL : https://master-fto-179ed270c03-17a58d2d5de.force.com/s/multiple-entry-form?id=a0U4L00000066UX
	#3. Click New Entry and fill the form
	#4. Click Submit button
	#
	#Recording: https://fonteva.zoom.us/rec/share/lWXFoz5y4vtIaDjdihB1GDny4D3pAcJ_sgL_HFipXrFf_9Qzf7dfNSY_5kz5P4TM.ezryVL4Eb5IypjW0
	#
	#Note :
	#1) Form Config Screenshot Attached
	#2) https://docs.fonteva.com/user/Community-Form-Page.1537245238.html
	#h2. Expected Results
	#Details should get saved
	#h2. Actual Results
	#Screen freezes with spinning loader
	#h2. Business Justification
	#Unable to add Multi entry in Community Form Page

	#Tests h2. Details
	#Unable to add Multi entry in Community Form Page
	#h2. Steps to Reproduce
	#Version: 21Winter.0.10
	#GCO Organization ID : 00D4L000000jPqa
	#1. Navigate to contact and click 'Log in to Experience as User'
	#2. Access form with URL : https://master-fto-179ed270c03-17a58d2d5de.force.com/s/multiple-entry-form?id=a0U4L00000066UX
	#3. Click New Entry and fill the form
	#4. Click Submit button
	#
	#Recording: https://fonteva.zoom.us/rec/share/lWXFoz5y4vtIaDjdihB1GDny4D3pAcJ_sgL_HFipXrFf_9Qzf7dfNSY_5kz5P4TM.ezryVL4Eb5IypjW0
	#
	#Note :
	#1) Form Config Screenshot Attached
	#2) https://docs.fonteva.com/user/Community-Form-Page.1537245238.html
	#h2. Expected Results
	#Details should get saved
	#h2. Actual Results
	#Screen freezes with spinning loader
	#h2. Business Justification
	#Unable to add Multi entry in Community Form Page
 @TEST_PD-28932 @REQ_PD-28743 @21Winter @22Winter @alex
 Scenario: Test 21 Winter: Unable to add/edit/delete an multi-entry form
  Given User navigate to community Portal page with "larkinherbert@mailinator.com" user and password "705Fonteva" as "authenticated" user
  And User fill multi-entry form page
