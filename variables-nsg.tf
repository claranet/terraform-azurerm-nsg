variable "all_inbound_denied" {
  description = "True to deny all inbound traffic by default."
  type        = bool
  default     = true
}

variable "http_inbound_allowed" {
  description = "True to allow inbound HTTP traffic."
  type        = bool
  default     = false
}

variable "http_source_allowed" {
  description = "Allowed source for inbound HTTP traffic. Can be a Service Tag, \"*\" or a CIDR list."
  type        = any
  default     = []
  validation {
    condition = (
      var.http_source_allowed != null &&
      var.http_source_allowed != "" &&
      (can(tolist(var.http_source_allowed)) || can(tostring(var.http_source_allowed)))
    )
    error_message = "Variable must be a Service Tag, \"*\" or a list of CIDR."
  }
}

variable "https_inbound_allowed" {
  description = "True to allow inbound HTTPS traffic."
  type        = bool
  default     = false
}

variable "https_source_allowed" {
  description = "Allowed source for inbound HTTPS traffic. Can be a Service Tag, \"*\" or a CIDR list."
  type        = any
  default     = []
  validation {
    condition = (
      var.https_source_allowed != null &&
      var.https_source_allowed != "" &&
      (can(tolist(var.https_source_allowed)) || can(tostring(var.https_source_allowed)))
    )
    error_message = "Variable must be a Service Tag, \"*\" or a list of CIDR."
  }
}

variable "ssh_inbound_allowed" {
  description = "True to allow inbound SSH traffic."
  type        = bool
  default     = false
}

variable "ssh_source_allowed" {
  description = "Allowed source for inbound SSH traffic. Can be a Service Tag, \"*\" or a CIDR list."
  type        = any
  default     = []
  validation {
    condition = (
      var.ssh_source_allowed != null &&
      var.ssh_source_allowed != "" &&
      (can(tolist(var.ssh_source_allowed)) || can(tostring(var.ssh_source_allowed)))
    )
    error_message = "Variable must be a Service Tag, \"*\" or a list of CIDR."
  }
}

variable "rdp_inbound_allowed" {
  description = "True to allow inbound RDP traffic."
  type        = bool
  default     = false
}

variable "rdp_source_allowed" {
  description = "Allowed source for inbound RDP traffic. Can be a Service Tag, \"*\" or a CIDR list."
  type        = any
  default     = []
  validation {
    condition = (
      var.rdp_source_allowed != null &&
      var.rdp_source_allowed != "" &&
      (can(tolist(var.rdp_source_allowed)) || can(tostring(var.rdp_source_allowed)))
    )
    error_message = "Variable must be a Service Tag, \"*\" or a list of CIDR."
  }
}

variable "winrm_inbound_allowed" {
  description = "True to allow inbound secure WinRM traffic."
  type        = bool
  default     = false
}

variable "winrm_source_allowed" {
  description = "Allowed source for inbound WinRM traffic. Can be a Service Tag, \"*\" or a CIDR list."
  type        = any
  default     = []
  validation {
    condition = (
      var.winrm_source_allowed != null &&
      var.winrm_source_allowed != "" &&
      (can(tolist(var.winrm_source_allowed)) || can(tostring(var.winrm_source_allowed)))
    )
    error_message = "Variable must be a Service Tag, \"*\" or a list of CIDR."
  }
}

variable "application_gateway_rules_enabled" {
  description = "True to configure rules mandatory for hosting an Application Gateway. See [documentation](https://docs.microsoft.com/en-us/azure/application-gateway/configuration-infrastructure#allow-access-to-a-few-source-ips)"
  type        = bool
  default     = false
}

variable "load_balancer_rules_enabled" {
  description = "True to configure rules mandatory for hosting a Load Balancer."
  type        = bool
  default     = false
}

variable "additional_rules" {
  description = "Additional network security group rules to add. For arguements please refer to [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule#argument-reference)"
  type = list(object({
    priority    = number
    name        = string
    description = optional(string)

    direction = optional(string, "Inbound")
    access    = optional(string, "Allow")
    protocol  = optional(string, "Tcp")

    source_port_range  = optional(string)
    source_port_ranges = optional(list(string))

    destination_port_range  = optional(string)
    destination_port_ranges = optional(list(string))

    source_address_prefix   = optional(string)
    source_address_prefixes = optional(list(string))

    destination_address_prefix   = optional(string)
    destination_address_prefixes = optional(list(string))
  }))
  default = []
}

variable "nfs_inbound_allowed" {
  description = "True to allow inbound NFSv4 traffic."
  type        = bool
  default     = false
}

variable "nfs_source_allowed" {
  description = "Allowed source for inbound NFSv4 traffic. Can be a Service Tag, \"*\" or a CIDR list."
  type        = any
  default     = []
  validation {
    condition = (
      var.nfs_source_allowed != null &&
      var.nfs_source_allowed != "" &&
      (can(tolist(var.nfs_source_allowed)) || can(tostring(var.nfs_source_allowed)))
    )
    error_message = "Variable must be a Service Tag, \"*\" or a list of CIDR."
  }
}

variable "cifs_inbound_allowed" {
  description = "True to allow inbound CIFS traffic."
  type        = bool
  default     = false
}

variable "cifs_source_allowed" {
  description = "Allowed source for inbound CIFS traffic. Can be a Service Tag, \"*\" or a CIDR list."
  type        = any
  default     = []
  validation {
    condition = (
      var.cifs_source_allowed != null &&
      var.cifs_source_allowed != "" &&
      (can(tolist(var.cifs_source_allowed)) || can(tostring(var.cifs_source_allowed)))
    )
    error_message = "Variable must be a Service Tag, \"*\" or a list of CIDR."
  }
}
