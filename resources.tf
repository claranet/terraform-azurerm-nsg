resource "azurerm_network_security_group" "nsg" {
  name                = coalesce(var.custom_name, local.default_name)
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = merge(local.default_tags, var.extra_tags)
}

