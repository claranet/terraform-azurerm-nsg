data "azurerm_network_watcher" "nw" {
  for_each = toset(var.flow_log_enabled ? ["enabled"] : [])

  name                = var.network_watcher_name
  resource_group_name = var.network_watcher_resource_group_name
}

resource "azurerm_network_watcher_flow_log" "nwfl" {
  count = var.flow_log_enabled ? 1 : 0

  name                 = local.flow_log_name
  network_watcher_name = data.azurerm_network_watcher.nw["enabled"].name
  resource_group_name  = data.azurerm_network_watcher.nw["enabled"].resource_group_name

  network_security_group_id = azurerm_network_security_group.nsg.id
  storage_account_id        = var.flow_log_storage_account_id
  enabled                   = var.flow_log_logging_enabled

  location = coalesce(var.flow_log_location, data.azurerm_network_watcher.nw["enabled"].location)

  retention_policy {
    enabled = var.flow_log_retention_policy_enabled
    days    = var.flow_log_retention_policy_days
  }

  traffic_analytics {
    enabled               = var.flow_log_traffic_analytics_enabled
    workspace_id          = var.log_analytics_workspace_guid
    workspace_region      = var.log_analytics_workspace_location
    workspace_resource_id = var.log_analytics_workspace_id
    interval_in_minutes   = var.flow_log_traffic_analytics_interval_in_minutes
  }

  tags = merge(local.default_tags, var.extra_tags)
}
