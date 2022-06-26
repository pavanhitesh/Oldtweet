@REQ_PD-28281
Feature: In Cart Pricing not updated when membership item is removed from the cart

# Details
# In LT community, a customer has the following items in their cart - Membership item plus a product with member pricing - and then removes the membership item, the price of the other item is not updated to reflect non-member pricing

# GCO credentials: jyu303asc8@fondash.io / P@ssword1

# Go to 

# Lightning Member Portal 

# Add Fon-Baseball Hatto the cart

# Go to Fon-Memberships and add Professional membership to the cart

# Add state chapter membership and click on View cart

# Baseball cap is updated to Member pricing which is $23

# Remove Professional membership from cart

# Steps to Reproduce
# (Tested in 21Winter.0.9)

# Create membership item A, and create a badge workflow for this membership item with Badge Type A. Type = Line Contact 

# Create item B and create a discounted Price Rule that is using the above Badge Type A 

# Add both Item A and Item B into Store Category(so that it shows up on LT portal)

# Choose a Contact that does not have Badge Type A

# Log in into LT Portal and add Item A first, then add Item B

# On the checkout page Item B should be showing discounted Price Rule at this moment

# Now go back to shopping cart and delete the Item A (that is granting the badge)

# Note the price for Item B is not reverting to default Price Rule

# EXPECTED RESULTS

# In LT Portal, after deleting the Item A that is granting badge, there should no longer be any in-cart pricing displayed for Item B

# ACTUAL RESULTS

# In LT Portal, after deleting the Item A that is granting badge, Item B is still showing discounted Price Rule (which should no longer apply)

# BUSINESS JUSTIFICATION

# Go live blocker, go live date is 9/13


# System Impact
# None

 @TEST_PD-28747 @REQ_PD-28281 @regression @21Winter @21Summer @jake
	Scenario: In-cart pricing not working in front end store
		Given User navigate to community Portal page with "maxfoxworth@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User should be able to select "AutoBadgeItem" item with quantity "1" on store
		And User should be able to select "AutoBadgePRItem" item with quantity "1" on store
		And User should be able to remove "AutoBadgeItem" item with quantity "1" on store
		And User should be able to verify in cart pricing for removed badge is reflected on the sales order where contact is "Max Foxworth" for "AutoBadgePRItem" item
