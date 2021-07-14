output "rg_name" {
  value = azurerm_resource_group.main.name
}

output "terraform_state" {
  value = "Stored at '${var.tf_storageaccount}' at container '${var.tf_storagecontainer}' in file ${var.tags.Application}-terraform.tfstate"
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
  value = azurerm_sql_server.main.administrator_login_password
  sensitive = true
}
