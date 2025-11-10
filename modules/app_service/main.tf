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
  reserved            = true  # Required for Linux

  sku_name = var.azure_app_service_plan_sku # e.g., "B1", "B2"
  os_type  = "Linux"
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
}

# -------------------------------
# Outputs
# -------------------------------
output "cms_url" {
  description = "Public URL of the Strapi CMS"
  value       = azurerm_linux_web_app.app_service.default_hostname
}

output "app_service_name" {
  description = "Name of the Azure App Service"
  value       = azurerm_linux_web_app.app_service.name
}

output "acr_name" {
  description = "Name of the Azure Container Registry"
  value       = azurerm_container_registry.acr.name
}

output "acr_login_server" {
  description = "Login server URL of the Azure Container Registry"
  value       = azurerm_container_registry.acr.login_server
}
