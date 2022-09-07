variable "resource_group_name" {}
variable "location" {}
variable "application_gateway_public_ip_name" {default = "app-gateway-public-ip"}
variable "application_gateway_name" {default = "app-gateway"}
variable "sku_name" {default = "Standard_v2"}
variable "sku_tier" {default = "Standard_v2"}
variable "sku_capacity" {default = 2}
variable "gateway_ip_configuration_name" {default = "gateway-ip-public"}
variable "websubnet_id" {}
variable "application_gateway_subnet_id" {}
variable "application_gateway_frontend_port_name" {default = "app-gateway-frontend-port"}
variable "application_gateway_frontend_ip_config_name" {default = "app-gateway-frontend-ip-config"}
variable "application_gateway_backend_pool_name" {default = "app-gateway-backend-pool"}
variable "http_setting_name" {default = "app-gateway-http-setting"}
variable "http_listener_name" {default = "app-gateway-http-listener"}
variable "request_routing_rule_name" {default = "request-routing-rule"}
variable "web_nic_id" {}
variable "nic_backend_pool_ip_config_name" {default = "nic-backend-pool"}