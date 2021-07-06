# PipeliningTraining

This project is providing samples for creating DevOps pipelines in Azure DevOps and performing infrastructure as code.
Goal is to create different steps and templates, including hands on practicing cases.

The concept of the project is to provide different examples with levels of progress. This is why the files and folders are named with leading numbers. The numbers a representing the order of change / enhancements.

On root level we have the different areas required by complex pieplies separated to learn one by one.

| Folder   | Description                               |
| -------- | ----------------------------------------- |
| IaC      | All about creating infrastructure as code |
| Piplines | Learn abound classic and YAML pipelines   |

## Prerequisites

All Demos are based on a simple .NET CoreCLI web app compilation and publishing pipeline

1. To create infrastructure in Azure a subscription is required at [Azure Portal](https://portal.azure.com)

2. For DevOps Pipelines

   - Organization with priviledges to install extensions
   - Project with at least 'Build Administrator' role

3. For Terrafor execution

   - installed Terraform v0.15.0+

4. For Terraform pipelines following extensions are used

   - [Replace Tokens](https://marketplace.visualstudio.com/items?itemName=qetza.replacetokens)
   - [Terraform](https://marketplace.visualstudio.com/items?itemName=ms-devlabs.custom-terraform-tasks)
