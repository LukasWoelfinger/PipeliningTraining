/* 
    Web App definition
*/
resource "azurerm_app_service" "main" {
  name                = "app-${var.tags.Application}-${var.tags.Environment}"
  location            = var.location
  resource_group_name = var.rg_name
  app_service_plan_id = var.web_serviceplan_id
  tags                = var.tags
}
