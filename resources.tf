resource "azurerm_network_security_group" "nsg" {
  name = local.nsg_name

  resource_group_name = var.resource_group_name
  location            = var.location

  tags = merge(local.default_tags, var.extra_tags)
}

resource "azurerm_network_security_rule" "deny_all" {
  for_each = toset(var.deny_all_inbound ? ["enabled"] : [])

  name                        = "Deny All"
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

  name                        = "HTTP"
  resource_group_name         = var.resource_group_name
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.nsg.name
  priority                    = 4000
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefixes     = var.allowed_http_cidr_list
  destination_address_prefix  = "VirtualNetwork"
}

resource "azurerm_network_security_rule" "https" {
  for_each = toset(var.https_inbound_allowed ? ["enabled"] : [])

  name                        = "HTTPS"
  resource_group_name         = var.resource_group_name
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.nsg.name
  priority                    = 4001
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefixes     = var.allowed_https_cidr_list
  destination_address_prefix  = "VirtualNetwork"
}

resource "azurerm_network_security_rule" "ssh" {
  for_each = toset(var.ssh_inbound_allowed ? ["enabled"] : [])

  name                        = "SSH"
  resource_group_name         = var.resource_group_name
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.nsg.name
  priority                    = 4002
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefixes     = var.allowed_ssh_cidr_list
  destination_address_prefix  = "VirtualNetwork"
}

resource "azurerm_network_security_rule" "rdp" {
  for_each = toset(var.rdp_inbound_allowed ? ["enabled"] : [])

  name                        = "RDP"
  resource_group_name         = var.resource_group_name
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.nsg.name
  priority                    = 4003
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefixes     = var.allowed_rdp_cidr_list
  destination_address_prefix  = "VirtualNetwork"
}

resource "azurerm_network_security_rule" "winrm" {
  for_each = toset(var.winrm_inbound_allowed ? ["enabled"] : [])

  name                        = "SSH"
  resource_group_name         = var.resource_group_name
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.nsg.name
  priority                    = 4004
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "5985"
  source_address_prefixes     = var.allowed_winrm_cidr_list
  destination_address_prefix  = "VirtualNetwork"
}
