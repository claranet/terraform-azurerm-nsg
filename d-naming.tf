data "azurecaf_name" "nsg" {
  name          = var.stack
  resource_type = "azurerm_network_security_group"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix])
  use_slug      = true
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "nwflog" {
  name          = var.stack
  resource_type = "azurerm_resource_group"
  prefixes      = compact([local.name_prefix, "nwflog"])
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix])
  use_slug      = false
  clean_input   = true
  separator     = "-"
}
