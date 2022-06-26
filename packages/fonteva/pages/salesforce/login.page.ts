/* eslint-disable class-methods-use-this */
import yargs from 'yargs';
import { WebPage } from '../../../../globals/web/web.page';

const cliArgs = yargs.argv;

class LoginPage extends WebPage {
  get username() {
    return $('#username');
  }

  get password() {
    return $('#password');
  }

  get logIn() {
    return $('#Login');
  }

  /**
   * a method to encapsule automation code to interact with the page
   * e.g. to login using username and password
   */
  async login() {
    await super.type(await this.username, cliArgs.username as string);
    await super.type(await this.password, cliArgs.password as string);
    await super.click(await this.logIn);
  }

  /**
   * overwrite specifc options to adapt it to page object
   */
  async open(path: string) {
    return super.open(path);
  }
}
export const loginPage = new LoginPage();
