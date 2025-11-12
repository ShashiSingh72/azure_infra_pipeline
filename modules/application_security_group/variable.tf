variable "asgs" {
    type = map(object({
    asg_name = string
    location = string
    rg_name  = string
    }))
}