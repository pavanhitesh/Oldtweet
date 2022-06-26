@REQ_PD-22504
Feature: Quantity Checkbox editable for membership item on checkout
    #*Reproduced by* Erich Ehinger in 19.1.0.16
    #
    #*Reference Case#*[00021151|https://fonteva.my.salesforce.com/5003A00000zbou1QAA]
    #
    #*Description:*
    #
    #Quantity Checkbox editable for membership item on CPBase checkout
    #
    #
    #
    #*PM NOTE*
    #
    #The issue is reported against CPBASE Checkout. Since it is marked as major we will not attempt a fix on CPBASE Portal. We only fix blocker issues for CPBASE Portal We will validate this issue against the LT Portal.
    #
    #If it is already working as expected please mark it as ready to test, so QA can validate.
    #
    #First, try with merchandise item, so you can see where is the quantity picker is located and then try buying memberhsip item
    #
    #
    #
    #*Steps to Reproduce:*
    #
    #* Make sure you have a membership item (Item.Is_Subscription= true) and it is published to the community via catalog.
    #* Find a community user
    #* Log in as a Community user
    #* Go to the store and find the subscription item add to your cart
    #* Look at quantity box for membership item in shopping cart section
    #
    #
    #
    #*Actual Results:*
    #
    #Quantity is editable
    #
    #*Expected Results:*
    #
    #For the subscription items, the user should not be able to update the quantity.
    #
    #Validate the following pages: None of the pages should let user to edit quantity for subscription items
    #
    #* Item Detail Page (Where user click add to cart)
    #* Shopping Cart Page (the page before checkout)
    #* Checkout Page

    #Tests *Reproduced by* Erich Ehinger in 19.1.0.16
    #
    #*Reference Case#*[00021151|https://fonteva.my.salesforce.com/5003A00000zbou1QAA]
    #
    #*Description:*
    #
    #Quantity Checkbox editable for membership item on CPBase checkout
    #
    #
    #
    #*PM NOTE*
    #
    #The issue is reported against CPBASE Checkout. Since it is marked as major we will not attempt a fix on CPBASE Portal. We only fix blocker issues for CPBASE Portal We will validate this issue against the LT Portal.
    #
    #If it is already working as expected please mark it as ready to test, so QA can validate.
    #
    #First, try with merchandise item, so you can see where is the quantity picker is located and then try buying memberhsip item
    #
    #
    #
    #*Steps to Reproduce:*
    #
    #* Make sure you have a membership item (Item.Is_Subscription= true) and it is published to the community via catalog.
    #* Find a community user
    #* Log in as a Community user
    #* Go to the store and find the subscription item add to your cart
    #* Look at quantity box for membership item in shopping cart section
    #
    #
    #
    #*Actual Results:*
    #
    #Quantity is editable
    #
    #*Expected Results:*
    #
    #For the subscription items, the user should not be able to update the quantity.
    #
    #Validate the following pages: None of the pages should let user to edit quantity for subscription items
    #
    #* Item Detail Page (Where user click add to cart)
    #* Shopping Cart Page (the page before checkout)
    #* Checkout Page
 @REQ_PD-22504 @TEST_PD-27608 @regression @21Winter @22Winter @svinjamuri
 Scenario:  Test Quantity Checkbox editable for membership item on checkout
  Given User will select "Etta Brown" contact
  When User navigate to community Portal page with "ettabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
  And User will select the "Store" menu in LT Portal
  And User select an item "AutoTermedPlan" from the store
  Then User should not be able to edit the quantity
  When User clicks on add to order button from store and add to cart button in item details page
  Then User verifies Quantity is 1
