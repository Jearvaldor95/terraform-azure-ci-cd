output "app_service_url" {
  description = "URL del App Service"
  value       = azurerm_linux_web_app.app.default_hostname
}

output "mysql_endpoint" {
  description = "Endpoint de la base de datos MySQL"
  value       = azurerm_mysql_flexible_server.db.fqdn
}

output "acr_login_server" {
description = "URL login_server"
  value = azurerm_container_registry.acr.login_server
}

output "acr_username" {
description = "ACR username"
  value = azurerm_container_registry.acr.admin_username
}

output "acr_password" {
description = "ACR password"
  value = azurerm_container_registry.acr.admin_password
  sensitive  = true
}

