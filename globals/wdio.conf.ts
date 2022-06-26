import root from 'app-root-path';

import { MilliSeconds } from './enums/milliseconds.enum';

export const config: WebdriverIO.Config = {
  // WebDriver Configs
  // path: '/wd/hub',
  // connectionRetryTimeout: 120000,
  // connectionRetryCount: 3,
  logLevel: 'debug',
  outputDir: `${root}/packages/${process.env.TEAM}/tmp/wdlogs/`,

  // WebDriverIO Configs
  automationProtocol: 'webdriver',
  baseUrl: undefined,
  waitforTimeout: MilliSeconds.XXL,
  waitforInterval: MilliSeconds.XXS,

  // TestRunner Configs
  // TODO:target for specific spec file
  specs: [`${root}/packages/${process.env.TEAM}/e2e/features/**/*.feature`],
  exclude: [],
  suites: {},
  capabilities: [],
  maxInstances: 1,
  maxInstancesPerCapability: 1,
  bail: 0,
  services: [],
  framework: 'cucumber',
  cucumberOpts: {
    backtrace: false,
    requireModule: [],
    failAmbiguousDefinitions: true, // wdio specific
    failFast: false,
    dryRun: false,
    format: ['pretty'],
    ignoreUndefinedDefinitions: false, // wdio specific
    name: [],
    profile: [],
    require: [`${root}/packages/${process.env.TEAM}/e2e/**/*.steps.ts`],
    snippetSyntax: undefined,
    snippets: true,
    source: false,
    strict: true,
    tagsInTitle: false,
    retry: 0,
    retryTagFilter: '',
    tagExpression: '',
    timeout: (process.env.DEBUG_TIME_OUT as unknown as number) || 5 * MilliSeconds.XXL,
    scenarioLevelReporter: false,
    order: 'defined',
  },
  reporters: [
    'spec',
    [
      'cucumberjs-json',
      {
        jsonFolder: `${root}/packages/${process.env.TEAM}/tmp/reports`,
        language: 'en',
      },
    ],
  ],

  autoCompileOpts: {
    autoCompile: true,
    tsNodeOpts: {
      transpileOnly: true,
      project: `${root}/tsconfig.json`,
    },
  },
};
