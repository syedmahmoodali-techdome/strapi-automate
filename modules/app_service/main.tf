# -------------------------------
# Azure Container Registry (ACR)
# -------------------------------
resource "azurerm_container_registry" "acr" {
  name                = "${replace(lower(var.clinic_name), "-", "")}acr"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}

# -------------------------------
# Azure App Service Plan (Linux)
# -------------------------------
resource "azurerm_service_plan" "app_plan" {
  name                = "${lower(var.clinic_name)}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

# -------------------------------
# Azure Linux Web App (App Service)
# -------------------------------
resource "azurerm_linux_web_app" "app_service" {
  name                = "${lower(var.clinic_name)}-app"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.app_plan.id

  site_config {
    linux_fx_version = "DOCKER|${azurerm_container_registry.acr.login_server}/strapi-app:latest"
    always_on        = true
  }

  app_settings = {
    WEBSITES_PORT                   = "1337"
    DOCKER_REGISTRY_SERVER_URL      = "https://${azurerm_container_registry.acr.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = azurerm_container_registry.acr.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = azurerm_container_registry.acr.admin_password
  }

  depends_on = [azurerm_service_plan.app_plan, azurerm_container_registry.acr]
}

# -------------------------------
# Outputs
# -------------------------------
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
  
