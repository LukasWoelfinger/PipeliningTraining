output "rg_name" {
  value = azurerm_resource_group.main.name
}

output "terraform_state" {
  value = "Stored at '${var.tf_storageaccount}' at container '${var.tf_containername}' in file ${var.tags.Application}-terraform.tfstate"
}

output "sql-administrator_login" {
  value = module.sqlserver.sql-administrator_login
}
