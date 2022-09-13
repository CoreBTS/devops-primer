# Module 1 - GitHub Actions

This module is designed to faciliate independent study and work towards creating your first GitHub Action ("GHA") Workflow. As part of this effort, you will work in this GitHub repository to add your workflow and configure it deploy the application committed to this repository to Microsoft Azure.

## Module Info

### Expected time to complete

This module is intended to take a team member up to 5 business days to complete (i.e., start on Monday, completed by Friday). Depending on client work and other circumstances, work with course leaders to communicate your scenario and get additional time as needed.

### Expected Takeaway Concepts

As part of completing this module, you should gain a 100 / 200 level understanding of the following concepts:
- Git branches and Pull Requests
- GHA workflow triggers
- GHA workflow jobs
- GHA workflow job steps
- GHA workflow repository secrets
- GHA workflow artifacts
- Build of Java applications using GHA
- How to view the GHA workflow logs


### Completion of the module

At the end of week, the course taker should plan and expect to present their work in an interactive discussion with the course leaders. This presentation is sort of a test, but it is also intended to cement your learning and ensure that the key points from the experience are understood. 

Based on the outcomes of presenting, the course leader(s) and course taker can collaborate on whether additional tasks should be assigned to further growth or if the course taker is ready to move on to the next module. As this course is new, we will see how this goes!

### Pre-requisties

You will need an Azure subscription for this module. In future iterations of this module, a shared Core BTS subscription will be used for collaboration. In the meantime, you may use your MSDN benefit for Azure credits as your workspace. 

You will need to work with the course leaders to configure an Azure Service Principal in this Git repository to authenticate to Azure with your workflow. When ready, work with Alex to configure the appropriate GitHub repository secrets.

In addition to the above, it is suggested to read the top level documents in the "course-material" folder for helpful links, tools and how to get help as you work through the module.

### Git and GitHub

This repository uses branch protections for its `main` branch. This means that you will **not** be able to push your changes to the `main` branch directly. Rather you will need to create a local `feature` branch, push to GitHub and Pull Request ("PR") to incorporate into `main`.

## Setup Azure Resources

For this module, we will setup the Azure resources that we will be deploying to using the Azure Portal. Using the portal, create (at least) the following resources in a single Azure Resource Group:
- App Service Plan
- Web App

Follow the example naming convention provided by Microsoft when creating your Resource Group and resources: https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming#example-names-for-common-azure-resource-types.

The following options should be selected for the Web App:
- Publish = Code
- Runtime stack = Java 17
- Java web server stack = Java SE (Embedded Web Server)
- Operating System = Linux
- Region = East US 2
- Continuous Deployment = Disable

Other settings not listed above are up to the course taker to choose and _should not_ impact the ability to complete the module.

## Create GHA Workflow

*If you have not already, clone this repository to your workstation using git.*

Using the links provided in "helpful-links-and-reference.md" as a starting point, add a **new** GHA workflow to this repository (using the naming convention `module1-<firstname><lastinitial>.yml`).

It is recommended that you start with configuring a `workflow_dispatch` trigger to allow for manual triggers of your workflow in development / testing. To do this - add the appropriate trigger(s) to your file, along with the minimum required for a valid workflow file, and create a Pull Request. 

Once the initial Pull Request reviewed and merged, you can begin updating your workflow to perform the following actions:

1. Builds the Java application found in this repository and publishes the compiled code as a [workflow artifact](https://docs.github.com/en/actions/using-workflows/storing-workflow-data-as-artifacts)
    - **Hint:** The Apache Maven build utility should be used to build the application
2. In a second job in the same workflow, download the artifact from the job above and deploy the code to the Azure Web App created in the previous section

The success of your workflow can be verified by 1. viewing the logs of the GHA workflow and 2. by browsing the Azure Web App at: https://`<azure web app name>`.azurewebsites.net/manage/health

If successful, you should receive the following result:
```
{ "status": "UP" }
```

### Additional Tweaks and Modifications

If the module proves easy, here are additional suggestions to attempt to get more familiar with GHAs, if time permits:

- Add an additional step to run unit tests for the application using Maven
- Add a "staging" slot in the Azure Portal, update your workflow to deploy to the "staging" slot, followed by a swap to the "production" slot
- Add step(s) to print the list of files in the downloaded artifact to the GHA workflow log
- Convert one of the jobs from the workflow to a "Composite Action"