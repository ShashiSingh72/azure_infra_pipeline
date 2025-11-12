resource "azurerm_application_security_group" "asg" {
    for_each = var.asgs
  name                = each.value.asg_name
  location            = each.value.location
  resource_group_name = each.value.rg_name
}

