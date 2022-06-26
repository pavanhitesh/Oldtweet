import merge from 'deepmerge';
import yargs from 'yargs';
import { connectJsforce } from './shared/helpers/force.helper';
import { config as localConfig } from '../../globals/web/wdio.web-local.conf';
import { WebPage } from '../../globals/web/web.page';

const cliArgs = yargs.argv;
const webPage = new WebPage();
const drivers = {
  chrome: { version: '98.0.4758.80' }, // https://chromedriver.chromium.org/
};

export const config: WebdriverIO.Config = merge(localConfig, {
  baseUrl: yargs.argv.url,
  // =====================
  // Services  Configuration
  // =====================
  services: [
    [
      'selenium-standalone',
      {
        installArgs: { drivers }, // drivers to install
        args: { drivers }, // drivers to use
      },
    ],
  ],

  // ============
  // Capabilities
  // ============
  capabilities: [
    {
      browserName: process.env.BROWSER,
    },
  ],
  before: async () => {
    await connectJsforce(cliArgs.username as string, cliArgs.password as string);
    await webPage.deleteAllCookies();
    await webPage.maximizeWindowSize();
  },
});
