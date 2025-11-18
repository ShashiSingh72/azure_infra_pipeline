variable "rgs11" {
  description = "A map of resource groups to create"
  type = map(object({
    rg_name    = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
  }))

}

variable "pips11" {
  description = "A map of public IPs to create"
  type = map(object({
    pip_name          = string
    location          = string
    rg_name           = string
    allocation_method = string
    sku               = string
    domain_name_label = optional(string)
    tags              = optional(map(string))
  }))

}
variable "vnets11" {
  description = "A map of virtual networks to create"
  type = map(object({
    vnet_name     = string
    location      = string
    rg_name       = string
    address_space = list(string)
    tags          = optional(map(string))
    subnets = list(object({
      subnet_name      = string
      address_prefixes = list(string)
    }))

  }))
}

variable "vms11" {
  description = "A map of virtual machines to create"
  type = map(object({
    vm_name                         = string
    rg_name                         = string
    location                        = string
    size                            = string
    disable_password_authentication = bool
    nic_name                        = string
    pip_name                        = string
    subnet_name                     = string
    vnet_name                       = string
    ip_configurations = list(object({
      ipconfig_name                 = string
      private_ip_address_allocation = string
    }))
    os_disk = list(object({
      caching              = string
      storage_account_type = optional(string)
    }))
    source_image_reference = list(object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    }))
  }))

}

variable "key_vaults11" {
  description = "A map of key vaults to create"
  type = map(object({
    kv_name                     = string
    location                    = string
    rg_name                     = string
    enabled_for_disk_encryption = bool
    soft_delete_retention_days  = number
    purge_protection_enabled    = bool
    sku_name                    = string
  }))
}


variable "nsgs11" {
  type = map(object({
    nsg_name = string
    location = string
    rg_name  = string
    security_rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string

    }))
  }))
}

variable "asgs11" {
  type = map(object({
    asg_name = string
    location = string
    rg_name  = string
  }))
}

variable "bastionsubnets11" {
  type = map(object({
    bassubnet_name   = string
    location         = string
    rg_name          = string
    vnet_name        = string
    address_prefixes = list(string)
  }))
}

variable "nsg_nic_associations11" {}

# variable "bastionhosts" {
#   type = map(object({
#     bastion_name   = string
#     location       = string
#     rg_name        = string
#     vnet_name      = string
#     pip_name       = string
#     bassubnet_name = string
#     ip_configurations = list(object({
#       ipconfig_name        = string
#       public_ip_address_id = string
#     }))
#   }))
# }

variable "mssql_servers11" {
  type = map(object({
    sql_server_name              = string
    resource_group_name          = string
    location                     = string
    administrator_login          = string
    administrator_login_password = string
    version                      = string
  }))
}

variable "mssql_database11" {
  type = map(object({
    mssql_database_name = string
    collation           = string
    license_type        = string
    sql_server_name     = string
    max_size_gb         = number
    sku_name            = string
    enclave_type        = string
    resource_group_name = string
  }))
}
