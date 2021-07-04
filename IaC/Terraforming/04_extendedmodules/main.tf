/*
  Initialize this block for remote state storage (e.g. for Azure DevOps pipelining)!
  ATTENTION: No variables allowed. For local test hardcode values. For pipeline use 
  variable substitutions.

  storage_account_name = "__terraformstorageaccount__"
  container_name       = "__terraformstoragecontainer__"
  key                  = "__applicationname__-__environmentname__-terraform.tfstate"
  access_key           = "__storagekey__" # put "Set at RUNTIME! with powershell!" in variable and replace it with powershell

  REMARK: If Terraform throws erroro "Error: There was an error when attempting to execute the process 'C:\hostedtoolcache\windows\terraform\0.15.4\x64\terraform.exe'. This may indicate the process failed to start. Error: spawn C:\hostedtoolcache\windows\terraform\0.15.4\x64\terraform.exe ENOENT"
  Solution: Correct the working directory AND finalize it with / at the end!
*/
terraform {
  # backend "azurerm" {
  #   storage_account_name = "__terraformstorageaccount__"
  #   container_name       = "__terraformstoragecontainer__"
  #   key                  = "__applicationname__-__environmentname__-terraform.tfstate"
  #   access_key           = "__storagekey__"
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

module "sqlserver" {
  source      = "./data"
  rg_name     = azurerm_resource_group.main.name
  location    = var.location
  tags        = var.tags
  SQLSA       = "CanSetHere"
  SQLPassword = "__SQLPassword__"
}

module "serviceplan" {
  source   = "./web/serviceplan"
  rg_name  = azurerm_resource_group.main.name
  location = var.location
  tags     = var.tags
}

module "webapp" {
  source   = "./web/webapp"
  rg_name  = azurerm_resource_group.main.name
  location = var.location
  tags     = var.tags
  web_serviceplan_id = serviceplan.id
}
