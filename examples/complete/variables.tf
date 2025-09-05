/*----------------------------------------------------------------------*/
/* Common |                                                             */
/*----------------------------------------------------------------------*/

# variable "metadata" {
#   type = any
# }

/*----------------------------------------------------------------------*/
/* Organization | Variable Definition                                   */
/*----------------------------------------------------------------------*/

variable "organization_parameters" {
  type        = any
  description = "Organization parameteres to configure organization resources"
  default     = {}
}