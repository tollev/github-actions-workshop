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

This repository contains a simple go app. You do not need to know go, nor use any golang tooling. We will, unless explicitly specified otherwise, only modify files in the special `.github/` directory.

## Building and testing the code w/jobs and steps

1. We'll start with a simple workflow. Create the file `.github/workflows/build.yml` and with the following content:

    ```yml
    # The "display name", shown in the GitHub UI
    name: Build

    # Trigger, run on push on any branch
    on:
      push:

    jobs:
      build: # The 'build' job
        name: "Build application"
        runs-on: 'ubuntu-latest'
        steps:
          # Step to print a simple message
          - run: echo "Hello world"
    ```

    `.github/workflows` is a special directory where all workflows should be placed.

2. Before committing and pushing, run `actionlint` from the repository root. It should run with a zero (successful) exit code and no output, since the workflow file is without errors. Try again with `actionlint --verbose` and verify the output to confirm that it found your file. By default, `actionlint` scans all files in `.github/workflows/`

3. Commit and push the workflow to your fork. In the GitHub UI, navigate to the "Actions" tab, and verify that it runs successfully.

> [!NOTE] 
> *How does this work?*
> 
> Let's break down the workflow file.
> 
> * `name:` is only used for display in the GitHub UI
> * `on:` specifies triggers - what causes this workflow to be run
> * `jobs:` specifies each _job_ in the workflow. A job run on a single virtual machine with a given OS (here: `ubuntu-latest`), and the `steps` share the environment (filesystem, installed tools, environment variables, etc.). Different jobs have separate environments.
> * `steps:` run sequentially, and might run shell scripts or an action (a reusable, pre-made piece of code). Each step can run conditionally. If a step fails, all later steps fail by default (this is overrideable).


4. Let's use some pre-made actions to checkout our code, and install golang tooling. Replace the "hello world" step with the following steps:

    ```yml
          # Checkout code
          - uses: actions/checkout@v4

          # Install go 1.21
          - name: Setup go
            uses: actions/setup-go@v4
            with: # Specify input variables to the action
              go-version: '1.21.x'

          # Shell script to print the version
          - run: go version
    ```

5. Again, run `actionlint` before you commit and push. Verify that the correct version is printed.

6. TODO: Build and test

7. TODO: Verify build and test

8. TODO: Docker image & registry

Creating workflow:
* Creating a Docker image & pis

Verifying:
* Testing pushing of verify image ends up in Docker registry

## Testing and linting PRs

TODO:
* Build, test & lint for each push to PR
* Require build, tests & linting to succeed to merge PR
* Triggers, how do they work?

## Triggering workflows

Workflows can be triggered in many different ways and can be grouped into four type of events:

* Repository related events
* External events
* Scheduled triggering
* Manual triggering

Repository related events are the most common and are triggered when something happens in the repository. External events and scheduled triggers are not covered in this workshop, but it is nice to know that it is possible. Some example triggers:

```
on: push # Triggers when a push is made to the repository
on: pull_request # Triggers when a pull request is opened
on: workflow_dispatch # Triggers when a user manually requests a workflow to run
```

Some events have filters can be applied to limit when the workflow should run. For example, the `push`-event has a `branches`-filter that can be used limit the workflow to only run if it is on a specific branch (or branches)

```
on:
  push:
    branches:
      - main
      - 'releases/**'  # Wildcard can be used to limit to a specific set of branches
```

1. Update the `build.yml` workflow and add the event for triggering the workflow when a PR is created
2. Create a new branch based on main and create a new PR. Verify that the workflow is run on the PR.
3. Update the `build.yml` workflow and add the event for triggering the workflow manually
4. Go to the [GitHub Actions page of the workflow](https://github.com/bekk/github-actions-workshop/actions/workflows/build.yml) and verify that the workflow can be run manually


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


