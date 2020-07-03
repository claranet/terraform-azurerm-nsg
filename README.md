# Azure Network Security Group

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/nsg/azurerm/)

This module creates an [Azure Network Security Group](https://docs.microsoft.com/en-us/azure/virtual-network/security-overview) 
without any rule.

## Version compatibility

| Module version    | Terraform version | AzureRM version |
|-------------------|-------------------|-----------------|
| >= 3.x.x          | 0.12.x            | >= 2.0          |
| >= 2.x.x, < 3.x.x | 0.12.x            | <  2.0          |
| <  2.x.x          | 0.11.x            | <  2.0          |

## Usage 

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

```hcl
module "azure-region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure-region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "network-security-group" {
  source  = "claranet/nsg/azurerm"
  version = "x.x.x"

  client_name         = var.client_name
  environment         = var.environment
  stack               = var.stack
  resource_group_name = module.rg.resource_group_name
  location            = module.azure-region.location
  location_short      = module.azure-region.location_short

  # You can set either a prefix for generated name or a custom one for the resource naming
  custom_network_security_group_names = [var.security_group_name]
}

# Single port and prefix sample
resource "azurerm_network_security_rule" "http" {
  name = "my-http-rule"

  resource_group_name         = module.rg.resource_group_name
  network_security_group_name = module.network-security-group.network_security_group_name[0]

  priority                   = 100
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "80"
  source_address_prefix      = "10.0.0.0/24"
  destination_address_prefix = "*"
}

# Multiple ports and prefixes sample
resource "azurerm_network_security_rule" "custom" {
  name = "my-custom-rule"

  resource_group_name         = module.rg.resource_group_name
  network_security_group_name = module.network-security-group.network_security_group_name[0]

  priority                   = 200
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_ranges    = ["22", "80", "1000-2000"]
  source_address_prefixes    = ["10.0.0.0/24", "10.1.0.0/24"]
  destination_address_prefix = "*"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| client\_name | Client name/account used in naming | `string` | n/a | yes |
| custom\_network\_security\_group\_names | List of Network Security Group custom names. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| environment | Project environment | `string` | n/a | yes |
| extra\_tags | Additional tags to associate with your Network Security Group. | `map(string)` | `{}` | no |
| location | Azure location. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| name\_prefix | Optional prefix for Network Security Group name | `string` | `""` | no |
| network\_security\_group\_instances | Number of Network Security Group to create. | `number` | `1` | no |
| resource\_group\_name | Resource group name | `string` | n/a | yes |
| stack | Project stack name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| network\_security\_group\_id | Network security group id |
| network\_security\_group\_name | Network security group name |

## Related documentation

Microsoft Network security groups documentation: [docs.microsoft.com/en-us/azure/virtual-network/security-overview](https://docs.microsoft.com/en-us/azure/virtual-network/security-overview)

Terraform resource documentation: [terraform.io/docs/providers/azurerm/r/network_security_group.html](https://www.terraform.io/docs/providers/azurerm/r/network_security_group.html)
