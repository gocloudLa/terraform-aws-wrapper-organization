# Standard Platform - Terraform Module 🚀🚀
<p align="right"><a href="https://partners.amazonaws.com/partners/0018a00001hHve4AAC/GoCloud"><img src="https://img.shields.io/badge/AWS%20Partner-Advanced-orange?style=for-the-badge&logo=amazonaws&logoColor=white" alt="AWS Partner"/></a><a href="LICENSE"><img src="https://img.shields.io/badge/License-Apache%202.0-green?style=for-the-badge&logo=apache&logoColor=white" alt="LICENSE"/></a></p>

Welcome to the Standard Platform — a suite of reusable and production-ready Terraform modules purpose-built for AWS environments.
Each module encapsulates best practices, security configurations, and sensible defaults to simplify and standardize infrastructure provisioning across projects.

## 📦 Module: Terraform AWS Organization Module
<p align="right"><a href="https://github.com/gocloudLa/terraform-aws-wrapper-organization/releases/latest"><img src="https://img.shields.io/github/v/release/gocloudLa/terraform-aws-wrapper-organization.svg?style=for-the-badge" alt="Latest Release"/></a><a href=""><img src="https://img.shields.io/github/last-commit/gocloudLa/terraform-aws-wrapper-organization.svg?style=for-the-badge" alt="Last Commit"/></a><a href="https://registry.terraform.io/modules/gocloudLa/wrapper-organization/aws"><img src="https://img.shields.io/badge/Terraform-Registry-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform Registry"/></a></p>
The Terraform wrapper for AWS Organization simplifies the management of AWS Organizations in the AWS cloud. This wrapper functions as a predefined template, facilitating the creation and management of organizational units, accounts, policies, and service access principals by handling all the technical details.

### ✨ Features

- 📥 [Importing accounts](#importing-accounts) - Imports root or other accounts into organization state




## 🚀 Quick Start
```hcl
organization_parameters = {
    enable_organization = true

    aws_service_access_principals = [
      "cloudtrail.amazonaws.com",
      "sso.amazonaws.com",
      "ram.amazonaws.com"
    ]
    feature_set = "ALL"

    organizational_units = {
      "Transitional" = {
        ou_policies = {
          "tag-convention" = {}
          "governance"     = {}
          "compliance"     = {}
        }
      }
      "Workload" = {
        ou_policies = {
          "tag-convention"      = {}
          "aws-backup-deletion" = {}
          "governance"          = {}
          "compliance"          = {}

        }
      }
      "Sandbox" = {
        ou_policies = {
          "tag-convention" = {}
          "governance"     = {}
          "compliance"     = {}
        }
      }
    }

    accounts = {
      # ROOT
      "${local.metadata.public_domain}" = {
        email                             = "email@domain.com",
        parent_id                         = "",
        allow_iam_users_access_to_billing = true
      }
      # NEW
      "${local.metadata.public_domain}-dev" = {
        email                             = "email+dev@domain.com",
        parent_id                         = "Workload",
        allow_iam_users_access_to_billing = true
      }
      "${local.metadata.public_domain}-lab" = {
        email                             = "email+lab@domain.com",
        parent_id                         = "Sandbox",
        allow_iam_users_access_to_billing = true
      }
    }
  }
```


## 🔧 Additional Features Usage

### Importing accounts
To import the root account or another account into the State of the organization wrapper, we must follow the following steps:


<details><summary>Configuration Code</summary>

```hcl
## Execute `terraform pull` to retrieve the State from the backend we are using
terraform pull state > terraform.tfstate

## Once the pull is done, we adjust the backend.tf file of the workspace to use the local backend 
terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}

## Define the account we want to import in the code within main.tf, the account name must be equal to the imported account, the email can be obtained by viewing the account details
    accounts = {
      "ACCOUNT-NAME" = {
        email                             = "ACCOUNT-MAIL",
        parent_id                         = "",
        allow_iam_users_access_to_billing = true
      }
      .
      .
      .
    }

## Execute the `terraform import` command, the ACCOUNT-NAME should be taken from the key used to name the account, the ACCOUNT-ID is the account number
terraform import 'module.organization.module.wrapper_organization.module.organization.aws_organizations_account.this["ACCOUNT-NAME"]' ACCOUNT-ID

## Manually adjust the following parameters in terraform.tfstate to prevent it from trying to recreate the account, we can filter within the account by searching for the following line `type": "aws_organizations_account",`:
      "module": "module.organization.module.wrapper_organization.module.organization",
      "mode": "managed",
      "type": "aws_organizations_account",
      "name": "this",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "index_key": "ACCOUNT-NAME",
          "schema_version": 0,
          "attributes": {
            .
            .
            .
            "close_on_deletion": false,
            "create_govcloud": false,
            .
            .
            .
            "iam_user_access_to_billing": "ALLOW",
            .
            .
            .
          }
        }
      ]

## Validate with a plan if everything is correct
terraform plan

## If the plan shows no changes, set the original backend again and push the State
terraform state push ./terraform.tfstate
```


</details>




## 📑 Inputs
| Name                          | Description                                                                    | Type     | Default                        | Required |
| ----------------------------- | ------------------------------------------------------------------------------ | -------- | ------------------------------ | -------- |
| enable_organization           | Enables or disables the organization service verification.                     | `bool`   | `false`                        | no       |
| aws_service_access_principals | A list of principal services that will be enabled at an organization level.    | `list`   | `["cloudtrail.amazonaws.com"]` | no       |
| feature_set                   | Allows the configuration of the billing in the accounts that will be created.  | `string` | `ALL`                          | no       |
| organizational_units          | A map of OUs that will be created.                                             | `any`    | `{}`                           | no       |
| accounts                      | A map of accounts that will be created under an organization or OU.            | `any`    | `{}`                           | no       |
| enabled_policy_types          | A map of policies that will be created and later attached to an account or OU. | `any`    | `{}`                           | no       |
| organization_policies         | A map of policies that will be created and later attached to an account or OU. | `any`    | `{}`                           | no       |







## ⚠️ Important Notes
- **🚨 Critical State Management Warning:** When importing accounts, do not apply Terraform changes until the plan shows NO changes. This prevents accidentally overwriting or corrupting the organization state.
- **📋 Account Import Process:** Follow the documented step-by-step process carefully to avoid state corruption during account imports.



---

## 🤝 Contributing
We welcome contributions! Please see our contributing guidelines for more details.

## 🆘 Support
- 📧 **Email**: info@gocloud.la
- 🐛 **Issues**: [GitHub Issues](https://github.com/gocloudLa/issues)

## 🧑‍💻 About
We are focused on Cloud Engineering, DevOps, and Infrastructure as Code.
We specialize in helping companies design, implement, and operate secure and scalable cloud-native platforms.
- 🌎 [www.gocloud.la](https://www.gocloud.la)
- ☁️ AWS Advanced Partner (Terraform, DevOps, GenAI)
- 📫 Contact: info@gocloud.la

## 📄 License
This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details. 