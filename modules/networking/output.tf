output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "websubnet_id" {
  value = azurerm_subnet.web.id
}

output "appsubnet_id" {
  value = azurerm_subnet.app.id
}

output "dbsubnet_id" {
  value = azurerm_subnet.db.id
}

output "bastionsubnet_id" {
  value = azurerm_subnet.bastion.id
}

output "application_gateway_subnet_id" {
  value = azurerm_subnet.application_gateway.id
}