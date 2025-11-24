variable "vms" {
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
    admin_username                  = string
    admin_password                  = string
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
