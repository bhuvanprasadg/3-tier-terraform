module "resourcegroup" {
  source              = "./modules/resourcegroup"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "networking" {
  source                            = "./modules/networking"
  resource_group_name               = var.resource_group_name
  location                          = var.location
  virtual_network_address_space     = var.virtual_network_address_space
  web_subnet_prefix                 = var.web_subnet_prefix
  app_subnet_prefix                 = var.app_subnet_prefix
  db_subnet_prefix                  = var.db_subnet_prefix
  bastion_subnet_prefix             = var.bastion_subnet_prefix
  application_gateway_subnet_prefix = var.application_gateway_subnet_prefix
  web_nsg_ports                     = var.web_nsg_ports
  app_nsg_ports                     = var.app_nsg_ports
  db_nsg_ports                      = var.db_nsg_ports
}

module "compute" {
  source              = "./modules/compute"
  resource_group_name = var.resource_group_name
  location            = var.location
  websubnet_id        = module.networking.websubnet_id
  appsubnet_id        = module.networking.appsubnet_id
  dbsubnet_id         = module.networking.dbsubnet_id
  bastionsubnet_id    = module.networking.bastionsubnet_id
  vm_username         = var.vm_username
}

module "database" {
  source              = "./modules/database"
  resource_group_name = var.resource_group_name
  location            = var.location
  dbsubnet_id         = module.networking.dbsubnet_id
  vnet_id             = module.networking.vnet_id
  db_admin_username   = var.db_admin_username
  db_admin_password   = var.db_admin_password
}

module "loadbalance" {
  source                        = "./modules/loadbalance"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  application_gateway_subnet_id = module.networking.application_gateway_subnet_id
  websubnet_id                  = module.networking.websubnet_id
  web_nic_id                    = module.compute.web_nic_id
  web_nic_ip_config_name        = module.compute.web_nic_ip_config_name
  app_nic_id                    = module.compute.app_nic_id
  app_nic_ip_config_name        = module.compute.app_nic_ip_config_name
}

module "security" {
  source              = "./modules/security"
  resource_group_name = var.resource_group_name
  location            = var.location
}
