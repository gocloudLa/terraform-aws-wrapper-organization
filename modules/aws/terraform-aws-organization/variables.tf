/*----------------------------------------------------------------------*/
/* General | Variable Definition                                        */
/*----------------------------------------------------------------------*/

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

/*----------------------------------------------------------------------*/
/* Organization | Variable Definition                                   */
/*----------------------------------------------------------------------*/

variable "enable_organization" {
  description = "Enables or disables the organization service"
  type        = bool
  default     = false
}
variable "aws_service_access_principals" {
  description = "A list of principal services that will be enable at an organization level"
  type        = list(any)
  default     = []
}
variable "feature_set" {
  description = "Allows the configuration of the billing in the acounts that will be created. ALL (default) || CONSOLIDATED_BILLING"
  type        = string
  default     = "ALL"
}
variable "enabled_policy_types" {
  description = "Allows the configuration of the policies to be used at organization level"
  type        = list(any)
  default     = ["SERVICE_CONTROL_POLICY", "TAG_POLICY"]
}
variable "organizational_units" {
  description = "A map of OUs that will be created"
  type        = any
  default     = {}
}
variable "accounts" {
  description = "A map of account that will be created under an organization or OU"
  type        = any
  default     = {}
}
variable "organization_policies" {
  description = "A map of policies that will be created and later attached to an account or OU"
  type        = any
  default     = {}
}