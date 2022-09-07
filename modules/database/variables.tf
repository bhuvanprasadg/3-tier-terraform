variable "resource_group_name" {}
variable "location" {}
variable "dbsubnet_id" {}
variable "vnet_id" {}
variable "private_dns_zone_name" {default = "sample.postgres.database.azure.com"}
variable "dns_vnet_link_name" {default = "examplevnetzone.com"}
variable "psql_server_name" {default = "sampleflexibleserver"}
variable "db_admin_username" {}
variable "db_admin_password" {}
variable "storage_mb" {default = 32768}
variable "postgres_configuration_name" {default = "azure.extensions"}
variable "database_name" {default = "sample-db"}