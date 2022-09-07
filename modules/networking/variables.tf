variable "resource_group_name" {}
variable "location" {}
variable "virtual_network_name" {default = "vnet"}
variable "virtual_network_address_space" {}
variable "web_subnet_name" {default = "web-subnet"}
variable "web_subnet_prefix" {}
variable "app_subnet_name" {default = "app-subnet"}
variable "app_subnet_prefix" {}
variable "db_subnet_name" {default = "db-subnet"}
variable "db_subnet_prefix" {}
variable "bastion_subnet_name" {default = "bastion-subnet"}
variable "bastion_subnet_prefix" {}
variable "application_gateway_subnet_name" {default = "application-gateway-subnet"}
variable "application_gateway_subnet_prefix" {}
variable "web_nsg_name" {default = "web-nsg"}
variable "app_nsg_name" {default = "app-nsg"}
variable "db_nsg_name" {default = "db-nsg"}
variable "bastion_nsg_name" {default = "bastion-nsg"}
variable "application_gateway_nsg_name" {default = "application-gateway-nsg"}
variable "web_nsg_ports" {}
variable "app_nsg_ports" {}
variable "db_nsg_ports" {}