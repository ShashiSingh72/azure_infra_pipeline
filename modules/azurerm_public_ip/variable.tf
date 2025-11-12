variable "pips" {
  description = "A map of public IPs to create"
  type = map(object({
    pip_name          = string
    location          = string
    rg_name           = string
    allocation_method = string
    sku               = string
    domain_name_label = optional(string)
    tags              = optional(map(string))
  }))

}
