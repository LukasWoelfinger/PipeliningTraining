/*************************************************************************
  All variables START
*************************************************************************/
/*
  Defines the variables for the main terraform file
*/
variable "subscription" {
  description = "The subscription id where the ressources will be deployed"
  default     = "__subscriptionid__"
}

/* 
  General settings for infrastructure deployment 
*/
variable "location" {
  description = "The Azure location where all resource should be created (e.g. northeurope, westeurope, centralus)"
  default     = "__location__"
}

variable "tags" {
  description = "The tags for all resources. Will be used for resource name generation, too."
  type        = map(any)
  default = {
    Application = "__tf_applicationname__"
    Environment = "__tf_environmentname__"
  }
}

/*
  Variables to inform user about the backend storage location of the terraform state.
  ATTENTION: Do not use this variables in main file. Backend configuration block requires static values!
*/
variable "tf_storageaccount" {
  description = "Caches the name of the terraform storrage account used for safing the state. Used for output information only!"
  default     = "__tf_storageaccount__"
}

variable "tf_containername" {
  description = "Output cache of the container name storring the terraform state file. Used for output information only!"
  default     = "__tf_containername__"
}

variable "key" {
  description = "Output cache of the terraform state file name. Used for output information only!"
  default     = "__tf_applicationname__-__tf_environmentname__-terraform.tfstate"
}

/*
  Block for SQL variables
*/
variable "SQLSA" {
  description = "The SA user name for the azure sql server"
  default     = "__sqlAdministrator__"
}

variable "SQLPassword" {
  description = "The SA user password for the azure sql server"
  default     = "__sqlPasswordSaUser__"
}
/*************************************************************************
  All INFRASTRUCTURE START
*************************************************************************/

/*
  Initialize this block for remote state storage (e.g. for Azure DevOps pipelining)!
  It replaces the required_provider section in terraform {}
  ATTENTION: No variables allowed. For local test hardcode values. For pipeline use
  variable substitutions.

  backend "azurerm" {
    storage_account_name = "__tf_storageaccount__"
    container_name       = "__tf_storagecontainer__"
    key                  = "__tf_applicationname__-__tf_environmentname__-terraform.tfstate"
    access_key           = "__tf_storagekey__" # put "Set at RUNTIME! with powershell!" in variable and replace it with powershell
  }
  REMARK: If Terraform throws erroro "Error: There was an error when attempting to execute the process 'C:\hostedtoolcache\windows\terraform\0.15.4\x64\terraform.exe'. This may indicate the process failed to start. Error: spawn C:\hostedtoolcache\windows\terraform\0.15.4\x64\terraform.exe ENOENT"
  Solution: Correct the working directory AND finalize it with / at the end!
*/
terraform {
  # backend "azurerm" {
  #   storage_account_name = "__tf_storageaccount__"
  #   container_name       = "__tf_storagecontainer__"
  #   key                  = "__tf_applicationname__-__tf_environmentname__-terraform.tfstate"
  #   access_key           = "__tf_storagekey__"
  # }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
}

/*
  Setup Microsoft Azure provider as infrastructure destination
*/
provider "azurerm" {
  features {}
  subscription_id = var.subscription
}

# create the resource group
resource "azurerm_resource_group" "main" {
  name     = "rg-${var.tags.Application}-${var.tags.Environment}"
  location = var.location
  tags     = var.tags
}

# Split into web module from here
resource "azurerm_app_service_plan" "main" {
  name                = "plan-${var.tags.Application}-${var.tags.Environment}"
  location            = var.location
  tags                = var.tags
  resource_group_name = azurerm_resource_group.main.name

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "main" {
  name                = "app-${var.tags.Application}-${var.tags.Environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.main.id
  tags                = var.tags
}

#Split into sql module
resource "azurerm_sql_server" "main" {
  name                         = lower("sql-${var.tags.Application}-${var.tags.Environment}")
  location                     = var.location
  resource_group_name          = azurerm_resource_group.main.name
  version                      = "12.0"
  administrator_login          = var.SQLSA
  administrator_login_password = var.SQLPassword
  tags                         = var.tags
}

/***********************************************************************************
  All OUTPUTS START
***********************************************************************************/

output "rg_name" {
  value = azurerm_resource_group.main.name
}

output "terraform_state" {
  value = "Stored at '${var.tf_storageaccount}' at container '${var.tf_containername}' in file ${var.tags.Application}-terraform.tfstate"
}

# Web output
output "app_service_default_hostname" {
  value = "https://${azurerm_app_service.main.default_site_hostname}"
}

# SQL outputs 
output "sql-administrator_login" {
  value = azurerm_sql_server.main.administrator_login
}

output "sql-administrator_login_password" {
  value     = azurerm_sql_server.main.administrator_login_password
  sensitive = true
}
