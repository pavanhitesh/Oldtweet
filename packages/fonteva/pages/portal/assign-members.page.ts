/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class AssignMemberPage extends WebPage {
  get AddToCart() {
    return $('//div[@data-name="nextButton"]/button');
  }

  get addMember() {
    return $('//div[@data-name="addMember"]/button');
  }

  get searchMember() {
    return $('//input[@id="searchInput"]');
  }

  get change() {
    return $('//strong[contains(.,"Members Assigned")]//following::div[1]//a');
  }

  get addMemberHeader() {
    return $(`//h2[@data-id='modalTitle' and text()='Add Member']`);
  }

  get addMemberLastName() {
    return $(`//div[@data-name='LastName']/input`);
  }

  get addMemberDone() {
    return $(`//button[@data-name='submitBtn' and @data-label='Done']`);
  }

  async getAssignMembersCount() {
    return super.getElementsCount(await $$('//td[@data-name="Name"]/span'));
  }

  async selectAssignMember(name: string) {
    return super.click(await $(`//tr[contains(., "${name}")]//span[@class="slds-checkbox_faux"]`));
  }

  async assignMemberIsSelected(name: string) {
    await super.waitForPresence(await $(`//tr[contains(., "${name}")]//input`));
    return super.isSelected(await $(`//tr[contains(., "${name}")]//input`));
  }

  async selectAssignmentRole(name: string, role: string) {
    return super.selectByVisibleText(await $(`//tr[contains(., "${name}")]//select`), role);
  }
}

export const assignMemberPage = new AssignMemberPage();
