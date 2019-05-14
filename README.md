# Azure Network Security Group

This module creates an [Azure Network Security Group](https://docs.microsoft.com/en-us/azure/virtual-network/security-overview) 
without any rule.

## Usage  

```hcl
module "az-region" {
  source = "git::ssh://git@git.fr.clara.net/claranet/cloudnative/projects/cloud/azure/terraform/modules/regions.git?ref=vX.X.X"

  azure_region = "${var.azure_region}"
}

module "rg" {
  source = "git::ssh://git@git.fr.clara.net/claranet/cloudnative/projects/cloud/azure/terraform/modules/rg.git?ref=vX.X.X"

  location     = "${module.az-region.location}"
  client_name  = "${var.client_name}"
  environment  = "${var.environment}"
  stack        = "${var.stack}"
}


module "network-security-group" {
    source = "git::ssh://git@git.fr.clara.net/claranet/cloudnative/projects/cloud/azure/terraform/modules/nsg.git?ref=vX.X.X"

    client_name         = "${var.client_name}"
    environment         = "${var.environment}"
    stack               = "${var.stack}"
    resource_group_name = "${module.rg.resource_group_name}"
    location            = "${module.az-region.location}"
    location_short      = "${module.az-region.location_short}"

    # You can set either a prefix for generated name or a custom one for the resource naming
    custom_name = "${var.security_group_name}"
}

# Single port and prefix sample
resource "azurerm_network_security_rule" "http" {
  name = "my-http-rule"

  resource_group_name         = "${module.rg.resource_group_name}"
  network_security_group_name = "${module.network-security-group.network_security_group_name}"

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

  resource_group_name         = "${module.rg.resource_group_name}"
  network_security_group_name = "${module.network-security-group.network_security_group_name}"

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
|------|-------------|:----:|:-----:|:-----:|
| client\_name | Client name/account used in naming | string | n/a | yes |
| custom\_name | Custom Network Security Group name, generated if not set | string | `""` | no |
| environment | Project environment | string | n/a | yes |
| extra\_tags | Additional tags to associate with your Network Security Group. | map | `<map>` | no |
| location | Azure region to use | string | n/a | yes |
| location\_short | Short string for Azure location | string | n/a | yes |
| name\_prefix | Optional prefix for Network Security Group name | string | `""` | no |
| resource\_group\_name | Name of the resource group | string | n/a | yes |
| stack | Project stack name | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| network\_security\_group\_id | Network security group id |
| network\_security\_group\_name | Network security group name |

## Related documentation

Microsoft Network security groups documentation: [https://docs.microsoft.com/en-us/azure/virtual-network/security-overview]

Terraform resource documentation: [https://www.terraform.io/docs/providers/azurerm/r/network_security_group.html]
