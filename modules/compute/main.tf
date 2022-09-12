#Create a public IP - bastion
resource "azurerm_public_ip" "publicip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_allocation
}

#create a network interface - bastion
resource "azurerm_network_interface" "nic" {
  name                = var.network_interface_name_bastion
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.network_interface_ip_config_name_bastion
    subnet_id                     = var.bastionsubnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }
}

#create an SSH key
resource "tls_private_key" "pemkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "name" {
  filename = "${path.module}/sshkey.pem"
  content  = tls_private_key.pemkey.private_key_pem
}

#create a linux virtual machine - bastion
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.virtual_machine_name_bastion
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.virtual_machine_size_bastion
  admin_username                  = var.vm_username
  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference_publisher
    offer     = var.source_image_reference_offer
    sku       = var.source_image_reference_sku
    version   = var.source_image_reference_version
  }

  admin_ssh_key {
    username   = var.vm_username
    public_key = tls_private_key.pemkey.public_key_openssh
  }
}

#create a network interface - web
resource "azurerm_network_interface" "nic2" {
  name                = var.network_interface_name_web
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.network_interface_ip_config_name_web
    subnet_id                     = var.websubnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}

#create a linux virtual machine - web
resource "azurerm_linux_virtual_machine" "vm2" {
  name                            = var.virtual_machine_name_web
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.virtual_machine_size
  admin_username                  = var.vm_username
  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.nic2.id,
  ]

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference_publisher
    offer     = var.source_image_reference_offer
    sku       = var.source_image_reference_sku
    version   = var.source_image_reference_version
  }

  admin_ssh_key {
    username   = var.vm_username
    public_key = tls_private_key.pemkey.public_key_openssh
  }
}

#create a network interface - app
resource "azurerm_network_interface" "nic3" {
  name                = var.network_interface_name_app
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.network_interface_ip_config_name_app
    subnet_id                     = var.appsubnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}

#create a linux virtual machine - app
resource "azurerm_linux_virtual_machine" "vm3" {
  name                            = var.virtual_machine_name_app
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.virtual_machine_size
  admin_username                  = var.vm_username
  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.nic3.id,
  ]

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference_publisher
    offer     = var.source_image_reference_offer
    sku       = var.source_image_reference_sku
    version   = var.source_image_reference_version
  }

  admin_ssh_key {
    username   = var.vm_username
    public_key = tls_private_key.pemkey.public_key_openssh
  }
}
