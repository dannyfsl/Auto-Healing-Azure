# Main composition: reference existing RG, optionally manage its tags, then modules

# Data source to read existing resource group (must exist)
data "azurerm_resource_group" "existing" {
  name = var.resource_group_name
}

# Refer to an existing resource group and managning its tags only if allowed.
# Optionally manage tags on the existing resource group
# Set manage_resource_group_tags = true in terraform.tfvars to enable
resource "azurerm_resource_group" "managed" {
  count = var.manage_resource_group_tags ? 1 : 0

  name     = data.azurerm_resource_group.existing.name
  location = data.azurerm_resource_group.existing.location
  tags     = var.tags
}

# Use RG name and location from data source
locals {
  rg_name     = data.azurerm_resource_group.existing.name
  rg_location = data.azurerm_resource_group.existing.location
}

module "network" {
  source              = "./modules/network"
  resource_group_name = var.resource_group_name
  location            = var.location
  prefix              = var.prefix
  tags                = var.tags
}


module "compute" {
  source              = "./modules/compute"
  resource_group_name = var.resource_group_name
  location            = var.location
  prefix              = var.prefix
  subnet_id           = module.network.subnet_id
  lb_backend_pool_id  = module.lb.backend_pool_id
  lb_probe_id         = module.lb.probe_id
  min_size            = var.min_size
  vm_size             = var.vm_size
  ssh_public_key_path = var.ssh_public_key_path
  tags                = var.tags
}
