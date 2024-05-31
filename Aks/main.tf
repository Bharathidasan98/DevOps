module "aks" {
  source = "/Users/Bharathidasan.m/mydiary/may2024/terraform/DevOps/Aks/module/"

  var_rs_group = {
    rs1 = {
      name     = "bharathiaks"
      location = "southindia"
    }
  }
  var_aks_clus = {
    testing = {
      name                = "test-may-k8s"
      location            = "${module.aks.op_rs_locataion["rs1"]}"
      resource_group_name = "${module.aks.op_rs_name["rs1"]}"
      dns_prefix          = "mayk8s"

      default_node_pool = {
        name       = "default"
        node_count = 1
        vm_size    = "Standard_B2s"
      }

      type = "SystemAssigned"

      tags = {
        env = "test"
      }
    }
  }
}