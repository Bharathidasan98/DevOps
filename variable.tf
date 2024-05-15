variable "rg_name" {
  default = "bharathi_rg"
  type    = string
}
variable "rg_location" {
  default = "southindia"
  type    = string
}
variable "vnet_name" {
  default = "test_vnet"
  type    = string
}
variable "subnet_name" {
  default = "test_subnet"
  type    = string
}
variable "appgwsubnet_name" {
  default = "test_gwsubnet"
  type    = string
}
variable "publicip_name" {
  default = "appgw_ip"
  type    = string
}
variable "nic_name" {
  default = "test_winnic"
  type    = string
}
variable "nic_name2" {
  default = "test_linnic"
  type    = string
}
variable "nsg_name" {
  default = "test_nsg"
  type    = string
}
variable "user_name" {
  default = "testadmin"
  type    = string
}
variable "user_password" {
  default     = "P@sswordazure1"
  sensitive   = true
  type        = string
  description = ""
}
variable "storageac_name" {
  default = "test12wsxedc"
  type    = string
}