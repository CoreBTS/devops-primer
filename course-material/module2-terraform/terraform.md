# Module 2 - Terraform

This module is designed to facilitate independent study and work towards creating your Terraform deployment. You will need to have Terraform installed locally, the download link is in [Recommended Tools](https://github.com/CoreBTS/devops-primer/blob/main/course-material/recommended-tools.md). The Terraform Provider will be [AzureRM](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs) for all of the resources in this module except for the Secret random value.  Please pay careful attention to any warnings listed on a Resource's documentation page, some of them are deprecated and should not be used.

## Module Info

### Expected time to complete

This module is intended to take a team member up to 5 business days to complete (i.e., start on Monday, completed by Friday). Depending on client work and other circumstances, work with course leaders to communicate your scenario and get additional time as needed.

### Expected Takeaway Concepts

As part of completing this module, you should gain a 100 / 200 level understanding of the following concepts:

- Providers and Resources
- State Files
- Variables and Environment Variable Files (these are similar in concept to ARM Templates and Environment Parameter Files)
- Referencing Outputs

### Completion of the module

At the end of week, the course taker should plan and expect to present their work in an interactive discussion with the course leaders. This presentation is sort of a test, but it is also intended to cement your learning and ensure that the key points from the experience are understood.

Based on the outcomes of presenting, the course leader(s) and course taker can collaborate on whether additional tasks should be assigned to further growth or if the course taker is ready to move on to the next module. As this course is new, we will see how this goes!

### Pre-requisites

Hashicorp Terraform and VS Code installed on your workstation, along with access to the Azure Subscription.

### Storage of Terraform Files

As part of module 2, it is sufficient to store and work in a directory on your local machine for your Terraform files. If you'd prefer to store in this repository to get feedback and prepare for module 3, feel free to commit your changes to the [terraform-artifacts](https://github.com/CoreBTS/devops-primer/tree/main/terraform-artifacts) folder.

## A Word About State Files

Terraform tracks the status of deployed resources via a [State File](https://www.terraform.io/language/state).  In this module, you'll be working with local State Files.  While there are provisions to fix a corrupted State File, those are beyond the scope of this module.  If you encounter a State File issue, it's suggested that you delete the State File and also delete the Azure Resources via the Portal, fix the Terraform code and then re-deploy.

## Setup Azure Resources

For this module, we will setup the Azure resources via Terraform and will be using two Resource Groups, one as NonProd in East US2 and one as Prod in Central US.  It's suggested that you start with deploying the NonProd Resource Group and associated resources before creation of the Prod Resource Group and Resources.  Using Terraform, create the following:

- Resource Group
- App Service Plan
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

Other settings not listed above are up to the course taker to choose and _should not_ impact the ability to complete the module.

## Configure the Web App to Read the Key Vault Secret

Once the resources are in place, the Web App should be granted access to the Key Vault Secret and reference it as part of its Application Settings.  This permission should only allow it to read the Secret, it should not be given any additional permissions.  It's suggested that you start by statically referencing the Resource ID of the Web App to grant the permissions, then go back and convert that static value to one that dynamically references the Resource ID of the Web App.  The Web App's Settings should also dynamically reference the Key Vault Secret, it's suggested that you follow the same process of using a static reference and then converting it to a dynamic reference.

### Additional Tweaks and Modifications

If the module proves easy, here are some additional suggestions to attempt to get more familiar with Terraform, if time permits:

- Grant the Modern Applications & Data AAD Security Group R/W Access to the KeyVault Secret
- Deploy a conditional setting that creates a storage account but only if the environment is NonProd
- Deploy a storage account via Portal that will contain the Terraform State Files for both environments and reconfigure Terraform to reference them
