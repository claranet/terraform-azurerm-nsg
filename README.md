# Azure Network Security Group

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/nsg/azurerm/)

This module creates an [Azure Network Security Group](https://docs.microsoft.com/en-us/azure/virtual-network/security-overview) 
with possible predefined rules.

The default module configuration deny all inbound traffic.

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | AzureRM version |
| -------------- | ----------------- | --------------- |
| >= 6.x.x       | 1.x               | >= 3.0          |
| >= 5.x.x       | 0.15.x            | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   | >= 2.0          |
| >= 3.x.x       | 0.12.x            | >= 2.0          |
| >= 2.x.x       | 0.12.x            | < 2.0           |
| <  2.x.x       | 0.11.x            | < 2.0           |

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

```hcl
module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure_region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "logs" {
  source  = "claranet/run-common/azurerm//modules/logs"
  version = "x.x.x"

  resource_group_name = module.rg.resource_group_name

  client_name    = var.client_name
  environment    = var.environment
  location       = var.location
  location_short = module.azure_region.location_short
  stack          = var.stack

  # Log analytics
  log_analytics_workspace_custom_name       = module.naming.log_analytics_workspace.name
  log_analytics_workspace_retention_in_days = 90

  # Log storage account
  logs_storage_account_enable_https_traffic_only         = true
  logs_storage_min_tls_version                           = "TLS1_2"
  logs_storage_account_enable_advanced_threat_protection = true

  logs_storage_account_enable_archiving                      = true
  tier_to_cool_after_days_since_modification_greater_than    = 30
  tier_to_archive_after_days_since_modification_greater_than = 90
  delete_after_days_since_modification_greater_than          = 2560 # 7 years

  extra_tags = local.extra_tags
}

data "azurerm_network_watcher" "network_watcher" {
  name                = "NetworkWatcher_eastus"
  resource_group_name = "NetworkWatcherRG"
}

module "network_security_group" {
  source  = "claranet/nsg/azurerm"
  version = "x.x.x"

  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack
  location       = module.azure_region.location
  location_short = module.azure_region.location_short

  resource_group_name = module.rg.resource_group_name

  # To deactivate default deny all rule (not recommended)
  # deny_all_inbound = false

  https_inbound_allowed = true
  allowed_https_source  = ["11.12.13.14/32", "10.0.0.0/24"]

  ssh_inbound_allowed = true
  allowed_ssh_source  = "VirtualNetwork"

  # You can set either a prefix for generated name or a custom one for the resource naming
  # custom_network_security_group_names = "my_nsg"

  # You can set either a prefix for generated name or a custom one for the resource naming
  custom_network_watcher_flow_log_name = "my_nw_flow_log"

  flow_log_enabled            = true
  flow_log_logging_enabled    = true

  network_watcher_name                = data.azurerm_network_watcher.network_watcher.name
  networK_watcher_resource_group_name = data.azurerm_network_watcher.network_watcher.resource_group_name

  flow_log_retention_policy_enabled = true # default to true
  flow_log_retention_policy_days    = 7    # default to 7

  flow_log_storage_account_id                    = module.logs.logs_storage_account_id
  flow_log_traffic_analytics_enabled             = true # default to false
  flow_log_traffic_analytics_interval_in_minutes = 10   # default to 10

  log_analytics_workspace_guid                   = module.logs.log_analytics_workspace_guid
  log_analytics_workspace_location               = module.rg.location
  log_analytics_workspace_id                     = module.logs.log_analytics_workspace_id
}

# Single port and prefix sample
resource "azurerm_network_security_rule" "mysql" {
  name = "my-mysql-rule"

  resource_group_name         = module.rg.resource_group_name
  network_security_group_name = module.network_security_group.network_security_group_name

  priority                   = 100
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "3306"
  source_address_prefix      = "10.0.0.0/24"
  destination_address_prefix = "*"
}

# Multiple ports and prefixes sample
resource "azurerm_network_security_rule" "custom" {
  name = "my-custom-rule"

  resource_group_name         = module.rg.resource_group_name
  network_security_group_name = module.network_security_group.network_security_group_name

  priority                   = 200
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_ranges    = ["8080", "1000-2000"]
  source_address_prefixes    = ["10.0.0.0/24", "10.1.0.0/24"]
  destination_address_prefix = "*"
}
```

## Providers

| Name | Version |
|------|---------|
| azurecaf | ~> 1.1 |
| azurerm | >= 1.44 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurecaf_name.nsg](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurecaf_name.nwflog](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.appgw_health_probe_inbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.deny_all_inbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.http_inbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.https_inbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.lb_health_probe_inbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.rdp_inbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.ssh_inbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.winrm_inbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_watcher_flow_log.nwfl](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_http\_source | Allowed source for inbound HTTP traffic. Can be a Service Tag, "*" or a CIDR list. | `any` | `[]` | no |
| allowed\_https\_source | Allowed source for inbound HTTPS traffic. Can be a Service Tag, "*" or a CIDR list. | `any` | `[]` | no |
| allowed\_rdp\_source | Allowed source for inbound RDP traffic. Can be a Service Tag, "*" or a CIDR list. | `any` | `[]` | no |
| allowed\_ssh\_source | Allowed source for inbound SSH traffic. Can be a Service Tag, "*" or a CIDR list. | `any` | `[]` | no |
| allowed\_winrm\_source | Allowed source for inbound WinRM traffic. Can be a Service Tag, "*" or a CIDR list. | `any` | `[]` | no |
| application\_gateway\_rules\_enabled | True to configure rules mandatory for hosting an Application Gateway. See https://docs.microsoft.com/en-us/azure/application-gateway/configuration-infrastructure#allow-access-to-a-few-source-ips | `bool` | `false` | no |
| client\_name | Client name/account used in naming | `string` | n/a | yes |
| custom\_network\_security\_group\_name | Security Group custom name. | `string` | `null` | no |
| custom\_network\_watcher\_flow\_log\_name | Network watcher flow log name. | `string` | `null` | no |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| deny\_all\_inbound | True to deny all inbound traffic by default | `bool` | `true` | no |
| environment | Project environment | `string` | n/a | yes |
| extra\_tags | Additional tags to associate with your Network Security Group. | `map(string)` | `{}` | no |
| flow\_log\_enabled | Provision network watcher flow logs | `bool` | `false` | no |
| flow\_log\_logging\_enabled | Enable Network Flow Logging | `bool` | `true` | no |
| flow\_log\_retention\_policy\_days | The number of days to retain flow log records | `number` | `7` | no |
| flow\_log\_retention\_policy\_enabled | Boolean flag to enable/disable retention | `bool` | `true` | no |
| flow\_log\_storage\_account\_id | Network watcher flow log storage account id | `string` | `null` | no |
| flow\_log\_traffic\_analytics\_enabled | Boolean flag to enable/disable traffic analytics | `bool` | `true` | no |
| flow\_log\_traffic\_analytics\_interval\_in\_minutes | How frequently service should do flow analytics in minutes. | `number` | `10` | no |
| http\_inbound\_allowed | True to allow inbound HTTP traffic | `bool` | `false` | no |
| https\_inbound\_allowed | True to allow inbound HTTPS traffic | `bool` | `false` | no |
| load\_balancer\_rules\_enabled | True to configure rules mandatory for hosting a Load Balancer. | `bool` | `false` | no |
| location | Azure location. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| log\_analytics\_workspace\_guid | The resource GUID of the attached workspace. | `string` | `null` | no |
| log\_analytics\_workspace\_id | The resource ID of the attached workspace. | `string` | `null` | no |
| log\_analytics\_workspace\_location | The location of the attached workspace. | `string` | `null` | no |
| name\_prefix | Optional prefix for the generated name | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name | `string` | `""` | no |
| network\_watcher\_name | Network watcher name | `string` | `null` | no |
| rdp\_inbound\_allowed | True to allow inbound RDP traffic | `bool` | `false` | no |
| resource\_group\_name | Resource group name | `string` | n/a | yes |
| ssh\_inbound\_allowed | True to allow inbound SSH traffic | `bool` | `false` | no |
| stack | Project stack name | `string` | n/a | yes |
| use\_caf\_naming | Use the Azure CAF naming provider to generate default resource name. `custom_network_security_group_name` override this if set. Legacy default name is used if this is set to `false`. | `bool` | `true` | no |
| winrm\_inbound\_allowed | True to allow inbound WinRM traffic | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| netowrk\_watcher\_flow\_log\_id | Netowrk watcher flow log id |
| network\_security\_group\_id | Network security group id |
| network\_security\_group\_name | Network security group name |
<!-- END_TF_DOCS -->
## Related documentation

Microsoft Network security groups documentation: [docs.microsoft.com/en-us/azure/virtual-network/security-overview](https://docs.microsoft.com/en-us/azure/virtual-network/security-overview)
