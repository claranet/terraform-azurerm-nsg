data "azurerm_network_watcher" "network_watcher" {
  name                = "NetworkWatcher_${module.azure_region.location_cli}"
  resource_group_name = "NetworkWatcherRG"
}

#tfsec:ignore:azure-network-no-public-egress
module "network_security_group" {
  source  = "claranet/nsg/azurerm"
  version = "x.x.x"

  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack
  location       = module.azure_region.location
  location_short = module.azure_region.location_short

  resource_group_name = module.rg.name

  # To deactivate default deny all rule (not recommended)
  # deny_all_inbound = false

  https_inbound_allowed = true
  allowed_https_source  = ["11.12.13.14/32", "10.0.0.0/24"]

  ssh_inbound_allowed = true
  allowed_ssh_source  = "VirtualNetwork"

  # You can set either a prefix for generated name or a custom one for the resource naming
  # custom_network_security_group_names = "my_nsg"

  # You can set either a prefix for generated name or a custom one for the resource naming
  # custom_network_watcher_flow_log_name = "my_nw_flow_log"

  flow_log_enabled         = true
  flow_log_logging_enabled = true

  network_watcher_name                = data.azurerm_network_watcher.network_watcher.name
  network_watcher_resource_group_name = data.azurerm_network_watcher.network_watcher.resource_group_name

  flow_log_retention_policy_enabled = true # default to true
  flow_log_retention_policy_days    = 91   # default to 91

  # Make sure to use a storage account with no existing lifecycle management rules
  # as this will adds a new rule and overwrites the existing one.
  # Fore more details, see https://github.com/hashicorp/terraform-provider-azurerm/issues/6935
  flow_log_storage_account_id                    = module.storage_account.storage_account_id
  flow_log_traffic_analytics_enabled             = true # default to false
  flow_log_traffic_analytics_interval_in_minutes = 10   # default to 10

  log_analytics_workspace_guid     = module.logs.log_analytics_workspace_guid
  log_analytics_workspace_location = module.azure_region.location
  log_analytics_workspace_id       = module.logs.log_analytics_workspace_id

  additional_rules = [
    {
      priority                   = 300
      name                       = "mysql_inbound"
      source_port_range          = "*"
      destination_port_range     = "3306"
      source_address_prefix      = "10.0.0.0/24"
      destination_address_prefix = "*"

    },
    {
      priority                   = 400
      name                       = "my_service_outbound"
      access                     = "Allow"    # defaults to 'Allow'
      direction                  = "Outbound" # defaults to 'Inbound'
      protocol                   = "Tcp"      # defaults to 'Tcp'
      source_port_range          = "*"
      destination_port_ranges    = ["8081", "1000-2000"]
      source_address_prefixes    = ["10.0.0.0/24", "10.1.0.0/24"]
      destination_address_prefix = "*"
    }
  ]
}

# Single port and prefix sample
resource "azurerm_network_security_rule" "mysql" {
  name = "my-mysql-rule"

  resource_group_name         = module.rg.name
  network_security_group_name = module.network_security_group.name

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

  resource_group_name         = module.rg.name
  network_security_group_name = module.network_security_group.name

  priority                   = 200
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_ranges    = ["8080", "1000-2000"]
  source_address_prefixes    = ["10.0.0.0/24", "10.1.0.0/24"]
  destination_address_prefix = "*"
}
