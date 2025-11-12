
resource "azurerm_bastion_host" "bastionhost" {
    for_each = var.bastionhosts
  name                = each.value.bastion_name
  location            = each.value.location
  resource_group_name = each.value.rg_name

  dynamic "ip_configuration" {
    for_each = each.value.ip_configurations
    content {
    name                 = ip_configuration.value.ipconfig_name
    subnet_id            = data.azurerm_subnet.data_sub[each.key].id
    public_ip_address_id = data.azurerm_public_ip.pip_data[each.key].id
  }
  }
}

data "azurerm_public_ip" "pip_data" {
  for_each            = var.bastionhosts
  name                = each.value.pip_name
  resource_group_name = each.value.rg_name
}

data "azurerm_subnet" "data_sub" {
  for_each             = var.bastionhosts
  name                 = each.value.bassubnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rg_name
}

variable "bastionhosts" {
  type = map(object({
    bastion_name       = string
    location           = string
    rg_name            = string
    vnet_name          = string
    pip_name          = string
    bassubnet_name     = string
    ip_configurations  = list(object({
      ipconfig_name                 = string
      public_ip_address_id          = string
    }))
  })) 
}