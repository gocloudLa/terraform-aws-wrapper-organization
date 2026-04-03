output "organization_id" {
  value = try(aws_organizations_organization.this[0].id, null)
}

output "organization_arn" {
  value = try(aws_organizations_organization.this[0].arn, null)
}

output "master_account_id" {
  value = try(aws_organizations_organization.this[0].master_account_id, null)
}

output "master_account_email" {
  value = try(aws_organizations_organization.this[0].master_account_email, null)
}

output "ou_ids" {
  value = tomap(merge(
    { for k, unit in aws_organizations_organizational_unit.this : k => unit.id },
    { for k, unit in aws_organizations_organizational_unit.this_l1 : k => unit.id },
    { for k, unit in aws_organizations_organizational_unit.this_l2 : k => unit.id },
  ))
}

output "ou_accounts" {
  value = tomap(merge(
    { for k, unit in aws_organizations_organizational_unit.this : k => unit.accounts },
    { for k, unit in aws_organizations_organizational_unit.this_l1 : k => unit.accounts },
    { for k, unit in aws_organizations_organizational_unit.this_l2 : k => unit.accounts },
  ))
}

output "account_ids" {
  value = tomap({
    for k, account in aws_organizations_account.this : k => account.id
  })
}

output "policies_ids" {
  value = tomap({
    for k, policy in aws_organizations_policy.this : k => policy.id
  })
}