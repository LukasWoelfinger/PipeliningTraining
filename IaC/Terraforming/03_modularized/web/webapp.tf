/* 
    Web App service plan definition
*/
resource "azurerm_app_service_plan" "main" {
  name                = "plan-${var.tags.Application}-${var.tags.Environment}"
  location            = var.location
  tags                = var.tags
  resource_group_name = var.rg-name

  sku {
    tier = "Free"
    size = "F1"
  }
}

/* 
    Web App definition
*/
resource "azurerm_app_service" "main" {
  name                = "app-${var.tags.Application}-${var.tags.Environment}"
  location            = var.location
  resource_group_name = var.rg-name
  app_service_plan_id = azurerm_app_service_plan.main.id
  tags                = var.tags
}