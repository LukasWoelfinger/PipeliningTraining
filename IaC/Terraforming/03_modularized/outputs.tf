output "rg_name" {
  value = azurerm_resource_group.main.name
}

output "terraform_state" {
  value = "Stored at '${var.terraformstorageaccount}' at container '${var.terraformcontainername}' in file ${var.tags.Application}-terraform.tfstate"
}

output "sql-administrator_login" {
  value = module.sqlserver.sql-administrator_login
}
