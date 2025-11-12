variable "vnets" {
  description = "A map of virtual networks to create"
  type = map(object({
    vnet_name     = string
    location      = string
    rg_name       = string
    address_space = list(string)
    tags          = optional(map(string))
    subnets = list(object({
      subnet_name      = string
      address_prefixes = list(string)
    }))

  }))
}
