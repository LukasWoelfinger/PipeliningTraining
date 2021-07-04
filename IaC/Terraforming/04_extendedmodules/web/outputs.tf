
# Web output
output "app_service_default_hostname" {
  value = "https://${azurerm_app_service.main.default_site_hostname}"
}


output "web_serviceplan_id" {
  value = azurerm_app_service_plan.main.id
}
