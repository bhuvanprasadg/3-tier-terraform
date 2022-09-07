resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  address_space       = var.virtual_network_address_space
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_subnet" "web" {
  name                 = var.web_subnet_name
  address_prefixes     = var.web_subnet_prefix
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet" "app" {
  name                 = var.app_subnet_name
  address_prefixes     = var.app_subnet_prefix
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet" "db" {
  name                 = var.db_subnet_name
  address_prefixes     = var.db_subnet_prefix
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_subnet" "bastion" {
  name                 = var.bastion_subnet_name
  address_prefixes     = var.bastion_subnet_prefix
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet" "application_gateway" {
  name                 = var.application_gateway_subnet_name
  address_prefixes     = var.application_gateway_subnet_prefix
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_network_security_group" "nsg-web" {
  name = var.web_nsg_name
  location = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    access                      = "Allow"
    destination_address_prefix  = "*"
    destination_port_range      = var.web_nsg_ports[0]
    direction                   = "Inbound"
    name                        = "SSH"
    priority                    = 100
    protocol                    = "Tcp"
    source_address_prefix       = "*"
    source_port_range           = "*"
  }

  security_rule {
    access                      = "Allow"
    destination_address_prefix  = "*"
    destination_port_range      = var.web_nsg_ports[1]
    direction                   = "Inbound"
    name                        = "HTTP"
    priority                    = 150
    protocol                    = "Tcp"
    source_address_prefix       = "*"
    source_port_range           = "*"
  }
}

resource "azurerm_network_security_group" "nsg-app" {
  name = var.app_nsg_name
  location = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    access                      = "Allow"
    destination_address_prefix  = "*"
    destination_port_range      = var.app_nsg_ports[0]
    direction                   = "Inbound"
    name                        = "SSH"
    priority                    = 100
    protocol                    = "Tcp"
    source_address_prefix       = "*"
    source_port_range           = "*"
  }

  security_rule {
    access                      = "Allow"
    destination_address_prefix  = "*"
    destination_port_range      = var.app_nsg_ports[1]
    direction                   = "Inbound"
    name                        = "HTTP"
    priority                    = 150
    protocol                    = "Tcp"
    source_address_prefix       = "*"
    source_port_range           = "*"
  }
}

resource "azurerm_network_security_group" "nsg-bastion" {
  name = var.db_nsg_name
  location = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    access                      = "Allow"
    destination_address_prefix  = "*"
    destination_port_range      = "22"
    direction                   = "Inbound"
    name                        = "SSH"
    priority                    = 100
    protocol                    = "Tcp"
    source_address_prefix       = "*"
    source_port_range           = "*"
  }
}

resource "azurerm_network_security_group" "nsg-app-gateway" {
  name = var.application_gateway_nsg_name
  location = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    access                      = "Allow"
    destination_address_prefix  = "*"
    destination_port_range      = "80"
    direction                   = "Inbound"
    name                        = "HTTP"
    priority                    = 100
    protocol                    = "Tcp"
    source_address_prefix       = "*"
    source_port_range           = "*"
  }
}

resource "azurerm_network_security_group" "nsg-db" {
  name = var.bastion_nsg_name
  location = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    access                      = "Allow"
    destination_address_prefix  = "*"
    destination_port_range      = var.db_nsg_ports[0]
    direction                   = "Inbound"
    name                        = "PostgreSQL"
    priority                    = 100
    protocol                    = "Tcp"
    source_address_prefix       = "*"
    source_port_range           = "*"
  }

  security_rule {
    access                      = "Allow"
    destination_address_prefix  = "*"
    destination_port_range      = var.db_nsg_ports[1]
    direction                   = "Inbound"
    name                        = "HTTP"
    priority                    = 150
    protocol                    = "Tcp"
    source_address_prefix       = "*"
    source_port_range           = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "assoc1" {
  subnet_id                 = azurerm_subnet.web.id
  network_security_group_id = azurerm_network_security_group.nsg-web.id
}

resource "azurerm_subnet_network_security_group_association" "assoc2" {
  subnet_id                 = azurerm_subnet.app.id
  network_security_group_id = azurerm_network_security_group.nsg-app.id
}

resource "azurerm_subnet_network_security_group_association" "assoc3" {
  subnet_id                 = azurerm_subnet.db.id
  network_security_group_id = azurerm_network_security_group.nsg-db.id
}

resource "azurerm_subnet_network_security_group_association" "assoc4" {
  subnet_id                 = azurerm_subnet.bastion.id
  network_security_group_id = azurerm_network_security_group.nsg-bastion.id
}

resource "azurerm_subnet_network_security_group_association" "assoc5" {
  subnet_id                 = azurerm_subnet.application_gateway.id
  network_security_group_id = azurerm_network_security_group.nsg-app-gateway.id
}