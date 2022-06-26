@REQ_PD-27889
Feature: Item SKU is cleared when capacity changes on ticket
	@TEST_PD-29189 @22Winter @21Winter @REQ_PD-27889 @raj @regression
	Scenario: Test Item SKU is cleared when capacity changes on ticket
		Given User updates the SKU field on the item for "GeneralTicket" ticket of event "AutoEvent4"
		And User updates the "GeneralTicket" ticket capacity for event "AutoEvent4"
		Then User verifies the SKU field is not empty on the ticket item
