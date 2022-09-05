# Generic naming variables
variable "name_prefix" {
  description = "Optional prefix for the generated name"
  type        = string
  default     = ""
}

variable "name_suffix" {
  description = "Optional suffix for the generated name"
  type        = string
  default     = ""
}

variable "use_caf_naming" {
  description = "Use the Azure CAF naming provider to generate default resource name. `custom_network_security_group_name` override this if set. Legacy default name is used if this is set to `false`."
  type        = bool
  default     = true
}

# Custom naming override
variable "custom_network_security_group_name" {
  description = "Security Group custom name."
  type        = string
  default     = null
}

variable "custom_network_watcher_flow_log_name" {
  description = "Network watcher flow log name."
  type        = string
  default     = null
}
