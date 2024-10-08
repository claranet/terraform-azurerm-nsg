resource "azurerm_network_security_group" "main" {
  name = local.nsg_name

  resource_group_name = var.resource_group_name
  location            = var.location

  tags = merge(local.default_tags, var.extra_tags)
}

moved {
  from = azurerm_network_security_group.nsg
  to   = azurerm_network_security_group.main
}

resource "azurerm_network_security_rule" "deny_all_inbound" {
  count = var.deny_all_inbound ? 1 : 0

  name                        = "deny-all-inbound"
  resource_group_name         = var.resource_group_name
  access                      = "Deny"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.main.name
  priority                    = 4096
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}

moved {
  from = azurerm_network_security_rule.deny_all_inbound["enabled"]
  to   = azurerm_network_security_rule.deny_all_inbound[0]
}

resource "azurerm_network_security_rule" "http_inbound" {
  count = var.http_inbound_allowed ? 1 : 0

  name                        = "http-inbound"
  resource_group_name         = var.resource_group_name
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.main.name
  priority                    = 4000
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = try(tostring(var.allowed_http_source), null)
  source_address_prefixes     = try(tolist(var.allowed_http_source), null)
  destination_address_prefix  = "VirtualNetwork"
}

moved {
  from = azurerm_network_security_rule.http_inbound["enabled"]
  to   = azurerm_network_security_rule.http_inbound[0]
}

resource "azurerm_network_security_rule" "https_inbound" {
  count = var.https_inbound_allowed ? 1 : 0

  name                        = "https-inbound"
  resource_group_name         = var.resource_group_name
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.main.name
  priority                    = 4001
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = try(tostring(var.allowed_https_source), null)
  source_address_prefixes     = try(tolist(var.allowed_https_source), null)
  destination_address_prefix  = "VirtualNetwork"
}

moved {
  from = azurerm_network_security_rule.https_inbound["enabled"]
  to   = azurerm_network_security_rule.https_inbound[0]
}

resource "azurerm_network_security_rule" "ssh_inbound" {
  count = var.ssh_inbound_allowed ? 1 : 0

  name                        = "ssh-inbound"
  resource_group_name         = var.resource_group_name
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.main.name
  priority                    = 4002
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = try(tostring(var.allowed_ssh_source), null)
  source_address_prefixes     = try(tolist(var.allowed_ssh_source), null)
  destination_address_prefix  = "VirtualNetwork"
}

moved {
  from = azurerm_network_security_rule.ssh_inbound["enabled"]
  to   = azurerm_network_security_rule.ssh_inbound[0]
}

resource "azurerm_network_security_rule" "rdp_inbound" {
  count = var.rdp_inbound_allowed ? 1 : 0

  name                        = "rdp-inbound"
  resource_group_name         = var.resource_group_name
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.main.name
  priority                    = 4003
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = try(tostring(var.allowed_rdp_source), null)
  source_address_prefixes     = try(tolist(var.allowed_rdp_source), null)
  destination_address_prefix  = "VirtualNetwork"
}

moved {
  from = azurerm_network_security_rule.rdp_inbound["enabled"]
  to   = azurerm_network_security_rule.rdp_inbound[0]
}

resource "azurerm_network_security_rule" "winrm_inbound" {
  count = var.winrm_inbound_allowed ? 1 : 0

  name                        = "winrm-inbound"
  resource_group_name         = var.resource_group_name
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.main.name
  priority                    = 4004
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "5986"
  source_address_prefix       = try(tostring(var.allowed_winrm_source), null)
  source_address_prefixes     = try(tolist(var.allowed_winrm_source), null)
  destination_address_prefix  = "VirtualNetwork"
}

moved {
  from = azurerm_network_security_rule.winrm_inbound["enabled"]
  to   = azurerm_network_security_rule.winrm_inbound[0]
}

resource "azurerm_network_security_rule" "appgw_health_probe_inbound" {
  count = var.application_gateway_rules_enabled ? 1 : 0

  name                        = "appgw-health-probe-inbound"
  resource_group_name         = var.resource_group_name
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.main.name
  priority                    = 4005
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["65200-65535"]
  source_address_prefix       = "GatewayManager"
  destination_address_prefix  = "*"

  lifecycle {
    precondition {
      condition     = !var.deny_all_inbound
      error_message = "You can't use deny_all_inbound with application_gateway_rules_enabled."
    }
  }
}

moved {
  from = azurerm_network_security_rule.appgw_health_probe_inbound["enabled"]
  to   = azurerm_network_security_rule.appgw_health_probe_inbound[0]
}

resource "azurerm_network_security_rule" "lb_health_probe_inbound" {
  count = var.application_gateway_rules_enabled || var.load_balancer_rules_enabled ? 1 : 0

  name                        = "lb-health-probe-inbound"
  resource_group_name         = var.resource_group_name
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.main.name
  priority                    = 4006
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "AzureLoadBalancer"
  destination_address_prefix  = "VirtualNetwork"
}

moved {
  from = azurerm_network_security_rule.lb_health_probe_inbound["enabled"]
  to   = azurerm_network_security_rule.lb_health_probe_inbound[0]
}

resource "azurerm_network_security_rule" "nfs_inbound" {
  count = var.nfs_inbound_allowed ? 1 : 0

  name                        = "nfs-inbound"
  resource_group_name         = var.resource_group_name
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.main.name
  priority                    = 4007
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "2049"
  source_address_prefix       = try(tostring(var.allowed_nfs_source), null)
  source_address_prefixes     = try(tolist(var.allowed_nfs_source), null)
  destination_address_prefix  = "VirtualNetwork"
}

moved {
  from = azurerm_network_security_rule.nfs_inbound["enabled"]
  to   = azurerm_network_security_rule.nfs_inbound[0]
}

resource "azurerm_network_security_rule" "cifs_inbound" {
  count = var.cifs_inbound_allowed ? 1 : 0

  name                        = "cifs-inbound"
  resource_group_name         = var.resource_group_name
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.main.name
  priority                    = 4008
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = ["137", "138", "139", "445"]
  source_address_prefix       = try(tostring(var.allowed_cifs_source), null)
  source_address_prefixes     = try(tolist(var.allowed_cifs_source), null)
  destination_address_prefix  = "VirtualNetwork"
}

moved {
  from = azurerm_network_security_rule.cifs_inbound["enabled"]
  to   = azurerm_network_security_rule.cifs_inbound[0]
}
