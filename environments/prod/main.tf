module "rg1" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs11
}

module "pip1" {
  depends_on = [module.rg1]
  source     = "../../modules/azurerm_public_ip"
  pips       = var.pips11
}

module "networks1" {
  depends_on = [module.rg1]
  source     = "../../modules/azurerm_networking"
  vnets      = var.vnets11
}

module "vms1" {
  depends_on = [module.rg1, module.networks1, module.pip1]
  source     = "../../modules/azurerm_compute"
  vms        = var.vms11
}
module "key_vault1" {
  depends_on = [module.rg1]
  source     = "../../modules/azurerm_key_voult"
  key_vaults = var.key_vaults11
}


module "nsg1" {
  depends_on = [module.rg1]
  source     = "../../modules/network_security_group"
  nsg        = var.nsgs11 
}

module "asg1" {
  depends_on = [ module.rg1 ]
  source     = "../../modules/application_security_group"
  asgs       = var.asgs11
}

module "nsg-nic-asso1" {
  depends_on = [module.nsg1, module.vms1]
  source     = "../../modules/nsg_nic_association"
  nsg_nic_associations = var.nsg_nic_associations11 
}

module "bassubnet1" {
  depends_on = [module.rg1, module.networks1]
  source     = "../../modules/azure_bastion_subnet"
  bastionsubnets = var.bastionsubnets11
  
}

# module "bastionhost1" {
#   depends_on = [module.rg1, module.pip1, module.bassubnet1]
#   source     = "../../modules/azure_bastion"
#   bastionhosts = var.bastionhosts 
# }

module "mssql_server1" {
  depends_on = [module.rg1]
  source     = "../../modules/azure_mssql_server"
  mssql_servers = var.mssql_servers11
}

module "sql_database1" {
  depends_on = [ module.rg1 , module.mssql_server1 ]
source = "../../modules/azurerm_mssql_database"
mssql_database = var.mssql_database11
}