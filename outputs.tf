output "network_security_group_id" {
  description = "Network security group ID"
  value       = azurerm_network_security_group.nsg.id
}

output "network_security_group_name" {
  description = "Network security group name"
  value       = azurerm_network_security_group.nsg.name
}

output "network_watcher_flow_log_id" {
  description = "Network watcher flow log ID"
  value       = var.flow_log_enabled ? azurerm_network_watcher_flow_log.nwfl[0].id : null
}
