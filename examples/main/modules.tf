module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure_region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

data "azurerm_network_watcher" "network_watcher" {
  name                = "NetworkWatcher_eeastus"
  resource_group_name = "NetworkWatcherRG"
}

module "network_security_group" {
  source  = "claranet/nsg/azurerm"
  version = "x.x.x"

  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack
  location       = module.azure_region.location
  location_short = module.azure_region.location_short

  resource_group_name = module.rg.resource_group_name

  # To deactivate default deny all rule (not recommended)
  # deny_all_inbound = false

  https_inbound_allowed = true
  allowed_https_source  = ["11.12.13.14/32", "10.0.0.0/24"]

  ssh_inbound_allowed = true
  allowed_ssh_source  = "VirtualNetwork"

  # You can set either a prefix for generated name or a custom one for the resource naming
  #custom_network_security_group_names = "my_nsg"

  # You can set either a prefix for generated name or a custom one for the resource naming
  custom_network_watcher_flow_log_name = "my_nw_flow_log"

  flow_log_enabled            = true
  flow_log_logging_enabled    = true
  flow_log_storage_account_id = "xxx"
  network_watcher_name        = data.azurerm_network_watcher.network_watcher

  flow_log_retention_policy_enabled = true # default to true
  flow_log_retention_policy_days    = 7    # default to 7

  flow_log_traffic_analytics_enabled             = true # default to false
  log_analytics_workspace_guid                   = "xxx"
  log_analytics_workspace_location               = "eastus"
  log_analytics_workspace_id                     = "xxx"
  flow_log_traffic_analytics_interval_in_minutes = 10 # default to 10
}

# Single port and prefix sample
resource "azurerm_network_security_rule" "mysql" {
  name = "my-mysql-rule"

  resource_group_name         = module.rg.resource_group_name
  network_security_group_name = module.network_security_group.network_security_group_name

  priority                   = 100
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "3306"
  source_address_prefix      = "10.0.0.0/24"
  destination_address_prefix = "*"
}

# Multiple ports and prefixes sample
resource "azurerm_network_security_rule" "custom" {
  name = "my-custom-rule"

  resource_group_name         = module.rg.resource_group_name
  network_security_group_name = module.network_security_group.network_security_group_name

  priority                   = 200
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_ranges    = ["8080", "1000-2000"]
  source_address_prefixes    = ["10.0.0.0/24", "10.1.0.0/24"]
  destination_address_prefix = "*"
}
