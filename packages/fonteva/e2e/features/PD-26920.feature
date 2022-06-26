@REQ_PD-26920
Feature: Price Rules not populating on receipt lines
 @REQ_PD-26920 @TEST_PD-27109 @regression @21Winter @22Winter @raj
 Scenario: Test Price Rules not populating on receipt lines
  Given User will select "David Brown" contact
  And User opens the Rapid Order Entry page from contact
  And User should be able to add "AutoItem1" item on rapid order entry
  And User navigate to "apply payment" page for "AutoItem1" item from rapid order entry
  Then User should be able to apply payment for "AutoItem1" item using "Credit Card" payment on apply payment page
  And User should be able to see the price rule on the epayment line
