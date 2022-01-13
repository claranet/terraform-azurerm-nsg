locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  nsg_name = coalesce(var.custom_network_security_group_name, azurecaf_name.nsg.result)
}
