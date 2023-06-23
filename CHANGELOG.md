# v7.4.0 - 2023-06-23

Breaking
  * AZ-1106: Change WinRM port to the secure one

# v7.3.1 - 2023-01-27

Added
  * AZ-983: Add resource group name output

# v7.3.0 - 2022-11-23

Changed
  * AZ-908: Use the new data source for CAF naming (instead of resource)

# v7.2.0 - 2022-10-21

Added
   * AZ-869: Add CIFS & NFS predefined rules

# v7.1.0 - 2022-10-17

Changed
  * [GH-5](https://github.com/claranet/terraform-azurerm-nsg/pull/5): Fix outputs and variable descriptions

# v7.0.1 - 2022-10-10

Added
  * [GH-4](https://github.com/claranet/terraform-azurerm-nsg/pull/4): Set default values for nsg `additional_rules`

# v7.0.0 - 2022-09-30

Breaking
  * AZ-840: Update to Terraform `v1.3`

# v6.0.1 - 2022-09-19

Fixed
  * [GH-3](https://github.com/claranet/terraform-azurerm-nsg/pull/3): Use network watcher data source only if flow logs are enabled

# v6.0.0 - 2022-09-16

Breaking
  * AZ-844: Require Terraform `v1.1+` and AzureRM provider `v3.0+`

Added
  * [GH-1](https://github.com/claranet/terraform-azurerm-nsg/pull/1): Add support for custom rules

# v5.2.0 - 2022-09-16

Added
  * [GH-2](https://github.com/claranet/terraform-azurerm-nsg/pull/2): Add network watcher flow log
  * [GH-3](https://github.com/claranet/terraform-azurerm-nsg/pull/3): Set `location` and `tags` explicitly to avoid state mismatch

Changed
  * [GH-2](https://github.com/claranet/terraform-azurerm-nsg/pull/2): Bump minimal AzureRM provider to `v2.96`

# v5.1.0 - 2022-02-03

Added
  * AZ-615: Add an option to enable or disable default tags

# v5.0.0 - 2022-01-13

Breaking
  * AZ-515: Option to use Azure CAF naming provider to name resources

# v4.2.0 - 2021-10-15

Breaking:
  * AS-582: Deny All inbound rule activated by default
  * AZ-582: Remove compatibility with Terraform 0.12

Added
  * AZ-582: Add predefined rules

Changed
  * AZ-572: Revamp examples and improve CI

# v4.1.1 - 2021-08-20

Changed
  * AZ-532: Revamp README with latest `terraform-docs` tool

# v4.1.0 - 2020-12-15

Changed
  * AZ-398: Force lowercases on default generated name

# v4.0.0 - 2020-11-19

Breaking:
  * AZ-344: Upgrade module to tf0.13. Remove all count instances

Changed:
  * AZ-273: Upgrade CI

# v2.1.0 / v3.0.0 - 2020-07-03

Breaking
  * AZ-205: Add ability to create multiple NSGs

Changed
  * AZ-198: AzureRM 2.0 compatibility
  * AZ-209: Update CI with Gitlab template

# v2.0.1 - 2019-10-07

Changed
  * AZ-119: Revamp README and publish this module to Terraform registry

Added
  * AZ-119: Add CONTRIBUTING.md doc and `terraform-wrapper` usage with the module

# v2.0.0 - 2019-09-27

Breaking
  * AZ-94 Terraform 0.12 / HCL2 format

Added
  * AZ-118: Add LICENSE, NOTICE & Github badges

# v0.1.0 - 2019-05-14

Added
  * AZ-23 First version
