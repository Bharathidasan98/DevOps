variable "var_rs_group" {
  type = map(object({
    name     = string
    location = string
  }))
}

variable "var_aks_clus" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    dns_prefix          = string
    default_node_pool = object({
      name       = string
      node_count = number
      vm_size    = string
    })
    #identity
    type = string
    tags = map(string)
  }))
}