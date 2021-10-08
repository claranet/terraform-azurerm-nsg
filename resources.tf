resource "azurerm_network_security_group" "nsg" {
  name = local.nsg_name

  resource_group_name = var.resource_group_name
  location            = var.location

  tags = merge(local.default_tags, var.extra_tags)
}

resource "azurerm_network_security_rule" "deny_all" {
  for_each = toset(var.deny_all_inbound ? ["enabled"] : [])

  name                        = "deny-all-inbound"
  resource_group_name         = var.resource_group_name
  access                      = "Deny"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.nsg.name
  priority                    = 4096
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}

resource "azurerm_network_security_rule" "http" {
  for_each = toset(var.http_inbound_allowed ? ["enabled"] : [])

  name                        = "http-inbound"
  resource_group_name         = var.resource_group_name
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.nsg.name
  priority                    = 4000
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = try(tostring(var.allowed_http_source), null)
  source_address_prefixes     = try(tolist(var.allowed_http_source), null)
  destination_address_prefix  = "VirtualNetwork"
}

resource "azurerm_network_security_rule" "https" {
  for_each = toset(var.https_inbound_allowed ? ["enabled"] : [])

  name                        = "https-inbound"
  resource_group_name         = var.resource_group_name
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.nsg.name
  priority                    = 4001
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = try(tostring(var.allowed_https_source), null)
  source_address_prefixes     = try(tolist(var.allowed_https_source), null)
  destination_address_prefix  = "VirtualNetwork"
}

resource "azurerm_network_security_rule" "ssh" {
  for_each = toset(var.ssh_inbound_allowed ? ["enabled"] : [])

  name                        = "ssh-inbound"
  resource_group_name         = var.resource_group_name
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.nsg.name
  priority                    = 4002
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = try(tostring(var.allowed_ssh_source), null)
  source_address_prefixes     = try(tolist(var.allowed_ssh_source), null)
  destination_address_prefix  = "VirtualNetwork"
}

resource "azurerm_network_security_rule" "rdp" {
  for_each = toset(var.rdp_inbound_allowed ? ["enabled"] : [])

  name                        = "rdp-inbound"
  resource_group_name         = var.resource_group_name
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.nsg.name
  priority                    = 4003
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = try(tostring(var.allowed_rdp_source), null)
  source_address_prefixes     = try(tolist(var.allowed_rdp_source), null)
  destination_address_prefix  = "VirtualNetwork"
}

resource "azurerm_network_security_rule" "winrm" {
  for_each = toset(var.winrm_inbound_allowed ? ["enabled"] : [])

  name                        = "ssh-inbound"
  resource_group_name         = var.resource_group_name
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.nsg.name
  priority                    = 4004
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "5985"
  source_address_prefix       = try(tostring(var.allowed_winrm_source), null)
  source_address_prefixes     = try(tolist(var.allowed_winrm_source), null)
  destination_address_prefix  = "VirtualNetwork"
}

resource "azurerm_network_security_rule" "appgw_health" {
  for_each = toset(var.application_gateway_rules_enabled ? ["enabled"] : [])

  name                        = "appgw-health-inbound"
  resource_group_name         = var.resource_group_name
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.nsg.name
  priority                    = 4005
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["65200-65535"]
  source_address_prefix       = "GatewayManager"
  destination_address_prefix  = "VirtualNetwork"
}

resource "azurerm_network_security_rule" "lb_inbound" {
  for_each = toset(var.application_gateway_rules_enabled || var.load_balancer_rules_enabled ? ["enabled"] : [])

  name                        = "lb-inbound"
  resource_group_name         = var.resource_group_name
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.nsg.name
  priority                    = 4006
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "AzureLoadBalancer"
  destination_address_prefix  = "VirtualNetwork"
}

resource "azurerm_network_security_rule" "vnet_inbound" {
  for_each = toset(var.application_gateway_rules_enabled || var.load_balancer_rules_enabled ? ["enabled"] : [])

  name                        = "vnet-inbound"
  resource_group_name         = var.resource_group_name
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.nsg.name
  priority                    = 4007
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
}
