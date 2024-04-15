variable "flow_log_enabled" {
  description = "Provision network watcher flow logs."
  type        = bool
  default     = false
}

variable "flow_log_logging_enabled" {
  description = "Enable Network Flow Logging."
  type        = bool
  default     = true
}

variable "use_existing_network_watcher" {
  description = "Whether to use an existing Network Watcher or not? Useful when the Network Watcher is created as part of this deployment. Defaults to `true`."
  type        = bool
  default     = true
}

variable "network_watcher_name" {
  description = "The name of the Network Watcher. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "network_watcher_resource_group_name" {
  description = "The name of the Resource Group in which the Network Watcher was deployed. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "flow_log_storage_account_id" {
  description = "Network watcher flow log storage account ID."
  type        = string
  default     = null
}

variable "flow_log_retention_policy_enabled" {
  description = "Boolean flag to enable/disable retention."
  type        = bool
  default     = true
}

variable "flow_log_retention_policy_days" {
  description = "The number of days to retain flow log records."
  type        = number
  default     = 31
}

variable "flow_log_traffic_analytics_enabled" {
  description = "Boolean flag to enable/disable traffic analytics."
  type        = bool
  default     = true
}

variable "log_analytics_workspace_guid" {
  description = "The resource GUID of the attached workspace."
  type        = string
  default     = null
}

variable "log_analytics_workspace_location" {
  description = "The location of the attached workspace."
  type        = string
  default     = null
}

variable "log_analytics_workspace_id" {
  description = "The resource ID of the attached workspace."
  type        = string
  default     = null
}

variable "flow_log_traffic_analytics_interval_in_minutes" {
  description = "How frequently service should do flow analytics in minutes."
  type        = number
  default     = 10
}

variable "flow_log_location" {
  description = "The location where the Network Watcher Flow Log resides. Changing this forces a new resource to be created. Defaults to the `location` of the Network Watcher if `use_existing_network_watcher = true`."
  type        = string
  default     = null
}
