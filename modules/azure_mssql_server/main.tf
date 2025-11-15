resource "azurerm_mssql_server" "server" {
    for_each = var.mssql_servers
  name                         = each.value.sql_server_name
  resource_group_name          = each.value.resource_group_name 
  location                     = each.value.location
  administrator_login          = each.value.administrator_login
  administrator_login_password = each.value.administrator_login_password
  version                      = each.value.version
}
