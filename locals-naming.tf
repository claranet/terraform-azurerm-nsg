locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  name          = coalesce(var.custom_name, data.azurecaf_name.nsg.result)
  flow_log_name = coalesce(var.custom_network_watcher_flow_log_name, data.azurecaf_name.nwflog.result)
}
