resource "azurerm_network_interface" "nic" {
  for_each            = var.vms
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.rg_name

  dynamic "ip_configuration" {
    for_each = each.value.ip_configurations
    content {
      name                          = ip_configuration.value.ipconfig_name
      subnet_id                     = data.azurerm_subnet.sub_data[each.key].id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      public_ip_address_id          = data.azurerm_public_ip.pip_data[each.key].id
    }
  }
}

data "azurerm_subnet" "sub_data" {
  for_each             = var.vms
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rg_name
}

data "azurerm_public_ip" "pip_data" {
  for_each            = var.vms
  name                = each.value.pip_name
  resource_group_name = each.value.rg_name
}

# data "azurerm_network_interface" "nic_data" {
#   for_each = var.vms
#   name                = each.value.nic_name
#   resource_group_name = each.value.rg_name

# }

resource "azurerm_linux_virtual_machine" "vm" {
  for_each                        = var.vms
  name                            = each.value.vm_name
  resource_group_name             = each.value.rg_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = each.value.disable_password_authentication
  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
  ]


  dynamic "os_disk" {
    for_each = each.value.os_disk
    content {
      caching              = os_disk.value.caching
      storage_account_type = lookup(os_disk.value, "storage_account_type", null)
    }
  }

  dynamic "source_image_reference" {
    for_each = each.value.source_image_reference
    content {
      publisher = source_image_reference.value.publisher
      offer     = source_image_reference.value.offer
      sku       = source_image_reference.value.sku
      version   = source_image_reference.value.version
    }
  }
}
# data "azurerm_key_vault" "kv_data" {
#   name                = "devkeyvoult"
#   resource_group_name = "pipeline_rg"
# }


# data "azurerm_key_vault_secret" "secret_data" {
#   name         = "username"
#   key_vault_id = data.azurerm_key_vault.kv_data.id
# }

# data "azurerm_key_vault_secret" "secret_data1" {
#   name         = "password"
#   key_vault_id = data.azurerm_key_vault.kv_data.id
# }