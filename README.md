# Standard Platform - Terraform Module 🚀🚀
<p align="right"><a href="https://partners.amazonaws.com/partners/0018a00001hHve4AAC/GoCloud"><img src="https://img.shields.io/badge/AWS%20Partner-Advanced-orange?style=for-the-badge&logo=amazonaws&logoColor=white" alt="AWS Partner"/></a><a href="LICENSE"><img src="https://img.shields.io/badge/License-Apache%202.0-green?style=for-the-badge&logo=apache&logoColor=white" alt="LICENSE"/></a></p>

Welcome to the Standard Platform — a suite of reusable and production-ready Terraform modules purpose-built for AWS environments.
Each module encapsulates best practices, security configurations, and sensible defaults to simplify and standardize infrastructure provisioning across projects.

## 📦 Module: Terraform AWS Organization Module
<p align="right"><a href="https://github.com/gocloudLa/terraform-aws-wrapper-organization/releases/latest"><img src="https://img.shields.io/github/v/release/gocloudLa/terraform-aws-wrapper-organization.svg?style=for-the-badge" alt="Latest Release"/></a><a href=""><img src="https://img.shields.io/github/last-commit/gocloudLa/terraform-aws-wrapper-organization.svg?style=for-the-badge" alt="Last Commit"/></a><a href="https://registry.terraform.io/modules/gocloudLa/wrapper-organization/aws"><img src="https://img.shields.io/badge/Terraform-Registry-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform Registry"/></a></p>
The Terraform Wrapper for AWS Organization.

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
## Ejecutamos `terraform pull` para traernos el State del backend que utilicemos
terraform pull state > terraform.tfstate

## Una vez hecho el pull ajustaremos el archivo backend.tf del workspace para usar el backend local 
terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}

## Definimos la cuenta que queremos importar en el codigo dentro del main.tf, el nombre de la cuenta debe ser igual al de la cuenta importada, el mail se puede obtener viendo los detalles  de la cuenta
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

## Ejecutamos el comando `terraform import`, el ACCOUNT-NAME se debe tomar de la key que se utiliza para nombrar la cuenta, el ACCOUNT-ID es el número de cuenta
terraform import 'module.organization.module.wrapper_organization.module.organization.aws_organizations_account.this["ACCOUNT-NAME"]' ACCOUNT-ID

## Ajustamos manualmente en el terraform.tfstate los siguientes parametros para evitar que nos intente recrear la cuenta, podemos filtrar dentro de la cuenta buscando la siguiente linea `type": "aws_organizations_account",`:
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

## Validamos con un plan si esta todo correcto
terraform plan

## Si el plan no muestra cambios, seteamos nuevamente el backend original y pusheamos el State
terraform state push ./terraform.tfstate
```


</details>










## ⚠️ Important Notes
- **🚨 Do Not Apply Terraform Changes Until Plan Shows Up:** Do not apply Terraform changes until the plan shows that changes need to be applied - this prevents accidentally overwri



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