variable "mssql_servers" {
  type = map(object({
    sql_server_name          = string
    resource_group_name      = string
    location                 = string
    administrator_login      = string
    administrator_login_password = string
    version                  = string
  }))
  
}
