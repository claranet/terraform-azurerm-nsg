module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location       = module.azure_region.location
  location_short = module.azure_region.location_short

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "logs" {
  source  = "claranet/run/azurerm//modules/logs"
  version = "x.x.x"

  resource_group_name = module.rg.name

  client_name    = var.client_name
  environment    = var.environment
  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  stack          = var.stack

  # Log analytics
  log_analytics_workspace_retention_in_days = 90

  # Log storage account
  logs_storage_account_enable_https_traffic_only         = true
  logs_storage_min_tls_version                           = "TLS1_2"
  logs_storage_account_enable_advanced_threat_protection = true

  logs_storage_account_enable_archiving                      = true
  tier_to_cool_after_days_since_modification_greater_than    = 30
  tier_to_archive_after_days_since_modification_greater_than = 90
  delete_after_days_since_modification_greater_than          = 2560 # 7 years

  extra_tags = {
    foo = "bar"
  }
}

module "storage_account" {
  source  = "claranet/storage-account/azurerm"
  version = "x.x.x"

  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

  resource_group_name = module.rg.name

  logs_destinations_ids = [
    module.logs.logs_storage_account_id,
    module.logs.log_analytics_workspace_id
  ]

  extra_tags = {
    foo = "bar"
  }
}
