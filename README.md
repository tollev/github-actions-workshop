# GitHub Actions workshop

## Requirements

* A GitHub account, with a functioning SSH-key or password setup
* Available GitHub action minutes and storage space (included in free tier)

The tasks in the workshop can be done using only the built-in GitHub editor. However, in order to learn about supporting tooling, and simplify some tasks, the workshop will assume you've installed the following tools:

* Your preferred terminal emulator/shell and `git`
* The [GitHub CLI](https://github.com/cli/cli#installation)
* [actionlint](https://github.com/rhysd/actionlint/blob/main/docs/install.md)
* [ShellCheck](https://github.com/koalaman/shellcheck?tab=readme-ov-file#installing) (will be used by actionlint)
* Editor with YAML and GitHub actions plugins (e.g., VS Code with the [YAML](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml) and [GitHub Actions](https://marketplace.visualstudio.com/items?itemName=github.vscode-github-actions) exensions)


## Getting started

TODO: Likely `gh repo fork --clone` or using the GitHub UI to fork the repo to a personal account

## Building and testing the code w/jobs and steps

Recommendation: Use `actionlint` to shorten feedback loops

Creating workflow:
* Build and test for push
* Creating a Docker image & pis
* Reference: https://docs.github.com/en/actions/automating-builds-and-tests/building-and-testing-go

Verifying:
* Testing failing builds and tests
* Testing pushing of verify image ends up in Docker registry

## Testing and linting PRs

TODO:
* Build, test & lint for each push to PR
* Require build, tests & linting to succeed to merge PR
* Triggers, how do they work?

## Manually triggering workflows

TODO:
* `on: workflow_dispatch`, run a job on a given branch

* Limitations: Re-deploying a previous build, dynamically getting tags/sha

## Reusable workflows

TODO:
* Create reusable workflow for running tests - replace jobs on PR and main pushes, use workflow_call
* Create reusable workflow for build, with option to create and push docker image

## Deploying to environment

TODO:
* "Fake deploy" to save time, print name of image to be deployed
* Add environments test, prod in GitHub UI
* Prod should be protected using branch protection rules or rulesets
* Deploying

## Extra: Environment variables and secrets

TODO: Need a use case

## Extra: Reusable composite actions

* Create reusable composite actions for build, use as part of jobs on PR and main pushes


