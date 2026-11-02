resource "aws_organizations_organization" "this" {
  count                         = var.enable_organization ? 1 : 0
  aws_service_access_principals = var.aws_service_access_principals
  feature_set                   = var.feature_set
  enabled_policy_types          = var.enabled_policy_types
}

resource "aws_organizations_organizational_unit" "this" {

  for_each = local.organization_units_l0

  name      = try(each.value.name, trimspace(each.value.path))
  parent_id = aws_organizations_organization.this[0].roots[0].id

  tags = var.tags
}

resource "aws_organizations_organizational_unit" "this_l1" {

  for_each = local.organization_units_l1

  name      = try(each.value.name, trimspace(each.value.path))
  parent_id = aws_organizations_organizational_unit.this[each.value.relative_path].id

  tags = var.tags
}

resource "aws_organizations_organizational_unit" "this_l2" {

  for_each = local.organization_units_l2

  name      = try(each.value.name, trimspace(each.value.path))
  parent_id = aws_organizations_organizational_unit.this_l1[each.value.relative_path].id

  tags = var.tags
}

resource "aws_organizations_account" "this" {

  for_each = var.accounts #local.organization_accounts

  name              = each.key
  email             = each.value.email
  close_on_deletion = false
  parent_id         = try(each.value.parent_id, "") != "" ? local.organizational_unit_ids[each.value.parent_id] : aws_organizations_organization.this[0].roots[0].id

  iam_user_access_to_billing = each.value.allow_iam_users_access_to_billing ? "ALLOW" : "DENY"

  tags = var.tags
}

