resource "azurerm_network_interface_security_group_association" "nsg-nic-asso1" {
    for_each = var.nsg_nic_associations
  network_interface_id      = data.azurerm_network_interface.nic_data[each.key].id
  network_security_group_id = data.azurerm_network_security_group.nsg_data[each.key].id
}
variable "nsg_nic_associations" {}

data "azurerm_network_interface" "nic_data" {
  for_each            = var.nsg_nic_associations
  name                = each.value.nic_name
  resource_group_name = each.value.rg_name
}
data "azurerm_network_security_group" "nsg_data" {
  for_each            = var.nsg_nic_associations
  name                = each.value.nsg_name
  resource_group_name = each.value.rg_name
}