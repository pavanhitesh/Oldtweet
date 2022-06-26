@REQ_PD-26919
Feature: Red error in ROE when Event ticket is added followed by any other items
  #*Case Reporter* Sunita Kode
  #
  #*Customer* American Academy of Family Physicians
  #
  #*Reproduced by* Aaron Gremillion in 21Winter.0.0
  #
  #*Reference Case#* [00029693|https://fonteva.my.salesforce.com/5004V000014linVQAQ]
  #
  #*Description:*
  #
  #Back-end staff is trying to sell a ticket as well as a secondary item (unrelated) in the same sales order.
  #
  #*Steps to Reproduce:*
  #
  #Steps to reproduce -
  #
  ## Select a contact and navigate to ROE
  ## Add an event ticket to the order (any event ticket).
  ### You need an active event with published ticket type, so ticket type item will show up on the ROE
  ## Next, add any other item
  ### you can use merchandise item like t-shirt
  ## A pink error shows every time an item is added to the cart.
  #
  #*Actual Results:*
  #
  #An error prevents moving towards checkout. "List index out of bounds: 0"
  #
  #(Attachment Added)
  #
  #SOL is successfully added but throwing the following error. adding stack trace here
  #
  #*Expected Results:*
  #
  #ROE should be able to sell multiple items with tickets.
  #
  #No error msg should be shown.
  #
  #*Business Justification:*
  #
  #Causes re-work to be done by users, and poor customer experience when they realize that they've got two charges for 'one' order.
  #
  #*T3 Notes:*
  #
  #SOL is successfully added but throwing following error. adding stack trace here
  #
  #{color:#881391}message{color}: {color:#c41a16}"Error getting Sales Order Line. List index out of bounds: 0"{color}
  #
  #{color:#881391}stackTrace{color}: {color:#c41a16}"Class.{color}{color:#c41a16}*FDSSPR20*{color}{color:#c41a16}.OrderService: line 296, column 1\\nClass.ROEApi.ItemQuickAddController.updateSalesOrderLinesOfSimilarTT: line 351, column 1\\nClass.ROEApi.ItemQuickAddController: line 390, column 1\\nClass.ROEApi.GroupRegistrationDetailsController: line 25, column 1"{color}
  #
  #
  #
  #Estimate
  #
  #QA: 22h

  #Tests *Case Reporter* Sunita Kode
  #
  #*Customer* American Academy of Family Physicians
  #
  #*Reproduced by* Aaron Gremillion in 21Winter.0.0
  #
  #*Reference Case#* [00029693|https://fonteva.my.salesforce.com/5004V000014linVQAQ]
  #
  #*Description:*
  #
  #Back-end staff is trying to sell a ticket as well as a secondary item (unrelated) in the same sales order.
  #
  #*Steps to Reproduce:*
  #
  #Steps to reproduce -
  #
  ## Select a contact and navigate to ROE
  ## Add an event ticket to the order (any event ticket).
  ### You need an active event with published ticket type, so ticket type item will show up on the ROE
  ## Next, add any other item
  ### you can use merchandise item like t-shirt
  ## A pink error shows every time an item is added to the cart.
  #
  #*Actual Results:*
  #
  #An error prevents moving towards checkout. "List index out of bounds: 0"
  #
  #(Attachment Added)
  #
  #SOL is successfully added but throwing the following error. adding stack trace here
  #
  #*Expected Results:*
  #
  #ROE should be able to sell multiple items with tickets.
  #
  #No error msg should be shown.
  #
  #*Business Justification:*
  #
  #Causes re-work to be done by users, and poor customer experience when they realize that they've got two charges for 'one' order.
  #
  #*T3 Notes:*
  #
  #SOL is successfully added but throwing following error. adding stack trace here
  #
  #{color:#881391}message{color}: {color:#c41a16}"Error getting Sales Order Line. List index out of bounds: 0"{color}
  #
  #{color:#881391}stackTrace{color}: {color:#c41a16}"Class.{color}{color:#c41a16}*FDSSPR20*{color}{color:#c41a16}.OrderService: line 296, column 1\\nClass.ROEApi.ItemQuickAddController.updateSalesOrderLinesOfSimilarTT: line 351, column 1\\nClass.ROEApi.ItemQuickAddController: line 390, column 1\\nClass.ROEApi.GroupRegistrationDetailsController: line 25, column 1"{color}
  #
  #
  #
  #Estimate
  #
  #QA: 22h
 @REQ_PD-26919 @TEST_PD-27084 @regression @21Winter @22Winter @ngunda
 Scenario: Test Red error in ROE when Event ticket is added followed by any other items
  When User will select "Mannik Gunda" contact
  And User opens the Rapid Order Entry page from contact
  And User is able to add below items in Rapid order entry page
    | ItemName   |
    | PITicket   |
    | AutoLTItem |
  And User selects Payment type as "Process Payment" and Navigate to Apply payment pages
  Then User select the payment type as "Offline - Check" and completes the Payment successfully
