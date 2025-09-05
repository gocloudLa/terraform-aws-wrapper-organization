locals {
  organization_units    = var.enable_organization ? var.organizational_units : {}
  organization_policies = var.enable_organization ? var.organization_policies : {}
}
