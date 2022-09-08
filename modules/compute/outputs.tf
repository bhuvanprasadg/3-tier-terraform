output "private_key" {
  value     = tls_private_key.pemkey.private_key_pem
  sensitive = true
}

output "web_nic_id" {
  value = azurerm_network_interface.nic2.id
}

output "web_nic_ip_config_name" {
  value = azurerm_network_interface.nic2.ip_configuration[0].name
}

output "app_nic_id" {
  value = azurerm_network_interface.nic3.id
}

output "app_nic_ip_config_name" {
  value = azurerm_network_interface.nic3.ip_configuration[0].name
}