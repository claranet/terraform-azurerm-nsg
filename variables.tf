variable "location" {
  description = "Azure location."
  type        = string
}

variable "location_short" {
  description = "Short string for Azure location."
  type        = string
}

variable "environment" {
  description = "Project environment"
  type        = string
}

variable "stack" {
  description = "Project stack name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "client_name" {
  description = "Client name/account used in naming"
  type        = string
}

variable "name_prefix" {
  description = "Optional prefix for Network Security Group name"
  type        = string
  default     = ""
}

variable "custom_network_security_group_name" {
  description = "Security Group custom name."
  type        = string
  default     = null
}

variable "extra_tags" {
  description = "Additional tags to associate with your Network Security Group."
  type        = map(string)
  default     = {}
}

variable "deny_all_inbound" {
  description = "True to deny all inbound traffic by default"
  type        = bool
  default     = true
}

variable "http_inbound_allowed" {
  description = "True to allow inbound HTTP traffic"
  type        = bool
  default     = false
}

variable "allowed_http_source" {
  description = "Allowed source for inbound HTTP traffic. Can be a Service Tag, \"*\" or a CIDR list."
  type        = any
  default     = []
  validation {
    condition = (
      var.allowed_http_source != null &&
      var.allowed_http_source != "" &&
      (can(tolist(var.allowed_http_source)) || can(tostring(var.allowed_http_source)))
    )
    error_message = "Variable must be a Service Tag, \"*\" or a list of CIDR."
  }
}

variable "https_inbound_allowed" {
  description = "True to allow inbound HTTPS traffic"
  type        = bool
  default     = false
}

variable "allowed_https_source" {
  description = "Allowed source for inbound HTTPS traffic. Can be a Service Tag, \"*\" or a CIDR list."
  type        = any
  default     = []
  validation {
    condition = (
      var.allowed_https_source != null &&
      var.allowed_https_source != "" &&
      (can(tolist(var.allowed_https_source)) || can(tostring(var.allowed_https_source)))
    )
    error_message = "Variable must be a Service Tag, \"*\" or a list of CIDR."
  }
}

variable "ssh_inbound_allowed" {
  description = "True to allow inbound SSH traffic"
  type        = bool
  default     = false
}

variable "allowed_ssh_source" {
  description = "Allowed source for inbound SSH traffic. Can be a Service Tag, \"*\" or a CIDR list."
  type        = any
  default     = []
  validation {
    condition = (
      var.allowed_ssh_source != null &&
      var.allowed_ssh_source != "" &&
      (can(tolist(var.allowed_ssh_source)) || can(tostring(var.allowed_ssh_source)))
    )
    error_message = "Variable must be a Service Tag, \"*\" or a list of CIDR."
  }
}

variable "rdp_inbound_allowed" {
  description = "True to allow inbound RDP traffic"
  type        = bool
  default     = false
}

variable "allowed_rdp_source" {
  description = "Allowed source for inbound RDP traffic. Can be a Service Tag, \"*\" or a CIDR list."
  type        = any
  default     = []
  validation {
    condition = (
      var.allowed_rdp_source != null &&
      var.allowed_rdp_source != "" &&
      (can(tolist(var.allowed_rdp_source)) || can(tostring(var.allowed_rdp_source)))
    )
    error_message = "Variable must be a Service Tag, \"*\" or a list of CIDR."
  }
}

variable "winrm_inbound_allowed" {
  description = "True to allow inbound WinRM traffic"
  type        = bool
  default     = false
}

variable "allowed_winrm_source" {
  description = "Allowed source for inbound WinRM traffic. Can be a Service Tag, \"*\" or a CIDR list."
  type        = any
  default     = []
  validation {
    condition = (
      var.allowed_winrm_source != null &&
      var.allowed_winrm_source != "" &&
      (can(tolist(var.allowed_winrm_source)) || can(tostring(var.allowed_winrm_source)))
    )
    error_message = "Variable must be a Service Tag, \"*\" or a list of CIDR."
  }
}
