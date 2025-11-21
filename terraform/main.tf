terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  # Backend para almacenar el estado de Terraform
  backend "azurerm" {
    resource_group_name   = "rg-tfstate"
    storage_account_name  = "tfstateterraform95"
    container_name        = "tfstate"
    key                   = "terraform/terraform.tfstate"
  }


}

provider "azurerm" {
  features {}
}

# Grupo de recursos
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Plan de App Service
resource "azurerm_service_plan" "plan" {
  name                = "${var.app_name}-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}

# App Service (puede usar Docker o .jar)
resource "azurerm_linux_web_app" "app" {
  name                = var.app_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
      application_stack {
        docker_image     = "${azurerm_container_registry.acr.login_server}/${var.docker_image}"
        docker_image_tag = var.docker_tag
     }
  }
  app_settings = {
    WEBSITES_PORT          = var.app_port
    SPRING_PROFILES_ACTIVE = "prod"
    USERNAME_PROD           = var.db_user
    PASSWORD_PROD           = var.db_password
    R2DBC_URL              = "r2dbc:mysql://${var.db_user}:${var.db_password}@${azurerm_mysql_flexible_server.db.fqdn}:3306/${var.app_name}"
    DOCKER_REGISTRY_SERVER_URL    = "https://${azurerm_container_registry.acr.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = var.acr_username
    DOCKER_REGISTRY_SERVER_PASSWORD = var.acr_password


  }

}

# Base de datos MySQL
resource "azurerm_mysql_flexible_server" "db" {
  name                   = "${var.app_name}-db"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  administrator_login    = var.db_user
  administrator_password = var.db_password
  sku_name               = "B_Standard_B1ms"
  version                = "8.0.21"
}

# Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                = "${var.container_name}acr"  # Debe ser único globalmente
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}
