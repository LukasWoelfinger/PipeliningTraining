# SQL outputs 
output "sql-administrator_login" {
  value = azurerm_sql_server.main.administrator_login
}

output "sql-administrator_login_password" {
  value = azurerm_sql_server.main.administrator_login_password
  sensitive = true
}
