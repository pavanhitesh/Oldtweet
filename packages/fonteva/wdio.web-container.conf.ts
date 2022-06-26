import merge from 'deepmerge';
import yargs from 'yargs';
import { connectJsforce } from './shared/helpers/force.helper';
import { config as containerConfig } from '../../globals/web/wdio.web-container.conf';
import { WebPage } from '../../globals/web/web.page';

const cliArgs = yargs.argv;
const webPage = new WebPage();

export const config: WebdriverIO.Config = merge(containerConfig, {
  baseUrl: yargs.argv.url,
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
