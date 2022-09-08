#create a public ip address for application gateway for internet facing, allow traffic
resource "azurerm_public_ip" "public_ip_application_gateway" {
  name                = var.application_gateway_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

#create a application gateway
resource "azurerm_application_gateway" "app_gateway" {
  name                = var.application_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name

  autoscale_configuration {
    min_capacity = 2
    max_capacity = 5
  }

  sku {
    name = var.sku_name
    tier = var.sku_tier
  }

  gateway_ip_configuration {
    name      = var.gateway_ip_configuration_name
    subnet_id = var.application_gateway_subnet_id
  }

  frontend_port {
    name = var.application_gateway_frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = var.application_gateway_frontend_ip_config_name
    public_ip_address_id = azurerm_public_ip.public_ip_application_gateway.id
  }

  backend_address_pool {
    name = var.application_gateway_backend_pool_name
  }

  backend_http_settings {
    name                  = var.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  http_listener {
    name                           = var.http_listener_name
    frontend_ip_configuration_name = var.application_gateway_frontend_ip_config_name
    frontend_port_name             = var.application_gateway_frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = var.request_routing_rule_name
    rule_type                  = "Basic"
    priority                   = 25
    http_listener_name         = var.http_listener_name
    backend_address_pool_name  = var.application_gateway_backend_pool_name
    backend_http_settings_name = var.http_setting_name
  }
}

#create an association with backend pools(VMs) with application gateway
resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "nic_backend_pool" {
  network_interface_id    = var.web_nic_id
  ip_configuration_name   = var.web_nic_ip_config_name
  backend_address_pool_id = [for value in tolist(azurerm_application_gateway.app_gateway.backend_address_pool.*.id) : value if length(regexall(lower(var.application_gateway_backend_pool_name), value)) > 0][0]
}

#Create a public ip for load balancer 
resource "azurerm_public_ip" "public_ip_load_balancer" {
  name                = var.public_ip_load_balancer_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

#Create a load balancer
resource "azurerm_lb" "load_balancer" {
  name                = var.load_balancer_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = var.load_balancer_frontend_ip_config_name
    public_ip_address_id = azurerm_public_ip.public_ip_load_balancer.id
  }
}

resource "azurerm_lb_backend_address_pool" "lb_address_pool" {
  loadbalancer_id = azurerm_lb.load_balancer.id
  name            = var.load_balancer_backend_address_pool_name
}

resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.load_balancer.id
  name                           = var.load_balancer_rule_name
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = var.load_balancer_frontend_ip_config_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_address_pool.id]
}

resource "azurerm_lb_probe" "lb_probe" {
  loadbalancer_id = azurerm_lb.load_balancer.id
  name            = var.health-probe
  port            = 80
  protocol        = "Tcp"
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_backend_pool_lb" {
  network_interface_id    = var.app_nic_id
  ip_configuration_name   = var.app_nic_ip_config_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_address_pool.id
}
