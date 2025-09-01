## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_organizations_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account) | resource |
| [aws_organizations_organization.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization) | resource |
| [aws_organizations_organizational_unit.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accounts"></a> [accounts](#input\_accounts) | A map of account that will be created under an organization or OU | `any` | `{}` | no |
| <a name="input_aws_service_access_principals"></a> [aws\_service\_access\_principals](#input\_aws\_service\_access\_principals) | A list of principal services that will be enable at an organization level | `list(any)` | `[]` | no |
| <a name="input_enable_organization"></a> [enable\_organization](#input\_enable\_organization) | Enables or disables the organization service | `bool` | `false` | no |
| <a name="input_feature_set"></a> [feature\_set](#input\_feature\_set) | Allows the configuration of the billing in the acounts that will be created. ALL (default) \|\| CONSOLIDATED\_BILLING | `string` | `"ALL"` | no |
| <a name="input_organizational_units"></a> [organizational\_units](#input\_organizational\_units) | A map of OUs that will be created | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_ids"></a> [account\_ids](#output\_account\_ids) | n/a |
| <a name="output_master_account_email"></a> [master\_account\_email](#output\_master\_account\_email) | n/a |
| <a name="output_master_account_id"></a> [master\_account\_id](#output\_master\_account\_id) | n/a |
| <a name="output_organization_arn"></a> [organization\_arn](#output\_organization\_arn) | n/a |
| <a name="output_organization_id"></a> [organization\_id](#output\_organization\_id) | n/a |
| <a name="output_ou_accounts"></a> [ou\_accounts](#output\_ou\_accounts) | n/a |
| <a name="output_ou_ids"></a> [ou\_ids](#output\_ou\_ids) | n/a |
