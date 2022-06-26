export interface ServiceOptions {
  pathToBrowsersConfig?: string;
  skipAutoPullImages?: boolean;
  selenoidContainerName?: string;
  terminateWdioOnError?: boolean;
  selenoidVersion?: string;
  port?: number;
  dockerArgs?: string[];
  selenoidArgs?: string[];
}

export interface BrowserConfig {
  [browser: string]: {
    default: string;
    versions: {
      [version: string]: {
        image: string;
        port: number;
        path: string;
      };
    };
  };
}

export interface BrowserSize {
  width: number;
  height: number;
}
