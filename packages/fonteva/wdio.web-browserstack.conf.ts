import merge from 'deepmerge';

// import env from 'dotenv-safe';

// import root from 'app-root-path';
import { config as browserStackConfig } from '../../globals/web/wdio.web-browserstack.conf';

// env.config({
//   example: `${root}/.env.example`,
// });

export const config: WebdriverIO.Config = merge(browserStackConfig, {
  baseUrl: 'https://login.salesforce.com',
  // ============
  // Capabilities
  // ============
  capabilities: [
    {
      browserName: process.env.BROWSER,
      'bstack:options': {
        buildName: process.env.TEAM,
        os: 'OS X',
        osVersion: 'Big Sur',
        projectName: process.env.TEAM,
        local: false,
        debug: true,
        networkLogs: true,
        browserVersion: 'latest',
      },
    },
  ],
});
