rgs = {
  "rg1" = {
    rg_name    = "dev-rg11"
    location   = "West Europe"
    managed_by = "Terraform"
    tags = {
      environment = "dev"
      project     = "project1"
    }
}

pips = {
  "pip1" = {
    pip_name          = "frontend-pip11"
    location          = "West Europe"
    rg_name           = "dev-rg11"
    allocation_method = "Static"
    sku               = "Standard"
    domain_name_label = "devpip21"
    tags = {
      environment = "dev"
      project     = "project1"
    }
  }

  "pip2" = {
    pip_name          = "backend-pip12"
    location          = "West Europe"
    rg_name           = "dev-rg11"
    allocation_method = "Static"
    sku               = "Standard"
    domain_name_label = "devpip22"
    tags = {
      environment = "dev"
      project     = "project1"
    }
  }

  "pip3" = {
    pip_name          = "bastion-pip12"
    location          = "West Europe"
    rg_name           = "dev-rg11"
    allocation_method = "Static"
    sku               = "Standard"
    domain_name_label = "devpip23"
    tags = {
      environment = "dev"
      project     = "project1"
    }
  }
}

vnets = {
  "vnet1" = {
    vnet_name     = "dev-vnet11"
    location      = "West Europe"
    rg_name       = "dev-rg11"
    address_space = ["10.0.0.0/16"]
    tags = {
      environment = "dev"
      project     = "project1"
    }
    subnets = [
      {
        subnet_name      = "frontend-subnet"
        address_prefixes = ["10.0.1.0/24"]
      },
      {
        subnet_name      = "backend-subnet"
        address_prefixes = ["10.0.2.0/24"]
    }]
  }
}

vms = {
  "vm1" = {
    vm_name                         = "frontend-vm11"
    rg_name                         = "dev-rg11"
    location                        = "West Europe"
    size                            = "Standard_B1s"
    disable_password_authentication = false
    nic_name                        = "dev-nic111"
    pip_name                        = "frontend-pip11"
    subnet_name                     = "frontend-subnet"
    vnet_name                       = "dev-vnet11"
    admin_username                  = "username"
    admin_password                  = "Password@12345"
    ip_configurations = [
      {
        ipconfig_name                 = "ipconfig1"
        private_ip_address_allocation = "Dynamic"

      }
    ]
    os_disk = [
      {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
    ]
    source_image_reference = [
      {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
      }
    ]
  }

  "vm2" = {
    vm_name                         = "backend-vm11"
    rg_name                         = "dev-rg11"
    location                        = "West Europe"
    size                            = "Standard_B1s"
    disable_password_authentication = false
    nic_name                        = "dev-nic112"
    pip_name                        = "backend-pip12"
    subnet_name                     = "backend-subnet"
    vnet_name                       = "dev-vnet11"
    ip_configurations = [
      {
        ipconfig_name                 = "ipconfig2"
        private_ip_address_allocation = "Dynamic"
      }
    ]
    os_disk = [
      {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
    ]
    source_image_reference = [
      {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
      }
    ]
  }
}

key_vaults = {
  "kv1" = {
    kv_name                     = "shashikv011"
    location                    = "West Europe"
    rg_name                     = "dev-rg11"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    sku_name                    = "standard"
  }
}

nsgs = {
  nsg1 = {
    nsg_name = "dev-nsg11"
    location = "West Europe"
    rg_name  = "dev-rg11"
    security_rules = [
      {
        name                       = "Allow-SSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}

asgs = {
  asg1 = {
    asg_name = "dev-asg11"
    location = "West Europe"
    rg_name  = "dev-rg11"
  }
}

bastionsubnets = {
  "bassubnet1" = {
    bassubnet_name   = "AzureBastionSubnet"
    location         = "West Europe"
    rg_name          = "dev-rg11"
    vnet_name        = "dev-vnet11"
    address_prefixes = ["10.0.0.0/27"]
} }

nsg_nic_associations = {
  "assoc1" = {
    nsg_name = "dev-nsg11"
    nic_name = "dev-nic111"
    rg_name  = "dev-rg11"
} }

# bastionhosts = {
#   "bastion1" = {
#     bastion_name   = "AzureBastion11"
#     location       = "West Europe"
#     rg_name        = "dev-rg11"
#     vnet_name      = "dev-vnet11"
#     pip_name       = "bastion-pip12"
#     bassubnet_name = "AzureBastionSubnet"
#     ip_configurations = [
#       {
#         ipconfig_name        = "bastion-ipconfig1"
#         public_ip_address_id = "bastion-pip11"
#       }
#     ]
#   }
# }

mssql_servers = {
  "mssql_server1" = {
    sql_server_name              = "dev-mssql-server2"
    resource_group_name          = "dev-rg11"
    location                     = "West US"
    administrator_login          = "sqladminuser"
    administrator_login_password = "Password@12345"
    version                      = "12.0"
  }
}

mssql_database = {
  "sql_database1" = {
    mssql_database_name = "dev-sql-database"
    collation           = "SQL_Latin1_General_CP1_CI_AS"
    license_type        = "LicenseIncluded"
    max_size_gb         = "2"
    sql_server_name     = "dev-mssql-server2"
    sku_name            = "S0"
    enclave_type        = "VBS"
    resource_group_name = "dev-rg11"
  }
}
