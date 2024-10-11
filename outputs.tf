output "resource" {
  description = "Network security group resource object."
  value       = azurerm_network_security_group.main
}

output "id" {
  description = "Network security group ID."
  value       = azurerm_network_security_group.main.id
}

output "name" {
  description = "Network security group name."
  value       = azurerm_network_security_group.main.name
}

output "network_watcher_flow_log_id" {
  description = "Network watcher flow log ID."
  value       = one(azurerm_network_watcher_flow_log.main[*].id)
}

output "network_watcher_flow_log_resource" {
  description = "Network watcher flow log resource object."
  value       = one(azurerm_network_watcher_flow_log.main[*])
}

output "resource_group_name" {
  description = "Network security group resource group name."
  value       = var.resource_group_name
}
