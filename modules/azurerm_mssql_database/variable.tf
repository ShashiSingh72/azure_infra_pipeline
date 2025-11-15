variable "mssql_database" {
  type = map(object({
    mssql_database_name = string
    collation           = string
    license_type        = string
    max_size_gb         = number
    sql_server_name     = string
    sku_name            = string
    resource_group_name = string
    enclave_type        = string
  }))
}
