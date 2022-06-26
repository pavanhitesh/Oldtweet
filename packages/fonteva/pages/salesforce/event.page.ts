/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class EventPage extends WebPage {
  get editBtn() {
    return $('//runtime_platform_actions-action-renderer[@title="Edit"]');
  }

  get editVenuesBtn() {
    return $('[data-label="Venues"]');
  }

  get addVenueBtn() {
    return $('.EventApiEventBuilderVenues>div>.slds-m-bottom--medium>button');
  }

  get venueNameTextField() {
    return $('[data-name="venueName"] > input');
  }

  get primaryVenueCheckbox() {
    return $('[data-name="isPrimaryVenue"] span');
  }

  get saveVenueBtn() {
    return $('[data-name="venueModalSaveButton"]');
  }

  get saveEventAndExitButton() {
    return $('[data-name="Save_Exit_Event_Builder"]');
  }

  get eventSaveActionsDropdownBtn() {
    return $('.slds-float--right [role="group"] span.slds-dropdown--trigger');
  }

  get venueNames() {
    return $$('//th[@data-label="Venue Name"]//a//span');
  }

  get relatedTab() {
    return $('//li[@data-tab-value="relatedListsTab"]');
  }

  async createPrimaryVenue(eventId: string, eventName: string) {
    await super.open(`/lightning/r/EventApi__Event__c/${eventId}/view`);
    await this.click(await this.editBtn);
    await this.click(await this.editVenuesBtn);
    await this.click(await this.addVenueBtn);
    await this.type(await this.venueNameTextField, eventName);
    await this.click(await this.primaryVenueCheckbox);
    await this.click(await this.saveVenueBtn);
    await this.click(await this.eventSaveActionsDropdownBtn);
    await this.click(await this.saveEventAndExitButton);
  }
}

export const eventPage = new EventPage();
