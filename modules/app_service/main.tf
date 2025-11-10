# ===========================
# Azure Container Registry
# ===========================
resource "azurerm_container_registry" "strapi_acr" {
  name                = "${var.clinic_name}acr"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}

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
# Azure Web App (Container)
# ===========================
resource "azurerm_linux_web_app" "app_service" {
  name                = "${var.clinic_name}-cms"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.strapi.id

  site_config {
    always_on = true
    application_stack {
      docker_image_name = "placeholder" # updated by workflow
      docker_registry_url = "https://${azurerm_container_registry.strapi_acr.login_server}"
    }
  }

  app_settings = {
    WEBSITES_PORT = "1337"
    NODE_ENV      = "production"
  }

  https_only = true
}

# ===========================
# Outputs
# ===========================

output "cms_url" {
  value = azurerm_linux_web_app.app_service.default_hostname
  description = "The default hostname of the deployed app service."
}

output "app_service_name" {
  value = azurerm_linux_web_app.strapi.name
}

output "resource_group_name" {
  value = var.resource_group_name
}

output "acr_name" {
  value = azurerm_container_registry.strapi_acr.name
}
