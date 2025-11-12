resource "azurerm_subnet" "bassubnet" {
    for_each = var.bastionsubnets
  name                 = each.value.bassubnet_name
  resource_group_name  = each.value.rg_name
  virtual_network_name = each.value.vnet_name
  address_prefixes     = each.value.address_prefixes    #["192.168.1.224/27"]
}
variable "bastionsubnets" {
  type = map(object({
    bassubnet_name     = string
    location           = string
    rg_name            = string
    vnet_name          = string
 address_prefixes  = list(string)
  }))
}
