locals {
  additional_rules = { for idx, security_rule in var.additional_rules : security_rule.name => {
    idx : idx,
    security_rule : merge(security_rule, {
      direction = lookup(security_rule, "direction", "Inbound"),
      access    = lookup(security_rule, "access", "Allow"),
      protocol  = lookup(security_rule, "protocol", "Tcp"),
    }),
    }
  }
}

resource "azurerm_network_security_rule" "nsg_rule" {
  for_each                    = { for k, v in local.additional_rules : k => v if k != null }
  name                        = each.key
  network_security_group_name = azurerm_network_security_group.nsg.name
  resource_group_name         = var.resource_group_name

  priority  = each.value.security_rule.priority
  direction = each.value.security_rule.direction
  access    = each.value.security_rule.access
  protocol  = each.value.security_rule.protocol

  source_port_range  = try(tostring(each.value.security_rule.source_port_range), null)
  source_port_ranges = try(tolist(each.value.security_rule.source_port_ranges), null)

  destination_port_range  = try(tostring(each.value.security_rule.destination_port_range), null)
  destination_port_ranges = try(tolist(each.value.security_rule.destination_port_ranges), null)

  source_address_prefix   = try(tostring(each.value.security_rule.source_address_prefix), null)
  source_address_prefixes = try(tolist(each.value.security_rule.source_address_prefixes), null)

  destination_address_prefix   = try(tostring(each.value.security_rule.destination_address_prefix), null)
  destination_address_prefixes = try(tolist(each.value.security_rule.destination_address_prefixes), null)
}

