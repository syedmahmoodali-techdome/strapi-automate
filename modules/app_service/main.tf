# Create App Service Plan
resource "azurerm_service_plan" "strapi" {
  name                = "${var.clinic_name}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.plan_sku
}

resource "azurerm_linux_web_app" "strapi" {
  name                = "${var.clinic_name}-cms"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.strapi.id

  site_config {
    linux_fx_version = "NODE|18-lts"
  }

  app_settings = {
    NODE_ENV                = "production"
    STRAPI_ADMIN_EMAIL      = var.admin_email
    STRAPI_ADMIN_PASSWORD   = var.admin_password
    DATABASE_URL            = var.db_connection_string
    LINKED_STOREFRONT_URL   = var.linked_storefront_url
    BACKEND_URL             = var.backend_url
    BRAND_PRIMARY_COLOR     = var.brand_primary_color
    BRAND_SECONDARY_COLOR   = var.brand_secondary_color
    BRAND_LOGO_URL          = var.brand_logo_url
    BRAND_FAVICON_URL       = var.brand_favicon_url
  }
}

# Setup GitHub deployment source
resource "azurerm_app_service_source_control" "github" {
  app_id             = azurerm_linux_web_app.strapi.id
  repo_url           = var.repo_url
  branch             = var.repo_branch
  use_manual_integration = true
  github_action_configuration {
    code_configuration {
      code_configuration_source = "GitHub"
      runtime_stack             = "node"
    }
  }
  token = var.github_token
}
