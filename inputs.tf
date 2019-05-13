variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "location" {
  description = "Azure region to use"
}

variable "location_short" {
  description = "Short string for Azure location"
}

variable "environment" {
  description = "Project environment"
}

variable "stack" {
  description = "Project stack name"
}

variable "client_name" {
  description = "Client name/account used in naming"
  type        = "string"
}

variable "name_prefix" {
  description = "Optional prefix for Network Security Group name"
  type        = "string"
  default     = ""
}

variable "custom_name" {
  description = "Custom Network Security Group name, generated if not set"
  default     = ""
}

variable "extra_tags" {
  description = "Additional tags to associate with your Network Security Group."
  type        = "map"
  default     = {}
}
