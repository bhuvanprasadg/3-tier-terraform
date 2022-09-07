output "private_key" {
  value     = tls_private_key.pemkey.private_key_pem
  sensitive = true
}

output "web_nic_id" {
  value = azurerm_network_interface.nic2.id
}