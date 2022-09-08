variable "resource_group_name" {}
variable "location" {}
variable "application_gateway_public_ip_name" { default = "app-gateway-public-ip" }
variable "application_gateway_name" { default = "app-gateway" }
variable "sku_name" { default = "WAF_v2" }
variable "sku_tier" { default = "WAF_v2" }
variable "sku_capacity" { default = 2 }
variable "gateway_ip_configuration_name" { default = "gateway-ip-public" }
variable "websubnet_id" {}
variable "application_gateway_subnet_id" {}
variable "application_gateway_frontend_port_name" { default = "app-gateway-frontend-port" }
variable "application_gateway_frontend_ip_config_name" { default = "app-gateway-frontend-ip-config" }
variable "application_gateway_backend_pool_name" { default = "app-gateway-backend-pool" }
variable "http_setting_name" { default = "app-gateway-http-setting" }
variable "http_listener_name" { default = "app-gateway-http-listener" }
variable "request_routing_rule_name" { default = "request-routing-rule" }
variable "web_nic_id" {}
variable "web_nic_ip_config_name" {}
variable "app_nic_id" {}
variable "app_nic_ip_config_name" {}
variable "nic_backend_pool_ip_config_name" { default = "nic-backend-pool" }
variable "public_ip_load_balancer_name" { default = "load-balancer-public-ip" }
variable "load_balancer_name" {default = "load-balancer"}
variable "load_balancer_frontend_ip_config_name" {default = "lb-frontend-ip-config"}
variable "load_balancer_backend_address_pool_name" {default = "lb-backend-address-pool"}
variable "load_balancer_rule_name" {default = "lb-rule"}
variable "load_balancer_outbound_rule_name" {default = "lb_outbound_rule"}
variable "nat_gateway_name" {default = "nat-gateway"}
variable "health-probe" {default = "health-probe"}