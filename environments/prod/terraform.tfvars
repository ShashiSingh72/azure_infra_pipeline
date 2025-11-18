rgs11 = {
  "rg11" = {
    rg_name    = "dev-rg22"
    location   = "West Europe"
    managed_by = "Terraform"
    tags = {
      environment = "dev"
      project     = "project1"
    }
  }
    "rg12" = {
    rg_name    = "dev-rg23"
    location   = "West Europe"
    managed_by = "Terraform"
    tags = {
      environment = "dev"
      project     = "project1"
    }
  }
  
}

pips11 = {
  "pip11" = {
    pip_name          = "frontend-pip22"
    location          = "West Europe"
    rg_name           = "dev-rg22"
    allocation_method = "Static"
    sku               = "Standard"
    domain_name_label = "devpip23"
    tags = {
      environment = "dev"
      project     = "project1"
    }
  }

  "pip12" = {
    pip_name          = "backend-pip22"
    location          = "West Europe"
    rg_name           = "dev-rg22"
    allocation_method = "Static"
    sku               = "Standard"
    domain_name_label = "devpip24"
    tags = {
      environment = "dev"
      project     = "project1"
    }
  }

  "pip13" = {
    pip_name          = "bastion-pip22"
    location          = "West Europe"
    rg_name           = "dev-rg22"
    allocation_method = "Static"
    sku               = "Standard"
    domain_name_label = "devpip25"
    tags = {
      environment = "dev"
      project     = "project1"
    }
  }
}

vnets11 = {
  "vnet11" = {
    vnet_name     = "dev-vnet22"
    location      = "West Europe"
    rg_name       = "dev-rg22"
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

vms11 = {
  "vm11" = {
    vm_name                         = "frontend-vm22"
    rg_name                         = "dev-rg22"
    location                        = "West Europe"
    size                            = "Standard_B1s"
    disable_password_authentication = false
    nic_name                        = "dev-nic22"
    pip_name                        = "frontend-pip22"
    subnet_name                     = "frontend-subnet"
    vnet_name                       = "dev-vnet22"
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

  "vm22" = {
    vm_name                         = "backend-vm22"
    rg_name                         = "dev-rg22"
    location                        = "West Europe"
    size                            = "Standard_B1s"
    disable_password_authentication = false
    nic_name                        = "dev-nic22"
    pip_name                        = "backend-pip22"
    subnet_name                     = "backend-subnet"
    vnet_name                       = "dev-vnet22"
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

key_vaults11 = {
  "kv22" = {
    kv_name                     = "shashikv022"
    location                    = "West Europe"
    rg_name                     = "dev-rg22"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    sku_name                    = "standard"
  }
}

nsgs11 = {
  "nsg11" = {
    nsg_name = "dev-nsg22"
    location = "West Europe"
    rg_name  = "dev-rg22"
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

asgs11 = {
  "asg11" = {
    asg_name = "dev-asg22"
    location = "West Europe"
    rg_name  = "dev-rg22"
  }
}

bastionsubnets11 = {
  "bassubnet11" = {
    bassubnet_name   = "AzureBastionSubnet"
    location         = "West Europe"
    rg_name          = "dev-rg22"
    vnet_name        = "dev-vnet22"
    address_prefixes = ["10.0.0.0/27"]
} }

nsg_nic_associations11 = {
  "assoc11" = {
    nsg_name = "dev-ns22"
    nic_name = "dev-nic22"
    rg_name  = "dev-rg22"
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

mssql_servers11 = {
  "mssql_server11" = {
    sql_server_name              = "dev-mssql-server22"
    resource_group_name          = "dev-rg22"
    location                     = "West US"
    administrator_login          = "sqladminuser"
    administrator_login_password = "Password@12345"
    version                      = "12.0"
  }
}

mssql_database11 = {
  "sql_database11" = {
    mssql_database_name = "dev-sql-database22"
    collation           = "SQL_Latin1_General_CP1_CI_AS"
    license_type        = "LicenseIncluded"
    max_size_gb         = "2"
    sql_server_name     = "dev-mssql-server22"
    sku_name            = "S0"
    enclave_type        = "VBS"
    resource_group_name = "dev-rg22"
  }
}
