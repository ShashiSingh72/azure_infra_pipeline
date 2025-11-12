module "rg" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}

module "pip" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_public_ip"
  pips       = var.pips
}

module "networks" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_networking"
  vnets      = var.vnets
}

module "vms" {
  depends_on = [module.rg, module.networks, module.pip]
  source     = "../../modules/azurerm_compute"
  vms        = var.vms
}
module "key_vault" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_key_voult"
  key_vaults = var.key_vaults
}


module "nsg" {
  depends_on = [module.rg]
  source     = "../../modules/network_security_group"
  nsg        = var.nsgs 
}

module "asg" {
  depends_on = [ module.rg ]
  source     = "../../modules/application_security_group"
  asgs       = var.asgs
}

module "nsg-nic-asso" {
  depends_on = [module.nsg, module.vms]
  source     = "../../modules/nsg_nic_association"
  nsg_nic_associations = var.nsg_nic_associations  
}

module "bassubnet" {
  depends_on = [module.rg, module.networks]
  source     = "../../modules/azure_bastion_subnet"
  bastionsubnets = var.bastionsubnets
  
}

module "bastionhost" {
  depends_on = [module.rg, module.pip, module.bassubnet]
  source     = "../../modules/azure_bastion"
  bastionhosts = var.bastionhosts 
}