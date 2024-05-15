resource "azurerm_resource_group" "new_rg" {
  name     = var.rg_name
  location = var.rg_location
}
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = ["10.0.0.0/24"]
  location            = var.rg_location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet" "linvm_subnet" {
  name                 = var.subnet_name
  address_prefixes     = ["10.0.0.0/27"]
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}

resource "azurerm_public_ip" "linvm_pubip" {
  name                = "bharathi_pubip"
  location            = var.rg_location
  resource_group_name = var.rg_name
  allocation_method   = "Dynamic"
}
resource "azurerm_network_interface" "linvm_nic" {
  name                = var.nic_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  ip_configuration {
    name                          = "bharathi_ip"
    subnet_id                     = azurerm_subnet.linvm_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linvm_pubip.id
  }
}

resource "azurerm_network_security_group" "my_nsg" {
  name                = var.nsg_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  security_rule {
    name                       = "forssh"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "formysql"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3306"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "forping"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "forhttp"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "forhttps"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "forgrafana"
    priority                   = 160
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_associ" {
  subnet_id                 = azurerm_subnet.linvm_subnet.id
  network_security_group_id = azurerm_network_security_group.my_nsg.id
}
resource "azurerm_linux_virtual_machine" "vm_linux" {
  name                  = "bharathi-vm"
  location              = azurerm_resource_group.new_rg.location
  resource_group_name   = azurerm_resource_group.new_rg.name
  admin_username        = var.user_name
  admin_password        = var.user_password
  network_interface_ids = [azurerm_network_interface.linvm_nic.id]
  size                  = "Standard_DS1_v2"

  #  admin_ssh_key {
  #    username = var.user_name
  #    # public_key = file("id_rsa.pub")
  #  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  disable_password_authentication = false
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  connection {
    type     = "ssh"
    user     = var.user_name
    password = var.user_password
    host     = self.public_ip_address
  }
  provisioner "file" {
    source      = "webserver.sh"
    destination = "/tmp/script.sh"

  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh",
    ]
  }

  #  lifecycle{
  #    ignore_changes = [
  #    azurerm_public_ip,
  #
  #    ]
  #
  #  }
}


#Windows VM :-
resource "azurerm_public_ip" "winvm_pubip" {
  name                = "winvm2-ip"
  location            = azurerm_resource_group.new_rg.location
  resource_group_name = azurerm_resource_group.new_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "winvm_nic" {
  name                          = "winvm2752"
  resource_group_name           = azurerm_resource_group.new_rg.name
  location                      = azurerm_resource_group.new_rg.location
  enable_accelerated_networking = true
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.linvm_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.winvm_pubip.id
  }
}
resource "azurerm_virtual_machine" "winvm" {
  name                  = "winvm2"
  location              = azurerm_resource_group.new_rg.location
  resource_group_name   = azurerm_resource_group.new_rg.name
  network_interface_ids = [azurerm_network_interface.winvm_nic.id]
  vm_size               = "Standard_D2s_v3"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }
  storage_os_disk {
    name              = "winvm2_OsDisk_1_d6c59e49cd844d6b9f58bbe7510dbff7"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    os_type           = "Windows"
    disk_size_gb      = 127
  }
  os_profile {
    computer_name  = "winvm2"
    admin_username = var.user_name
    admin_password = var.user_password # -->optional
  }
  os_profile_windows_config {
    enable_automatic_upgrades = true
    provision_vm_agent        = true
  }
  boot_diagnostics {
    enabled     = false
    storage_uri = ""
  }
  connection {
    type     = "winrm"
    user     = var.user_name
    password = var.user_password
    host     = azurerm_public_ip.winvm_pubip.ip_address
  }
  provisioner "file" {
    source      = "iiswebserver.ps1"
    destination = "C:/tmp/iiswebserver.ps1"
  }

  tags = {
    environment = "staging"
  }
}

#Storage Account
resource "azurerm_storage_account" "new_sa" {
  name                     = "mytestacc345346347"
  resource_group_name      = azurerm_resource_group.new_rg.name
  location                 = azurerm_resource_group.new_rg.location
  account_tier             = "Standard" #(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created.
  account_replication_type = "LRS"
  account_kind             = "StorageV2" #(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2.
  tags = {
    purpose = "test"
  }
}
resource "azurerm_storage_account" "new_sa1" {
  name                     = "mytestaccpremi23"
  resource_group_name      = azurerm_resource_group.new_rg.name
  location                 = azurerm_resource_group.new_rg.location
  account_tier             = "Premium" #(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created.
  account_replication_type = "LRS"
  account_kind             = "FileStorage" #(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2.
  tags = {
    purpose = "test"
  }
}
#resource "azurerm_storage_account" "my_sa2" {
# name                     = "bharathirgb3e0"
# resource_group_name      = azurerm_resource_group.new_rg.name
# location                 = azurerm_resource_group.new_rg.location
# account_tier             = "Standard"
# account_replication_type = "LRS"
# account_kind             = "Storage"
#
# tags = {
#   purpose = "test"
# }
#

#alert, LB, ALB, NSG , app service, SQL service, logic App,
