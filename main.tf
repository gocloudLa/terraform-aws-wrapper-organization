module "organization" {

  source = "./modules/aws/terraform-aws-organization"

  enable_organization           = lookup(var.organization_parameters, "enable_organization", false)
  aws_service_access_principals = lookup(var.organization_parameters, "aws_service_access_principals", ["cloudtrail.amazonaws.com"])
  feature_set                   = lookup(var.organization_parameters, "feature_set", "ALL")
  organizational_units          = lookup(var.organization_parameters, "organizational_units", {})
  accounts                      = lookup(var.organization_parameters, "accounts", {})
  enabled_policy_types          = ["SERVICE_CONTROL_POLICY", "TAG_POLICY"]
  organization_policies = {
    "aws-backup-deletion" = {
      content = file("${path.module}/policies/aws-backup-deletion.json")
    }
    "tag-convention" = {
      content = file("${path.module}/policies/tag-convention.json")
      type    = "TAG_POLICY"
    }
    "s3-deletion" = {
      content = file("${path.module}/policies/s3-deletion.json")
    }
    "governance" = {
      content = file("${path.module}/policies/governance.json")
    }
    "compliance" = {
      content = file("${path.module}/policies/compliance.json")
    }
  }
  tags = local.common_tags

}