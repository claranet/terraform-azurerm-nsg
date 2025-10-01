## 8.1.2 (2025-10-01)

### Code Refactoring

* **deps:** 🔗 update claranet/azurecaf to ~> 1.3.0 🔧 ccc3b22

### Miscellaneous Chores

* **deps:** update dependency trivy to v0.67.0 18c7cf5

## 8.1.1 (2025-09-17)

### Bug Fixes

* **GH-11:** 🐛 add rules precondition validation e34c1e4

### Miscellaneous Chores

* **⚙️:** ✏️ update template identifier for MR review 17c5ebc
* 🗑️ remove old commitlint configuration files faf8bb9
* **deps:** 🔗 bump AzureRM provider version to v4.31+ f81b99c
* **deps:** update dependency opentofu to v1.10.0 f5cb7bb
* **deps:** update dependency opentofu to v1.10.1 4448cc2
* **deps:** update dependency opentofu to v1.10.3 7a137f0
* **deps:** update dependency opentofu to v1.10.6 251bf8a
* **deps:** update dependency tflint to v0.58.1 1ee40c2
* **deps:** update dependency tflint to v0.59.1 828500f
* **deps:** update dependency trivy to v0.66.0 7f35aa7
* **deps:** update pre-commit hook pre-commit/pre-commit-hooks to v6 c4a1b04
* **deps:** update tools d627be2
* **deps:** update tools c6c4d5b
* **deps:** update tools c4f8057

## 8.1.0 (2025-06-13)

### Features

* **GH-10:** ✨ add descriptions to inbound network security rules 0f80b6b
* **GH-10:** ✨ add optional description field to additional_rules a68fb48

### Miscellaneous Chores

* **deps:** update dependency tflint to v0.58.0 3b2ba55
* **deps:** update dependency trivy to v0.63.0 778d715
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.2.1 2853018

## 8.0.2 (2025-05-23)

### Bug Fixes

* **flow log:** 🐛 replace deprecated `network_security_group_id` with `target_resource_id` new more generic attribute f5505a3

## 8.0.1 (2025-05-19)

### Bug Fixes

* skip `traffic_analytics` vars validation when not enabled fea232d

### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.8.6 460bfae
* **deps:** update dependency opentofu to v1.8.8 ad178a0
* **deps:** update dependency opentofu to v1.9.0 afd0d35
* **deps:** update dependency opentofu to v1.9.1 2bb3e1f
* **deps:** update dependency pre-commit to v4.1.0 f35154e
* **deps:** update dependency pre-commit to v4.2.0 d85d046
* **deps:** update dependency terraform-docs to v0.20.0 ea0859a
* **deps:** update dependency tflint to v0.55.0 5657568
* **deps:** update dependency tflint to v0.57.0 87971cb
* **deps:** update dependency trivy to v0.57.1 41abdc7
* **deps:** update dependency trivy to v0.58.1 d3e20c9
* **deps:** update dependency trivy to v0.58.2 248b13b
* **deps:** update dependency trivy to v0.59.1 43a57d9
* **deps:** update dependency trivy to v0.60.0 691f1f1
* **deps:** update dependency trivy to v0.61.1 7243670
* **deps:** update dependency trivy to v0.62.0 bca5abe
* **deps:** update dependency trivy to v0.62.1 5cf8a90
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.19.0 aa14040
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.20.0 a2c3624
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.21.0 07f12ea
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.22.0 93aad4d
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.2.0 2cc0168
* **deps:** update tools 5a147ce
* **deps:** update tools 72a8e10
* **deps:** update tools 4df6a9e
* update Github templates 88ba98d
* update tflint config for v0.55.0 46351f6

## 8.0.0 (2024-11-15)

### ⚠ BREAKING CHANGES

* **AZ-1088:** AzureRM Provider v4+ and OpenTofu 1.8+

### Features

* **AZ-1088:** module v8 structure and updates ebed1a9

### Code Refactoring

* update module structure 4eb57d6

### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.8.3 fa6f599
* **deps:** update dependency opentofu to v1.8.4 146a2b2
* **deps:** update dependency pre-commit to v4 8fa8b56
* **deps:** update dependency pre-commit to v4.0.1 3e62727
* **deps:** update dependency tflint to v0.54.0 0e274fa
* **deps:** update dependency trivy to v0.56.0 3d8722d
* **deps:** update dependency trivy to v0.56.1 405e229
* **deps:** update dependency trivy to v0.56.2 b730da1
* **deps:** update pre-commit hook pre-commit/pre-commit-hooks to v5 4b454f4
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.1.0 63ee363
* **deps:** update tools b019d3d
* prepare for new examples structure 53af94a
* update examples structure fc942cb

## 7.8.0 (2024-10-03)

### Features

* use Claranet "azurecaf" provider 33fb4e2

### Documentation

* update README badge to use OpenTofu registry 0f0aacf
* update README with `terraform-docs` v0.19.0 dfa8639

### Continuous Integration

* **AZ-1391:** update semantic-release config [skip ci] ef33f78

### Miscellaneous Chores

* **deps:** enable automerge on renovate 686bde8
* **deps:** update dependency opentofu to v1.7.0 fbd5650
* **deps:** update dependency opentofu to v1.7.1 be89ed1
* **deps:** update dependency opentofu to v1.7.2 a63bcde
* **deps:** update dependency opentofu to v1.7.3 4144ce2
* **deps:** update dependency opentofu to v1.8.0 0c8d53c
* **deps:** update dependency opentofu to v1.8.1 4dfd2e9
* **deps:** update dependency opentofu to v1.8.2 4aebc21
* **deps:** update dependency pre-commit to v3.7.1 82ee65a
* **deps:** update dependency pre-commit to v3.8.0 7477750
* **deps:** update dependency terraform-docs to v0.18.0 55a6ec8
* **deps:** update dependency terraform-docs to v0.19.0 80a33a9
* **deps:** update dependency tflint to v0.51.0 8095fec
* **deps:** update dependency tflint to v0.51.1 cddd62c
* **deps:** update dependency tflint to v0.51.2 1a6cbe6
* **deps:** update dependency tflint to v0.52.0 70a052e
* **deps:** update dependency tflint to v0.53.0 78b1b00
* **deps:** update dependency trivy to v0.50.2 8699812
* **deps:** update dependency trivy to v0.50.4 b9b70e9
* **deps:** update dependency trivy to v0.51.0 5862e69
* **deps:** update dependency trivy to v0.51.1 2cfe73f
* **deps:** update dependency trivy to v0.51.2 e31ac71
* **deps:** update dependency trivy to v0.51.4 a59ec6a
* **deps:** update dependency trivy to v0.52.0 d89c6c5
* **deps:** update dependency trivy to v0.52.1 3e37c2a
* **deps:** update dependency trivy to v0.52.2 74fe3de
* **deps:** update dependency trivy to v0.53.0 a32d7fe
* **deps:** update dependency trivy to v0.54.1 383854d
* **deps:** update dependency trivy to v0.55.0 21bbc20
* **deps:** update dependency trivy to v0.55.1 0f95284
* **deps:** update dependency trivy to v0.55.2 1fca3da
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.17.0 05fe43d
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.18.0 7aa124c
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.0 82bf6f6
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.1 08fcc47
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.2 e3a314e
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.3 6fedef7
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.93.0 cabd112
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.0 f96e014
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.1 05a98bc
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.2 d0ac3b6
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.3 22b58b1
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.95.0 92b9ac0
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.0 5688c78
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.1 d3eb1e3
* **pre-commit:** update commitlint hook 84955d1
* **release:** remove legacy `VERSION` file 75b72b7

## 7.7.0 (2024-04-19)


### Features

* **AZ-1392:** add parameter to prevent the use of the existing network watcher c6d9a7f


### Continuous Integration

* **AZ-1391:** enable semantic-release [skip ci] b162b71


### Miscellaneous Chores

* **deps:** add renovate.json a147923
* **deps:** update renovate.json 3105818

# v7.6.0 - 2024-01-04

Added
  * [GH-7](https://github.com/claranet/terraform-azurerm-nsg/pull/7) Add `var.extra_tags` to `azurerm_network_watcher_flow_log`

# v7.5.0 - 2023-09-08

Added
  * AZ-1159: Do not allow `deny_all_inbound` when `application_gateway_rules_enabled` is used

Fixed
  * AZ-1159: Change destination `VirtualNetwork` to `*` in `application_gateway_rules_enabled` rule

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
