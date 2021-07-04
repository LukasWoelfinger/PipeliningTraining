resource "azurerm_storage_account" "example" {
  name                     = "func-${var.tags.Application}-${var.tags.Environment}"
  resource_group_name      = var.rg_name
  location                 = var.location
  tags                     = var.tags
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_function_app" "example" {
  name                       = "test-azure-functions"
  location                   = var.location
  resource_group_name        = var.rg_name
  tags                       = var.tags
  app_service_plan_id        = var.web_serviceplan_id
  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
}