output "rg_name" {
  value = azurerm_resource_group.main.name
}

output "terraform_state" {
  value = "Stored at '${var.terraformstorageaccount}' at container '${var.terraformcontainername}' in file ${var.tags.Application}-terraform.tfstate"
}

# output "certificate_value" {
#   value = data.azurerm_key_vault_secret.cert-base64.value
# }

# output "app_registration_name" {
#   value = azuread_application.app_registration.name
# }

# Web output
output "app_service_default_hostname" {
  value = "https://${azurerm_app_service.main.default_site_hostname}"
}

# output "certificate_thumbprint" {
#   value = "${azurerm_key_vault_certificate.main.thumbprint}"
# }

# SQL outputs 
output "sql-administrator_login" {
  value = azurerm_sql_server.main.administrator_login
}

output "sql-administrator_login_password" {
  value = azurerm_sql_server.main.administrator_login_password
  sensitive = true
}
