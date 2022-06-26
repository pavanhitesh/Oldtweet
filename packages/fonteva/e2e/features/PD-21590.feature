@REQ_PD-21590
Feature: Recalculate price of item in cart after logging in
	#In the online store, if an unauthenticated user logs in AFTER putting an item in the cart, the price rule logic isn't re-evaluated if the next step the now authenticated user takes is to click on 'View Cart'. The price rule logic is only re-evaluated when the now authenticated user clicks on 'Checkout'.
	#
	#Since the now authenticated user may select the 'View Cart' option in order to verify that the price was updated as expected before moving forward with the purchase, this is not the desired behavior. The user may stop at this step because it appears there is an issue and not move forward with the purchase.
	#
	#*Steps to reproduce:*
	#
	#1. As an unauthenticated user, go to the online store.
	#
	#2. Select an item that has different pricing for members and non-members and select 'Add to Order'.
	#
	#3. Click on 'View Cart'. Notice the non-member price of the item in the cart.
	#
	#4. Click on 'Login' and enter the credentials of a member.
	#
	#5. Click on the shopping cart icon and select the option 'View Cart'. Notice the non-member price of the item in the cart.
	#
	#6. Click on 'Checkout'. Notice that the item now reflects the member price.
	#
	#
	#
	#*Actual Result*
	#
	#Shopping cart page displays the non-member price. See attached video
	#
	#
	#
	#*Expected Result*
	#
	#Shopping Cart page displays the member price when the user logs in as an authenticated user
	#
	#
	#
	#*Environment*
	#
	#login URL: [http://test.salesforce.com|http://test.salesforce.com|smart-link] 
	#
	#Username: [sm21winternmc@fondash.io.sb|mailto:sm21winternmc@fondash.io.sb]
	#
	#Password Fonteva703
	#
	#Item URL: [https://sb-autotest02-1676522309d-168b9-176d9de8f58.cs190.force.com/lt/s/store#/store/browse/detail/a184x000001HfO8AAK|https://sb-autotest02-1676522309d-168b9-176d9de8f58.cs190.force.com/lt/s/store#/store/browse/detail/a184x000001HfO8AAK|smart-link] 
	#
	#
	#
	#*PM Note:*
	#
	#Scope of bug: show up-to-date prices on Shopping Cart page. Cart drop-down might still be out-of-date.

	#Tests In the online store, if an unauthenticated user logs in AFTER putting an item in the cart, the price rule logic isn't re-evaluated if the next step the now authenticated user takes is to click on 'View Cart'. The price rule logic is only re-evaluated when the now authenticated user clicks on 'Checkout'.
	#
	#Since the now authenticated user may select the 'View Cart' option in order to verify that the price was updated as expected before moving forward with the purchase, this is not the desired behavior. The user may stop at this step because it appears there is an issue and not move forward with the purchase.
	#
	#*Steps to reproduce:*
	#
	#1. As an unauthenticated user, go to the online store.
	#
	#2. Select an item that has different pricing for members and non-members and select 'Add to Order'.
	#
	#3. Click on 'View Cart'. Notice the non-member price of the item in the cart.
	#
	#4. Click on 'Login' and enter the credentials of a member.
	#
	#5. Click on the shopping cart icon and select the option 'View Cart'. Notice the non-member price of the item in the cart.
	#
	#6. Click on 'Checkout'. Notice that the item now reflects the member price.
	#
	#
	#
	#*Actual Result*
	#
	#Shopping cart page displays the non-member price. See attached video
	#
	#
	#
	#*Expected Result*
	#
	#Shopping Cart page displays the member price when the user logs in as an authenticated user
	#
	#
	#
	#*Environment*
	#
	#login URL: [http://test.salesforce.com|http://test.salesforce.com|smart-link] 
	#
	#Username: [sm21winternmc@fondash.io.sb|mailto:sm21winternmc@fondash.io.sb]
	#
	#Password Fonteva703
	#
	#Item URL: [https://sb-autotest02-1676522309d-168b9-176d9de8f58.cs190.force.com/lt/s/store#/store/browse/detail/a184x000001HfO8AAK|https://sb-autotest02-1676522309d-168b9-176d9de8f58.cs190.force.com/lt/s/store#/store/browse/detail/a184x000001HfO8AAK|smart-link] 
	#
	#
	#
	#*PM Note:*
	#
	#Scope of bug: show up-to-date prices on Shopping Cart page. Cart drop-down might still be out-of-date.
	@TEST_PD-29130 @REQ_PD-21590 @21Winter @22Winter @Pavan @regression
	Scenario: Test Recalculate price of item in cart after logging in
		Given User navigate to community Portal page 
		And User should be able to select "FontevaPens" item with quantity "1" on store
		When User navigates to view cart page
		And User verifies total amount due is displayed with "DEFAULT" price rule for item "FontevaPens"
		And User navigate to community Portal page with "cdulce@mailinator.com" user and password "705Fonteva" as "authenticated" user
		Then User navigates to view cart page
		And User verifies total amount due is displayed with "discountPriceRule" price rule for item "FontevaPens"

