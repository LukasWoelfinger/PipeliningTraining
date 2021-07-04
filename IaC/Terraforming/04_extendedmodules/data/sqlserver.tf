/*
  SQL Server definition
*/
resource "azurerm_sql_server" "main" {
  name                         = lower("sql-${var.tags.Application}-${var.tags.Environment}")
  location                     = var.location
  resource_group_name          = var.rg_name
  version                      = "12.0"
  administrator_login          = var.SQLSA
  administrator_login_password = var.SQLPassword
  tags                         = var.tags
}
