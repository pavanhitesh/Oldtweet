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

## Install @tweet

To install @tweet/fonteva, follow these steps:

Linux, macOS and Windows:

- update the git config

```
# for Mac/Linux
$ git config --global core.autocrlf input 👈🏽

# for Windows
$ git config --global core.autocrlf true 👈🏽

```

- clone the monorepo. this will not download the content

```
$ git clone --no-checkout git@gitlab.com:togetherwork/automation/tweet.git 👈🏽

```

- initialize the sparse checkout

```
$ git sparse-checkout init --cone 👈🏽

```

- downloads the root files

```
$ git checkout master 👈🏽

```

- downloads the working module

```
$ git sparse-checkout set packages/fonteva .husky .vscode globals 👈🏽

```

- checkout to your feature/local branch

```
$ git checkout -b <local_branch_name> 👈🏽

```

- configure the dependencies

```
$ npm run setup 👈🏽

```

- run the lint check

```
$ npm run lint 👈🏽

```

- make sure the setup is successful

```
$ npm run hello 👈🏽

```

## Using @tweet

To use @tweet/fonteva, follow these steps:

- run an e2e automation test which is tagged with `@smoke`

```
npx lerna run --scope="@tweet/fonteva" bdd:web:local:chrome -- -- --cucumberOpts.tagExpression="""@123""" --url="org_url" --username="org_username" --password="org_password"

```

- Import feature file from xray to tweet framework

```
./packages/fonteva/import_tests_from_xray.sh

```
- Export feature file from tweet framework to xray

```
./packages/fonteva/export_tests_to_xray.sh

```
- Export results from tweet framework to xray

```
./packages/fonteva/export_results_to_xray.sh

```

- Gherkin Defination

```
Always starts with user should

Use Then user should be able to ( where you check acceptance criteria )

eg:

        Given User should login to salesforce org
        And User navigate to LT "Portal" page with "david@mailinator.com" user and password "705Fonteva" as "authenticated User"
        And User should select AutoItem1 from the store
        And User should add the AutoItem1 to the cart
        Then User should be able to checkout AutoItem1 using credit card
	
```

- to add dependency (example)

```
# if you are on windows powershell
$ Set-ExecutionPolicy -Scope CurrentUser RemoteSigned 👈🏽

```

```
$ npx lerna exec --scope="@tweet/fonteva" -- 'npm install axios -D && npm run bootstrap' 👈🏽

```

- to remove dependency (example)

```
$ npx lerna exec --scope="@tweet/fonteva" -- 'npm uninstall axios -D && npm run bootstrap' 👈🏽

```

- clean up your project [OPTIONAL]

```
$ npm run clean 👈🏽

```

- to commit your work or changes

```
$ git add .
$ git commit -am 'test(fonteva): provide a short summary about your changes' 👈🏽

EXAMPLE: git commit -am "test(fonteva): added new test for JIRA-12345"

```

- push you work/changes to remote branch

```
$ git push -u origin <remote_branch_name> 👈🏽

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
| BDD |  ✅   | Cucumber  |

### Features(epics) Execution Mode

> Features will run in series since we use one wdio instance.
> In `CICD`, Features can schedule to run in parallel

|          | Features | Framework |
| :------- | :------: | :-------: |
| Series   |    ✅    | Cucumber  |
| Parallel |   ❗️    | Cucumber  |

### Scenarios(stories) Execution Mode

> With in a feature, Scenarios will run in series.

|          | Scenarios | Framework |
| :------- | :-------: | :-------: |
| Series   |    ✅     | Cucumber  |
| Parallel |    ❌     | Cucumber  |

### Local reporting format

> `Spec` & `json` style of report will be shown per feature.

|      | Features | Scenarios | Framework |
| :--- | :------: | :-------: | :-------: |
| Json |    ✅    |    ✅     | Cucumber  |
| Spec |    ✅    |    ✅     | Cucumber  |

### Browser Automation

|         | Local | Container | BrowserStack |
| :------ | :---: | :-------: | :----------: |
| Chrome  |  ✅   |    ✅     |      ✅      |
| Firefox |  ✅   |    ✅     |      ✅      |
| Edge    |  ✅   |    ✅     |      ✅      |
| Safari  |  ✅   |    ❗️    |      ✅      |

### Mobile Automation

|                | Si(E)mulator | BrowserStack |
| :------------- | :----------: | :----------: |
| iOS Native     |      ❌      |      ❌      |
| iOS Hybrid     |      ❌      |      ❌      |
| iOS Safari     |      ❌      |      ❌      |
| Android Native |      ❌      |      ❌      |
| Android Hybrid |      ❌      |      ❌      |
| Android Chrome |      ❌      |      ❌      |

### API Automation

|     | Rest | GraphQL | Framework |
| :-- | :--: | :-----: | :-------: |
| API |  ✅  |   ✅    | SuperTest |

### Static & Build Checks

|                   | Status | Framework    |
| :---------------- | :----: | :----------- |
| Gherkin Lint      |   ✅   | Gherkin-Lint |
| Code Lint         |   ✅   | ESLint       |
| Code Commit Lint  |   ✅   | CommitLint   |
| Code Formatter    |   ✅   | Prettier     |
| Code Type Checked |   ✅   | TypeScript   |

## Roadmap

- Dockerizing the individual teams automation
- CICD integration
- State management
- E2E report dashboard

## Contact

If you want to learn more or questions ? send a note to <smunukuntla@togetherwork.com>

## License

This project uses the following license: UNLICENSE (internal).
