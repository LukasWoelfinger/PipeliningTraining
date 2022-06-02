/*
  Initialize this block for remote state storage (e.g. for Azure DevOps pipelining)!
  ATTENTION: No variables allowed. For local test hardcode values. For pipeline use 
  variable substitutions.

  storage_account_name = "__tf_storageaccount__"
  container_name       = "__tf_storagecontainer__"
  key                  = "__tf_applicationname__-__tf_environmentname__-terraform.tfstate"
  access_key           = "__tf_storagekey__" # put "Set at RUNTIME! with powershell!" in variable and replace it with powershell

  REMARK: If Terraform throws erroro "Error: There was an error when attempting to execute the process 'C:\hostedtoolcache\windows\terraform\0.15.4\x64\terraform.exe'. This may indicate the process failed to start. Error: spawn C:\hostedtoolcache\windows\terraform\0.15.4\x64\terraform.exe ENOENT"
  Solution: Correct the working directory AND finalize it with / at the end!
*/
terraform {
  required_providers {
    azurerm = {}
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
resource "azurerm_service_plan" "main" {
  name                = "plan-${var.tags.Application}-${var.tags.Environment}"
  location            = var.location
  tags                = var.tags
  resource_group_name = azurerm_resource_group.main.name
  os_type             = "Linux"

  sku_name = "FREE"
}

resource "azurerm_linux_web_app" "main" {
  name                = "app-${var.tags.Application}-${var.tags.Environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  service_plan_id     = azurerm_service_plan.main.id
  tags                = var.tags

  site_config {}

  # Enable setup to use in memory database by setting development evironment configuration
  app_settings = {
    "ASPNETCORE_ENVIRONMENT"  = "Development"
    "UseOnlyInMemoryDatabase" = "true"
  }
}
