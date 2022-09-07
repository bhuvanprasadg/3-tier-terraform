resource "azurerm_private_dns_zone" "dns_zone" {
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_vnet" {
  name                  = var.dns_vnet_link_name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = var.vnet_id
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone.name
}

resource "azurerm_postgresql_flexible_server" "psql" {
  name                   = var.psql_server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = "12"
  delegated_subnet_id    = var.dbsubnet_id
  private_dns_zone_id    = azurerm_private_dns_zone.dns_zone.id
  administrator_login    = var.db_admin_username
  administrator_password = var.db_admin_password
  zone                   = "1"
  storage_mb             = var.storage_mb
  sku_name               = "GP_Standard_D4s_v3"

  depends_on             = [azurerm_private_dns_zone_virtual_network_link.dns_vnet]
}

resource "azurerm_postgresql_flexible_server_configuration" "postgres_server" {
  name      = var.postgres_configuration_name
  server_id = azurerm_postgresql_flexible_server.psql.id
  value     = "CUBE,CITEXT,BTREE_GIST"
}

resource "azurerm_postgresql_flexible_server_database" "name" {
  name      = var.database_name
  server_id = azurerm_postgresql_flexible_server.psql.id
  collation = "en_US.utf8"
  charset   = "utf8"
}