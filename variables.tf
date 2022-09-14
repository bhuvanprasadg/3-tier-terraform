variable "client_id" {}
variable "client_secret" {}
variable "subscription_id" {}
variable "tenant_id" {}
variable "resource_group_name" {}
variable "location" {}
variable "virtual_network_address_space" {default = ["10.0.0.0/16"]}
variable "web_subnet_prefix" {default = ["10.0.0.0/24"]}
variable "app_subnet_prefix" {default = ["10.0.1.0/24"]}
variable "db_subnet_prefix" {default = ["10.0.2.0/24"]}
variable "bastion_subnet_prefix" {default = ["10.0.3.0/27"]}
variable "application_gateway_subnet_prefix" {default = ["10.0.4.0/27"]}
variable "web_nsg_ports" {default = ["22", "80"]}
variable "app_nsg_ports" {default = ["22", "80"]}
variable "db_nsg_ports" {default = ["5432", "80"]}
variable "vm_username" {}
variable "db_admin_username" {}
variable "db_admin_password" {}
