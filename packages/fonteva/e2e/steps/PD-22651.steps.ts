import { Given } from '@cucumber/cucumber';
import { profilePage } from '../../pages/portal/profile.page';

Given(
  'User should be able to see {string} formula field with {string} text that links to {string} site',
  async (name: string, urlText: string, urlLink: string) => {
    expect(await profilePage.getText(await profilePage.hyperlink)).toEqual(name);
    expect(await profilePage.getText(await profilePage.hyperlinkUrl)).toEqual(urlText);
    expect(await profilePage.hyperlinkUrl.getAttribute('href')).toEqual(urlLink);
  },
);
