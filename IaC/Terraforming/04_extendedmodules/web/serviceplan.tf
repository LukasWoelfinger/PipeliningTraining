/* 
    Web App service plan definition
*/
resource "azurerm_app_service_plan" "main" {
  name                = "plan-${var.tags.Application}-${var.tags.Environment}"
  location            = var.location
  tags                = var.tags
  resource_group_name = var.rg_name

  sku {
    tier = "Free"
    size = "F1"
  }
}
