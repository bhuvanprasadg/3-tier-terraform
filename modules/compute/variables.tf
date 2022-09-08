variable "resource_group_name" {}
variable "location" {}
variable "public_ip_name" { default = "bastion-public-ip" }
variable "public_ip_allocation" { default = "Static" }
variable "network_interface_name_bastion" { default = "network-interface-bastion" }
variable "network_interface_ip_config_name_bastion" { default = "networkInterfaceIPConfigBastion" }
variable "network_interface_name_web" { default = "network-interface-web" }
variable "network_interface_ip_config_name_web" { default = "networkInterfaceIPConfigWeb" }
variable "network_interface_name_app" { default = "network-interface-app" }
variable "network_interface_ip_config_name_app" { default = "networkInterfaceIPConfigApp" }
variable "private_ip_address_allocation" { default = "Dynamic" }
variable "websubnet_id" {}
variable "appsubnet_id" {}
variable "dbsubnet_id" {}
variable "bastionsubnet_id" {}
variable "virtual_machine_name_bastion" { default = "bastion-vm" }
variable "virtual_machine_name_web" { default = "web-vm" }
variable "virtual_machine_name_app" { default = "app-vm" }
variable "virtual_machine_size" { default = "Standard_F2" }
variable "virtual_machine_size_bastion" { default = "Standard_D2s_v3" }
variable "vm_username" {}
variable "os_disk_caching" { default = "ReadWrite" }
variable "os_disk_storage_account_type" { default = "Standard_LRS" }
variable "source_image_reference_publisher" { default = "Canonical" }
variable "source_image_reference_offer" { default = "UbuntuServer" }
variable "source_image_reference_sku" { default = "18.04-LTS" }
variable "source_image_reference_version" { default = "latest" }
