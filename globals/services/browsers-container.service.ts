/* eslint-disable global-require */
/* eslint-disable import/no-dynamic-require */
import execa from 'execa';
import fs from 'fs-extra';
import path from 'path';
import logger, { Logger } from '@wdio/logger';
import { SevereServiceError } from 'webdriverio';
import { BrowserConfig, ServiceOptions } from 'globals/types';
import root from 'app-root-path';

export class BrowsersContainerService {
  private options: ServiceOptions;

  private log: Logger;

  private dockerSocketPath: string;

  private selenoidBrowsersConfigPath: string;

  constructor(serviceOptions: ServiceOptions) {
    this.options = {
      pathToBrowsersConfig: `${root}/globals/services/browsers.json`,
      skipAutoPullImages: false,
      selenoidContainerName: 'wdio_selenoid',
      terminateWdioOnError: true,
      selenoidVersion: 'latest-release',
      port: 4444,
      selenoidArgs: ['-limit', '1'],

      ...serviceOptions,
    };

    this.log = logger('wdio-selenoid-standalone-service');

    // fix docker paths for windows/*nix
    const { platform } = process;
    if (platform === 'win32') {
      this.dockerSocketPath = '//var/run/docker.sock';
      // const rawBrowserPath = path.join(process.cwd(), this.options.pathToBrowsersConfig as string);
      const rawBrowserPath = this.options.pathToBrowsersConfig as string;

      this.selenoidBrowsersConfigPath = rawBrowserPath.replace('C', 'c').replace(/\\/g, '/');
    } else {
      this.dockerSocketPath = '/var/run/docker.sock';
      // this.selenoidBrowsersConfigPath = path.join(process.cwd(), this.options.pathToBrowsersConfig as string);
      this.selenoidBrowsersConfigPath = this.options.pathToBrowsersConfig as string;
    }
  }

  async stopSelenoid(): Promise<string> {
    this.log.info('Stopping any running selenoid containers');
    try {
      const { stdout } = await execa('docker', ['rm', '-f', this.options.selenoidContainerName as string]);

      return await Promise.resolve(stdout);
    } catch (error) {
      return Promise.resolve(error as string);
    }
  }

  async startSelenoid(): Promise<string> {
    this.log.info('Starting Selenoid Container');
    const dockerArgs = this.options.dockerArgs || [];
    const selenoidArgs = this.options.selenoidArgs || [];

    const startArgs = [
      'run',
      '-d',
      '--name',
      this.options.selenoidContainerName as string,
      '-p',
      '4444:4444',
      '-v',
      `${this.dockerSocketPath}:/var/run/docker.sock`,
      '-v',
      `${path.dirname(this.selenoidBrowsersConfigPath)}/:/etc/selenoid/:ro`,
      ...dockerArgs,
      `aerokube/selenoid:${this.options.selenoidVersion}`,
      ...selenoidArgs,
    ];

    try {
      const { stdout } = await execa('docker', startArgs);

      return await Promise.resolve(stdout);
    } catch (error) {
      if (this.options.terminateWdioOnError === true) {
        throw new SevereServiceError(`Unable to start selenoid container \n${error}`);
      }

      return Promise.resolve(error as string);
    }
  }

  async verifySelenoidBrowserConfig(): Promise<void> {
    const filePath = await fs.pathExists(this.selenoidBrowsersConfigPath);
    if (!filePath) {
      this.log.error(`Unable to find browsers.json at ${this.selenoidBrowsersConfigPath}`);

      if (this.options.terminateWdioOnError === true) {
        throw new SevereServiceError(`Unable to find browsers.json at ${this.selenoidBrowsersConfigPath}`);
      }
    }

    return Promise.resolve();
  }

  async doesImageExist(imageName: string): Promise<boolean> {
    try {
      this.log.debug(`Checking image ${imageName} exists`);
      const { stdout } = await execa('docker', ['image', 'ls', '-f', `reference=${imageName}`]);
      const results = stdout.split('\n');
      return await Promise.resolve(results.length >= 2);
    } catch (error) {
      this.log.error(error);
      return Promise.resolve(true);
    }
  }

  async pullRequiredBrowserFiles(): Promise<void> {
    try {
      // eslint-disable-next-line @typescript-eslint/no-var-requires
      const selenoidConfig: BrowserConfig = require(this.selenoidBrowsersConfigPath);

      const browserImages: string[] = [];

      // eslint-disable-next-line @typescript-eslint/no-unused-vars
      Object.entries(selenoidConfig).forEach(([_browserName, browserConfig]) => {
        // eslint-disable-next-line @typescript-eslint/no-unused-vars
        Object.entries(browserConfig.versions).forEach(([_version, versionConfig]) => {
          browserImages.push(versionConfig.image);
        });
      });

      // eslint-disable-next-line no-restricted-syntax
      for (const image of browserImages) {
        // eslint-disable-next-line no-await-in-loop
        if (await this.doesImageExist(image)) {
          this.log.info(`Skipping pull. Image: ${image} already exists`);
        } else {
          this.log.info(`Pulling image ${image}`);
          // eslint-disable-next-line no-await-in-loop
          await execa('docker', ['pull', image]);
        }
      }
    } catch (error) {
      this.log.error(error);
    }

    return Promise.resolve();
  }

  async pullRequiredSelenoidVersion(): Promise<void> {
    const image = `aerokube/selenoid:${this.options.selenoidVersion as string}`;

    if (await this.doesImageExist(image)) {
      this.log.info(`Sipping pull.  Image ${image} already exists`);
    } else {
      try {
        this.log.info(`Pulling selenoid image 'aerokube/selenoid:${this.options.selenoidVersion}'`);
        await execa('docker', ['pull', `aerokube/selenoid:${this.options.selenoidVersion}`]);
      } catch (error) {
        this.log.error(error);
      }
    }

    return Promise.resolve();
  }

  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  async onPrepare(_config: unknown, _capabilities: unknown): Promise<string> {
    // kill existing selenoid if running
    await this.stopSelenoid();

    // check browsers file
    await this.verifySelenoidBrowserConfig();

    if (!this.options.skipAutoPullImages) {
      // pull any containers listed in the browsers.json
      await this.pullRequiredBrowserFiles();

      // pull selenoid if needed
      await this.pullRequiredSelenoidVersion();
    }

    // run container
    return this.startSelenoid();
  }

  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  async onComplete(_exitCode: number, _config: unknown, _capabilities: unknown): Promise<string> {
    return this.stopSelenoid();
  }
}
