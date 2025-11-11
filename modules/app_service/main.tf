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

  # ✅ Managed ACR integration
  container_registry_use_managed_identity = true
  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_stack {
      docker_image_name   = "${var.image_name}:${var.image_tag}"
      docker_registry_url = azurerm_container_registry.acr.login_server
    }

    always_on = true
  }

  app_settings = {
    WEBSITES_PORT       = "1337"
    NODE_ENV            = "production"

    # Database configuration
    DATABASE_CLIENT     = "postgres"
    DATABASE_HOST       = var.db_host
    DATABASE_PORT       = "5432"
    DATABASE_NAME       = var.db_name
    DATABASE_USERNAME   = var.db_user
    DATABASE_PASSWORD   = var.db_password

    # Strapi credentials
    STRAPI_ADMIN_EMAIL    = var.strapi_admin_email
    STRAPI_ADMIN_PASSWORD = var.strapi_admin_password

    # Strapi secrets
    APP_KEYS            = var.app_keys
    API_TOKEN_SALT      = var.api_token_salt
    ADMIN_JWT_SECRET    = var.admin_jwt_secret
    TRANSFER_TOKEN_SALT = var.transfer_token_salt

    # Linked URLs
    LINKED_STOREFRONT_URL = var.linked_storefront_url
  }

  lifecycle {
    ignore_changes = [
      app_settings["DOCKER_REGISTRY_SERVER_URL"],
      app_settings["DOCKER_REGISTRY_SERVER_USERNAME"],
      app_settings["DOCKER_REGISTRY_SERVER_PASSWORD"]
    ]
  }
}

# 🔗 Grant the Web App access to ACR
resource "azurerm_role_assignment" "acr_pull" {
  principal_id         = azurerm_linux_web_app.app_service.identity[0].principal_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id
}

# Outputs
output "app_service_name" {
  value = azurerm_linux_web_app.app_service.name
}

output "cms_url" {
  value = azurerm_linux_web_app.app_service.default_hostname
}

output "acr_name" {
  value = azurerm_container_registry.acr.name
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}
