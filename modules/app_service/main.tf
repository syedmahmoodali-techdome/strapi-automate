# ===========================
# Azure App Service Plan
# ===========================
resource "azurerm_service_plan" "strapi" {
  name                = "${var.clinic_name}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.plan_sku
}

# ===========================
# Azure Container Registry (dynamic)
# ===========================
resource "azurerm_container_registry" "strapi_acr" {
  name                = "${var.clinic_name}acr"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}

# ===========================
# Azure Web App (Strapi CMS)
# ===========================
resource "azurerm_linux_web_app" "strapi" {
  name                = "${var.clinic_name}-cms"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.strapi.id

  site_config {
    application_stack {
      docker_image     = "${azurerm_container_registry.strapi_acr.login_server}/${var.clinic_name}-strapi:latest"
      docker_registry_url = azurerm_container_registry.strapi_acr.login_server
    }
  }

  app_settings = {
    NODE_ENV              = "production"
    STRAPI_ADMIN_EMAIL    = var.admin_email
    STRAPI_ADMIN_PASSWORD = var.admin_password
    DATABASE_URL          = var.db_connection_string
    LINKED_STOREFRONT_URL = var.linked_storefront_url
    BACKEND_URL           = var.backend_url
    BRAND_PRIMARY_COLOR   = var.brand_primary_color
    BRAND_SECONDARY_COLOR = var.brand_secondary_color
    BRAND_LOGO_URL        = var.brand_logo_url
    BRAND_FAVICON_URL     = var.brand_favicon_url

    # ✅ ACR auth settings for the container app
    DOCKER_REGISTRY_SERVER_URL      = azurerm_container_registry.strapi_acr.login_server
    DOCKER_REGISTRY_SERVER_USERNAME = azurerm_container_registry.strapi_acr.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = azurerm_container_registry.strapi_acr.admin_password

    PORT                     = "1337"
    WEBSITE_RUN_FROM_PACKAGE  = "0"
  }

  https_only = true
}

# ===========================
# Outputs
# ===========================
output "cms_url" {
  description = "The default hostname (URL) of the Strapi CMS web app"
  value       = azurerm_linux_web_app.strapi.default_hostname
}

output "app_service_name" {
  value = azurerm_linux_web_app.strapi.name
}

output "acr_login_server" {
  value = azurerm_container_registry.strapi_acr.login_server
}

output "acr_username" {
  value = azurerm_container_registry.strapi_acr.admin_username
}

output "acr_password" {
  value     = azurerm_container_registry.strapi_acr.admin_password
  sensitive = true
}
