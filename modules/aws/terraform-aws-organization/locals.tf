locals {

  account_policies_tmp = [for key, value in var.accounts : # in this line, we reference the key and content of variable
    {
      for key1, value1 in value.account_policies : # in this line, we reference the the key inside  a variable of the content of the first line
      "${key}-${key1}" =>                          # in this line, we combine custom keys to avoid grouping variables with same names
      {
        "account_name" = key  #this key is from the first for
        "policy"       = key1 #this key is from the second for
      }
    } if lookup(value, "account_policies", null) != null
  ]
  account_policies = merge(local.account_policies_tmp...)

  ou_policies_tmp = [for key, value in var.organizational_units : # in this line, we reference the key and content of variable
    {
      for key1, value1 in value.ou_policies : # in this line, we reference the the key inside  a variable of the content of the first line
      "${key}-${key1}" =>
      {
        "ou_name" = key  #this key is from the first for
        "policy"  = key1 #this key is from the second for
      }
    } if lookup(value, "ou_policies", null) != null
  ]
  ou_policies = merge(local.ou_policies_tmp...)
}