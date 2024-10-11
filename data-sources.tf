data "azurerm_network_watcher" "main" {
  count = var.flow_log_enabled && var.use_existing_network_watcher ? 1 : 0

  name                = var.network_watcher_name
  resource_group_name = var.network_watcher_resource_group_name
}
