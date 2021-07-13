output "rg_name" {
  value = azurerm_resource_group.main.name
}

output "terraform_state" {
  value = "Stored at '${var.tf_storageaccount}' at container '${var.tf_containername}' in file ${var.tags.Application}-terraform.tfstate"
}

# Web output
output "app_service_default_hostname" {
  value = "https://${azurerm_app_service.main.default_site_hostname}"
}
