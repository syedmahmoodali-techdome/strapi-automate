  resource "azurerm_container_registry" "acr" {
  name                = "${replace(lower(var.clinic_name), "-", "")}acr"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_linux_web_app" "app_service" {
  name                = "${lower(var.clinic_name)}-app"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id

  site_config {
    always_on = true
  }

  application_stack {
    docker_image_name   = "strapi-app:latest"
    docker_registry_url = "https://${azurerm_container_registry.acr.login_server}"
  }

  app_settings = {
    WEBSITES_PORT = "1337"
  }
}

output "cms_url" {
  value = azurerm_linux_web_app.app_service.default_hostname
}
    
output "app_service_name" {
  description = "Name of the Azure App Service"
  value       = azurerm_linux_web_app.app_service.name
}

output "acr_name" {
  value = azurerm_container_registry.acr.name
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}
