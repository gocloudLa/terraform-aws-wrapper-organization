locals {

  organization_units_parameters = {
    for key, value in local.organization_units : key => merge({
      relative_path = dirname(key)
      path          = basename(key)
    }, value)
  }

  organization_units_l0 = {
    for key, value in local.organization_units_parameters : key => value if length(regexall("/", key)) == 0
  }
  organization_units_l1 = {
    for key, value in local.organization_units_parameters : key => value if length(regexall("/", key)) == 1
  }
  organization_units_l2 = {
    for key, value in local.organization_units_parameters : key => value if length(regexall("/", key)) == 2
  }

  organizational_unit_ids = merge(
    { for k, ou in aws_organizations_organizational_unit.this : k => ou.id },
    { for k, ou in aws_organizations_organizational_unit.this_l1 : k => ou.id },
    { for k, ou in aws_organizations_organizational_unit.this_l2 : k => ou.id },
  )

}