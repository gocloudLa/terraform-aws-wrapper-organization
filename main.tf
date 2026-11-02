module "organization" {

  source = "./modules/aws/terraform-aws-organization"

  enable_organization           = lookup(var.organization_parameters, "enable_organization", false)
  aws_service_access_principals = lookup(var.organization_parameters, "aws_service_access_principals", ["cloudtrail.amazonaws.com"])
  feature_set                   = lookup(var.organization_parameters, "feature_set", "ALL")
  organizational_units          = lookup(var.organization_parameters, "organizational_units", {})
  accounts                      = lookup(var.organization_parameters, "accounts", {})
  enabled_policy_types          = lookup(var.organization_parameters, "enabled_policy_types", ["SERVICE_CONTROL_POLICY", "TAG_POLICY"])
  tags                          = local.common_tags

}