@REQ_PD-28883
Feature: When the membership item has Badge Workflow that time when we try to purchase an item with a different price rule then it is reverting it back to the default price rule.
	#h2. Details
	#We have configured a 3-year termed subscription plan and a price rule linked to that subscription plan. When selecting the item in the store, we see the option to pick the 3-year plan and it displays the right 3-year price, but when we progress past the recommended items step and click Add to Cart, it reverts to the default price when there is badge workflow on the subscription item.
	#h2. Steps to Reproduce
	#GCO org id: 00D5Y000001NF95
	#
	#1)Create a subscription item.
	#2) Create a two subscription plan
	#3) One subscription plan for one year and other for three years.
	#4) Create a price rule for three years plan 
	#5) Add Badge workflow for the item.
	#6) Login to the community and try to purchases the item
	#7) Select the three year plan
	#8) It displays three-year plan but when you add it to the cart then it revert the price to default price.
	#
	#Recording link: https://fonteva.zoom.us/rec/share/7bN8qZegNV1e0bAH1HGtTJ1qSy9UpDjUbtHb4KggMZwBcCGFKMrUkX7nacrZH77w.8jo7_CA2HQgxZX-O
	#h2. Expected Results
	#It should not change the price to the default price.
	#h2. Actual Results
	#It is reverting the price to the default price.
	#h2. Business Justification
	#ASHG board requested an option to sell 3 year memberships and we keep hitting snags where Fonteva functionality doesn't work as expected or doesn't allow for 3 year memberships

	#Tests h2. Details
	#We have configured a 3-year termed subscription plan and a price rule linked to that subscription plan. When selecting the item in the store, we see the option to pick the 3-year plan and it displays the right 3-year price, but when we progress past the recommended items step and click Add to Cart, it reverts to the default price when there is badge workflow on the subscription item.
	#h2. Steps to Reproduce
	#GCO org id: 00D5Y000001NF95
	#
	#1)Create a subscription item.
	#2) Create a two subscription plan
	#3) One subscription plan for one year and other for three years.
	#4) Create a price rule for three years plan 
	#5) Add Badge workflow for the item.
	#6) Login to the community and try to purchases the item
	#7) Select the three year plan
	#8) It displays three-year plan but when you add it to the cart then it revert the price to default price.
	#
	#Recording link: https://fonteva.zoom.us/rec/share/7bN8qZegNV1e0bAH1HGtTJ1qSy9UpDjUbtHb4KggMZwBcCGFKMrUkX7nacrZH77w.8jo7_CA2HQgxZX-O
	#h2. Expected Results
	#It should not change the price to the default price.
	#h2. Actual Results
	#It is reverting the price to the default price.
	#h2. Business Justification
	#ASHG board requested an option to sell 3 year memberships and we keep hitting snags where Fonteva functionality doesn't work as expected or doesn't allow for 3 year memberships
	@TEST_PD-29644 @REQ_PD-28883 @21Winter @22Winter @regression @Pavan
	Scenario: Test When the membership item has Badge Workflow that time when we try to purchase an item with a different price rule then it is reverting it back to the default price rule.
		Given User navigate to community Portal page with "cdulce@mailinator.com" user and password "705Fonteva" as "authenticated" user
		When User should be able to select "AutoThreeYearSubscriptionItem" item with subscription plan "ThreeYearTermPlan" on store
		And User should click on the checkout button
		Then User verifies total amount due is displayed with "ThreeYearDiscount" price rule for item "AutoThreeYearSubscriptionItem"
		

