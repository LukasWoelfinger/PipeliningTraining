output "rg_name" {
  value = azurerm_resource_group.main.name
}

# Web output
output "app_service_default_hostname" {
  value = "https://${azurerm_linux_web_app.main.default_hostname}"
}
