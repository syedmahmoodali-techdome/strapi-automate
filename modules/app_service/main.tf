resource "azurerm_container_registry" "acr" {
  name                = "${var.clinic_name}acr"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_linux_web_app" "app_service" {
  name                = "${var.clinic_name}-app"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id

  site_config {
    always_on = true
    linux_fx_version = "DOCKER|${azurerm_container_registry.acr.login_server}/strapi-app:latest"
  }

  app_settings = {
    WEBSITES_PORT                     = "1337"
    DOCKER_REGISTRY_SERVER_URL        = "https://${azurerm_container_registry.acr.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME   = azurerm_container_registry.acr.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD   = azurerm_container_registry.acr.admin_password
  }
}

output "acr_name" {
  value = azurerm_container_registry.acr.name
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "cms_url" {
  description = "The URL of the deployed Strapi CMS"
  value       = azurerm_linux_web_app.app_service.default_hostname
}

output "app_service_name" {
  description = "The name of the Azure App Service"
  value       = azurerm_linux_web_app.app_service.name
}
