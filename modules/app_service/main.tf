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
# Azure Web App
# ===========================

resource "azurerm_linux_web_app" "strapi" {
  name                = "${var.clinic_name}-cms"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.strapi.id

  site_config {}

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
  }
}

# ===========================
# GitHub Token for Source Control
# ===========================

resource "azurerm_app_service_source_control_token" "github" {
  type  = "GitHub"
  token = var.github_token
}

# ===========================
# Connect Web App to GitHub Repo
# ===========================

resource "azurerm_app_service_source_control" "github" {
  app_id                 = azurerm_linux_web_app.strapi.id
  repo_url               = var.repo_url
  branch                 = var.repo_branch
  use_manual_integration = false  
  rollback_enabled       = true

  github_action_configuration {
    generate_workflow_file = false
    code_configuration {
      runtime_stack   = "node"
      runtime_version = "18.x"
      code_path       = var.repo_subdir != "" ? var.repo_subdir : "."  # 👈 this is the fix
    }
  }

  depends_on = [
    azurerm_app_service_source_control_token.github
  ]
}
