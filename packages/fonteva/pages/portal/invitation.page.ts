/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class InvitationPage extends WebPage {
  get navbarAccept() {
    return $('//button[@data-name="acceptInvite"]');
  }

  get navbarDecline() {
    return $('//button[@data-name="declineInvite"]');
  }

  get accept() {
    return $('//button[@name="acceptInviteButton"]');
  }

  get decline() {
    return $('//button[@name="declineInviteButton"]');
  }
}

export const invitationPage = new InvitationPage();
