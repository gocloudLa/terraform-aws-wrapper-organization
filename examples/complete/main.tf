module "wrapper_organization" {
  source = "../../"

  metadata = local.metadata

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

}