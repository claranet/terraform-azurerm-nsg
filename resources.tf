resource "azurerm_network_security_group" "nsg" {
  count = var.network_security_group_instances

  name = coalesce(
    element(var.custom_network_security_group_names, count.index),
    var.network_security_group_instances == 1 ? local.default_name : "${local.default_name}${count.index}",
  )
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = merge(local.default_tags, var.extra_tags)
}
