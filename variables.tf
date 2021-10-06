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
  default     = false
}

variable "http_inbound_allowed" {
  description = "True to allow inbound HTTP traffic"
  type        = bool
  default     = false
}

variable "allowed_http_cidr_list" {
  description = "List of CIDR allowed for inbound HTTP traffic"
  type        = list(string)
  default     = []
}

variable "https_inbound_allowed" {
  description = "True to allow inbound HTTPS traffic"
  type        = bool
  default     = false
}

variable "allowed_https_cidr_list" {
  description = "List of CIDR allowed for inbound HTTPS traffic"
  type        = list(string)
  default     = []
}

variable "ssh_inbound_allowed" {
  description = "True to allow inbound SSH traffic"
  type        = bool
  default     = false
}

variable "allowed_ssh_cidr_list" {
  description = "List of CIDR allowed for inbound SSH traffic"
  type        = list(string)
  default     = []
}

variable "rdp_inbound_allowed" {
  description = "True to allow inbound RDP traffic"
  type        = bool
  default     = false
}

variable "allowed_rdp_cidr_list" {
  description = "List of CIDR allowed for inbound RDP traffic"
  type        = list(string)
  default     = []
}

variable "winrm_inbound_allowed" {
  description = "True to allow inbound WinRM traffic"
  type        = bool
  default     = false
}

variable "allowed_winrm_cidr_list" {
  description = "List of CIDR allowed for inbound WinRM traffic"
  type        = list(string)
  default     = []
}
