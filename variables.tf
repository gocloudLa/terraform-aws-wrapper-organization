/*----------------------------------------------------------------------*/
/* Common |                                                             */
/*----------------------------------------------------------------------*/

variable "metadata" {
  type = any
}

/*----------------------------------------------------------------------*/
/* Organization | Variable Definition                                   */
/*----------------------------------------------------------------------*/

variable "organization_parameters" {
  type        = any
  description = "Identity center parameteres to configure users and policies for organization accounts"
  default     = {}
}