import merge from 'deepmerge';
import { config as baseConfig } from '../wdio.conf';

export const config: WebdriverIO.Config = merge(baseConfig, {
  // =====================
  // Services  Configuration
  // =====================
  services: [['shared-store']],
});
