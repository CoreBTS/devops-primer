# Module 3 - End-to-End Automation (Bringing it all together)

In this module, you will take the skills you've learned with Git, GitHub Actions and Terraform to automate the build and deployment of a web application to two environments, nonprod and prod.  You will be able to re-use a large portion of the code written in the previous modules, the focus here is to ensure the code is deployable across multiple environments with only changes to the environment tfvars files, along with a full automation of the deployment process for both infrastructure and web application code. 

## Module Info

### Expected time to complete

This module is intended to take a team member up to 5 business days to complete (i.e., start on Monday, completed by Friday). Depending on client work and other circumstances, work with course leaders to communicate your scenario and get additional time as needed.

### Expected Takeaway Concepts

As part of completing this module, you should gain a 100 / 200 level understanding of the following concepts:

- Automation of Terraform deployments via GitHub Actions
- Code branching and merging in Git
- Terraform State Files

### Completion of the module

At the end of week, the course taker should plan and expect to present their work in an interactive discussion with the course leaders. This presentation is sort of a test, but it is also intended to cement your learning and ensure that the key points from the experience are understood.

Based on the outcomes of presenting, the course leader(s) and course taker can collaborate on whether additional tasks should be assigned to further growth or if the course taker is ready to move on to the next module. As this course is new, we will see how this goes!

### Pre-requisites

Hashicorp Terraform and VS Code installed on your workstation, along with access to the Azure Subscription.

This module requires you to complete your work in a separate GitHub repo. To provision your repo for module 3, visit the [devops-tools](https://github.com/CoreBTS/devops-tools/actions/workflows/generate-terraform-repo.yml) repo and run the **Scaffold DevOps Module 3 Terraform Git Repository** workflow. The workflow dispatch with ask for a `workspace-name`. For this value, provide a value such as 'devops-amo'. This value will be used for your repository name, as well as other identifying information for your workspace.

### Provided Resources

You will be provided with a Git repo for Terraform that has the following preconfigured:

 - Repository Secrets
 - main.tf
 - backends.tf
 - main branch
 - A starter workflow file with secrets referenced

You will also be provided with Azure Blob Storage Containers for your State Files. 

## A Word About State Files

Terraform tracks the status of deployed resources via a [State File](https://www.terraform.io/language/state).  In this module, you'll be working with remote State Files.  While there are provisions to fix a corrupted State File, those are beyond the scope of this module.  If you encounter a State File issue, it's suggested that you delete the State File and also delete the Azure Resources via the Portal, fix the Terraform code and then re-deploy.  This should only be performed in nonprod, it's expected that your code is "ironed out" in nonprod prior to committing it to prod.

## GitHub Actions

- Terraform code needs to run a refresh and plan, so any infrastructure changes can be observed prior to deployment.  The Apply step should not automatically run, it should only run after reviewing the plan and manually approving it in GitHub.

- Web Application code needs to require approval to merge from nonprod to prod.

## Setup Azure Resources

For this module, we will setup the Azure resources via Terraform and will be using two Resource Groups, one as NonProd in East US 2 and one as Prod in Central US.  It's suggested that you start with deploying the NonProd Resource Group and associated resources before creation of the Prod Resource Group and Resources.  Using Terraform, create the following:

- Resource Group
- App Service Plan (B1 SKU for nonprod, S1 SKU for prod)
- Web App
- Key Vault
- Key Vault Secret with a name of AppSecret and a random value of 12 characters

Follow the example naming convention provided by Microsoft when creating your Resource Groups and resources: https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming#example-names-for-common-azure-resource-types.

You will need to have variables defined as well as variable files for each environment.  The code for the App Service Plan, Web App, Key Vault and Secret will need to be setup with variables to allow for different deployments of the same code.  For example, for the WebApp below, the code should be able to deploy to East US 2 OR Central US, depending on which environment variable file (NonProd or Prod) is being referenced.

It's suggested that you work on deploying the code without variables first to ensure it's correct.  Once validated, go back and convert static values to variables as needed and validate the code.  Once this step is validated, proceed with deploying the code to Prod.

The following options should be selected for the Web App:

- Publish = Code
- Runtime stack = Java 17
- Java web server stack = Java SE (Embedded Web Server)
- Operating System = Linux
- Region = East US 2 or Central US (NonProd or Prod)
- Continuous Deployment = Disable
- App Setting that references the Key Vault Secret Value
- Identity set to SystemAssigned

Other settings not listed above are up to the course taker to choose and _should not_ impact the ability to complete the module.

## Configure the Web App to Read the Key Vault Secret

Once the resources are in place, the Web App should be granted access to the Key Vault Secret and reference it as part of its Application Settings via Terraform.  This permission should only allow it to read the Secret, it should not be given any additional permissions.  It's suggested that you start by statically referencing the Object ID of the Web App to grant the permissions, then go back and convert that static value to one that dynamically references the Object ID of the Web App.  The Web App's Settings should also dynamically reference the Key Vault Secret, it's suggested that you follow the same process of using a static reference and then converting it to a dynamic reference.

## Grant Additional Access to the Key Vault Secret

Use a conditional in your Terraform code to grant the CoreBTS NOC and SD Staff AAD Security Group R/W access to the Key Vault Secret, but only in Prod.

### Troubleshooting

As part of this module, the course leader(s) will make changes to your code that will update or possibly break your deployment.  Your task will be to identify the change(s), record what they were for review with the proctors, and then push any fixes (if needed).

### Additional Tweaks and Modifications

If the module proves easy, here are some additional suggestions to attempt to get more familiar with Terraform, if time permits:

- Deploy a storage account via Portal that will contain the Terraform State Files for both environments and reconfigure Terraform to reference them
