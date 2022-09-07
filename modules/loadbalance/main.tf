#create a public ip address for application gateway for internet facing, allow traffic
resource "azurerm_public_ip" "public_ip_application_gateway" {
    name                = var.application_gateway_public_ip_name
    location            = var.location
    resource_group_name = var.resource_group_name
    allocation_method   = "Static"
}

#create a application gateway
resource "azurerm_application_gateway" "app_gateway" {
    name                = var.application_gateway_name
    location            = var.location
    resource_group_name = var.resource_group_name

    sku{
        name            = var.sku_name
        tier            = var.sku_tier
        capacity        = var.sku_capacity 
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

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "nic_backend_pool" {
  network_interface_id  = var.web_nic_id
  ip_configuration_name = var.nic_backend_pool_ip_config_name
  backend_address_pool_id = tolist(azurerm_application_gateway.app_gateway.backend_address_pool).0.id
}