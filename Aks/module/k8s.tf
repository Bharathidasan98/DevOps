resource "azurerm_resource_group" "aks_rg" {
  for_each = var.var_rs_group
  name     = each.value.name
  location = each.value.location
}

resource "azurerm_kubernetes_cluster" "example" {
  for_each            = var.var_aks_clus
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  dns_prefix          = each.value.dns_prefix

  default_node_pool {
    name       = each.value.default_node_pool.name
    node_count = each.value.default_node_pool.node_count
    vm_size    = each.value.default_node_pool.vm_size
  }
  identity {
    type = each.value.type
  }
  tags = {}
}

#output "client_certificate" {
#  value     = azurerm_kubernetes_cluster.example.kube_config[0].client_certificate
#  sensitive = true
#}
#
#output "kube_config" {
#  value = azurerm_kubernetes_cluster.example.kube_config_raw
#  sensitive = true
#}
output "op_rs_name" {
  value = { for k,v in var.var_rs_group : k => v.name }
  #  value = azurerm_resource_group.aks_rg.location
}
output "op_rs_locataion" {
  value = {for k,v in var.var_rs_group : k => v.location }
}