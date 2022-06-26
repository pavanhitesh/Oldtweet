import env from 'dotenv-safe';

import merge from 'deepmerge';

import { config as baseConfig } from '../wdio.conf';

env.config();

export const config: WebdriverIO.Config = merge(baseConfig, {
  path: '/wd/hub',
  // =====================
  // Services  Configuration
  // =====================
  user: process.env.BROWSERSTACK_USERNAME,
  key: process.env.BROWSERSTACK_ACCESS_KEY,
  services: [
    [
      'browserstack',
      {
        browserstackLocal: false,
      },
    ],
    ['shared-store'],
  ],
});
