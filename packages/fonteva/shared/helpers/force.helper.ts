/* eslint-disable no-console */
import { Connection } from 'jsforce';
import yargs from 'yargs';
import { FontevaSchema } from '../../fonteva-schema';

const cliArgs = yargs.argv;
export const conn = new Connection<FontevaSchema>({ loginUrl: `${cliArgs.url}` });

export const connectJsforce = async (username: string, password: string) => {
  await conn.login(username, password);
  browser.sharedStore.set('organizationId', conn.userInfo?.organizationId as string);
};
