# @tweet - TogetherWork End-End Test Framework

@tweet is `an e2e test automation framework for Web, Mobile and API's` that allows `engineers` to build `automation with BDD style using Cucumber`.

The project is designed as a monorepo with modular architecture to scale the quality and business requirments at enterprise level.

[[_TOC_]]

## Pre-requisites

Before you begin, ensure you have met the following requirements:

<!--- These are just example requirements. Add, duplicate or remove as required --->

- You should have a `Windows/Linux/Mac` machine
- Install the latest (stable) version of `JRE (Java Runtime Environment)`
- Install the latest (stable) version of `Node (JavaScript Runtime Environment)`
- Install the latest (stable) version of `Volta.sh`
- Install the latest (stable) version of git
<!-- Below is mandatory and specific to windows machine to make smooth flow of Xray and VSCode integration-->
- Install 7Zip utility and Add the location to your PATH environment variable. ex: (`C:\Program Files\7-Zip`)

## Install @tweet

To install @tweet/<your_team_name>, follow these steps:

Linux, macOS and Windows:

- update the git config

```
# for Mac/Linux
$ git config --global core.autocrlf input ðð½

# for Windows
$ git config --global core.autocrlf true ðð½

```

- clone the monorepo. this will not download the content

```
$ git clone --no-checkout git@gitlab.com:togetherwork/automation/tweet.git ðð½

```

- initialize the sparse checkout

```
$ git sparse-checkout init --cone ðð½

```

- downloads the root files

```
$ git checkout master ðð½

```

- downloads the working module

```
$ git sparse-checkout set packages/<your_team_name> .husky .vscode globals ðð½

```

- checkout to your feature/local branch

```
$ git checkout -b <local_branch_name> ðð½

```

- configure the dependencies

```
$ npm run setup ðð½

```

- run the lint check

```
$ npm run lint ðð½npm 

```

- make sure the setup is successful

```
$ npm run hello ðð½

```

## Using @tweet

To use @tweet/<your_team_name>, follow these steps:

- run an e2e automation test which is tagged with `@smoke`

```
$ npx lerna run --scope="@tweet/<your_team_name>" bdd:web:local:chrome -- -- --cucumberOpts.tagExpression="""@smoke""" --url="<ORGID.my.salesforce.com>" --username="<UserID>" --password="<Password>" ðð½

```
OR

```
$ npx lerna run --scope="@tweet/<your_team_name>" bdd:web:local:chrome -- -- --spec="""some.feature""" --url="<ORGID.my.salesforce.com>" --username="<UserID>" --password="<Password>" ðð½

```

- to add dependency (example)

```
# if you are on windows powershell
$ Set-ExecutionPolicy -Scope CurrentUser RemoteSigned ðð½

```

```
$ npx lerna exec --scope="@tweet/<your_team_name>" -- 'npm install axios -D && npm run bootstrap' ðð½

```

- to remove dependency (example)

```
$ npx lerna exec --scope="@tweet/<your_team_name>" -- 'npm uninstall axios -D && npm run bootstrap' ðð½

```

- clean up your project [OPTIONAL]

```
$ npm run clean ðð½

```

- to commit your work or changes

```
$ git add .
$ git commit -am 'test(<YOUR_TEAM_NAME>): provide a short summary about your changes' ðð½

EXAMPLE: git commit -am "test(fonteva): added new test for JIRA-12345"

```

- push you work/changes to remote branch

```
$ git push -u origin <remote_branch_name> ðð½

```

- create a merge request

## Contributing

Before contributing make sure you're onboarded to the project by one of the teammates. Use the above steps to setup the local development.

Follow the below practices when contributing:

- kebab-case for cucumber tags, folder, and filename
- Feature: Should have some descriptive message about the feature
- Scenario Tags: at the minimum, you should have a Jira ticket number and release version as tags
- Please keep the gherkin Scenarios as declarative rather imperative
- Follow the Gherkin Reference (https://cucumber.io/docs/gherkin/reference/) while writing the steps
- Keep the cucumber scenarios `declarative`. Refer (https://cucumber.io/docs/bdd/better-gherkin/) for examples
- Sensitive information should be read from `.env` file and should not track in git
- Avoid using static and implicit waits
- Step_definitions shouldn't expose native WebdriverIO commands like the browser. PageObject and helpers could be used instead.
- Keep scenarios independent
- Test data setup should be part of the scenarios - use hooks if required
- Limit the usage of locators which traverse multiple nodes.
- Developers should be able to provide unique attribute
- Every step should have at least one checkpoint, and the more, the better as per acceptance criteria
- e2e are flaky by nature hence avoid static waits and have stable and better locators for UI interaction
- Prefer `type-inference` over explicit type assignment for variables, functions as applicable
- Avoid `:any` type. It disables all further type checking
- Custom type definitions goes under `/types` folder
- Prefer generic style declaration like `Array<number>` over `number[]`
- Prefer `Interface` over `Type Alias` for defining object structure
- Prefer combining literals into unions, for example, functions that only accept a certain set of known values `printText(s: string, alignment: "left" | "right" | "center")`

## Tech-Stack

- Node
- TypeScript (Superset of JavaScript)
- Cucumber
- Docker

## Features

---

### Automation Style

> Scope of the `@tweet` is to support only BDD/ATDD style of automation.

|     | Style | Framework |
| :-- | :---: | :-------: |
| BDD |  â   | Cucumber  |

### Features(epics) Execution Mode

> Features will run in series since we use one wdio instance.
> In `CICD`, Features can schedule to run in parallel

|          | Features | Framework |
| :------- | :------: | :-------: |
| Series   |    â    | Cucumber  |
| Parallel |   âï¸    | Cucumber  |

### Scenarios(stories) Execution Mode

> With in a feature, Scenarios will run in series.

|          | Scenarios | Framework |
| :------- | :-------: | :-------: |
| Series   |    â     | Cucumber  |
| Parallel |    â     | Cucumber  |

### Local reporting format

> `Spec` & `json` style of report will be shown per feature.

|      | Features | Scenarios | Framework |
| :--- | :------: | :-------: | :-------: |
| Json |    â    |    â     | Cucumber  |
| Spec |    â    |    â     | Cucumber  |

### Browser Automation

|         | Local | Container | BrowserStack |
| :------ | :---: | :-------: | :----------: |
| Chrome  |  â   |    â     |      â      |
| Firefox |  â   |    â     |      â      |
| Edge    |  â   |    â     |      â      |
| Safari  |  â   |    âï¸    |      â      |

### Mobile Automation

|                | Si(E)mulator | BrowserStack |
| :------------- | :----------: | :----------: |
| iOS Native     |      â      |      â      |
| iOS Hybrid     |      â      |      â      |
| iOS Safari     |      â      |      â      |
| Android Native |      â      |      â      |
| Android Hybrid |      â      |      â      |
| Android Chrome |      â      |      â      |

### API Automation

|     | Rest | GraphQL | Framework |
| :-- | :--: | :-----: | :-------: |
| API |  â  |   â    | SuperTest |

### Static & Build Checks

|                   | Status | Framework    |
| :---------------- | :----: | :----------- |
| Gherkin Lint      |   â   | Gherkin-Lint |
| Code Lint         |   â   | ESLint       |
| Code Commit Lint  |   â   | CommitLint   |
| Code Formatter    |   â   | Prettier     |
| Code Type Checked |   â   | TypeScript   |

## Roadmap

- Dockerizing the individual teams automation
- CICD integration
- State management
- E2E report dashboard

## Contact

If you want to learn more or questions ? send a note to <smunukuntla@togetherwork.com>

## License

This project uses the following license: UNLICENSE (internal).
