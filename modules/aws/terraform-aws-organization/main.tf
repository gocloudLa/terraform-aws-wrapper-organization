resource "aws_organizations_organization" "this" {
  count                         = var.enable_organization ? 1 : 0
  aws_service_access_principals = var.aws_service_access_principals
  feature_set                   = var.feature_set
  enabled_policy_types          = var.enabled_policy_types
}

resource "aws_organizations_organizational_unit" "this" {

  for_each = local.organization_units

  name      = each.key
  parent_id = aws_organizations_organization.this[0].roots[0].id

  tags = var.tags
}

resource "aws_organizations_account" "this" {

  for_each = var.accounts #local.organization_accounts

  name              = each.key
  email             = each.value.email
  close_on_deletion = false
  parent_id         = try(each.value.parent_id, "") != "" ? aws_organizations_organizational_unit.this[each.value.parent_id].id : aws_organizations_organization.this[0].roots[0].id
  # parent_id = aws_organizations_organizational_unit.this[each.value.parent_id].id

  iam_user_access_to_billing = each.value.allow_iam_users_access_to_billing ? "ALLOW" : "DENY"

  tags = var.tags
}

resource "aws_organizations_policy" "this" {
  for_each = local.organization_policies

  name        = each.key
  description = try(each.value.type, each.value.type, null)
  content     = each.value.content
  type        = try(each.value.type, each.value.type, "SERVICE_CONTROL_POLICY")

  tags = var.tags
}

## Organization Unit Attachment
resource "aws_organizations_policy_attachment" "this_ou" {
  for_each = local.ou_policies

  policy_id = aws_organizations_policy.this[each.value.policy].id
  target_id = aws_organizations_organizational_unit.this[each.value.ou_name].id

  depends_on = [
    aws_organizations_organization.this
  ]
}

## Organization Account Attachment
resource "aws_organizations_policy_attachment" "this_account" {
  for_each = local.account_policies

  policy_id = aws_organizations_policy.this[each.value.policy].id
  target_id = aws_organizations_account.this[each.value.account_name].id

  depends_on = [
    aws_organizations_organization.this
  ]
}