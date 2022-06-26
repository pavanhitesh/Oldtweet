/* eslint-disable class-methods-use-this */
export class BaseScreen {
  async hideKeyboard() {
    await browser.hideKeyboard();
  }
}
