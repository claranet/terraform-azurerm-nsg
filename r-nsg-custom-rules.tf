#tfsec:ignore:azure-network-no-public-egress - because our variable definition set this to optional (null) by default, which is "0.0.0.0/0" in the AzureRM provider
resource "azurerm_network_security_rule" "main" {
  for_each                    = { for index, v in var.additional_rules : v.name => v }
  name                        = each.value.name
  network_security_group_name = azurerm_network_security_group.main.name
  resource_group_name         = var.resource_group_name

  priority  = each.value.priority
  direction = coalesce(each.value.direction, "Inbound")
  access    = coalesce(each.value.access, "Allow")
  protocol  = coalesce(each.value.protocol, "Tcp")

  source_port_range  = each.value.source_port_range
  source_port_ranges = each.value.source_port_ranges

  destination_port_range  = each.value.destination_port_range
  destination_port_ranges = each.value.destination_port_ranges

  source_address_prefix   = each.value.source_address_prefix
  source_address_prefixes = each.value.source_address_prefixes

  destination_address_prefix   = each.value.destination_address_prefix
  destination_address_prefixes = each.value.destination_address_prefixes
}

moved {
  from = azurerm_network_security_rule.nsg_rule
  to   = azurerm_network_security_rule.main
}
