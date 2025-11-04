resource "azurerm_service_plan" "this" {
  name = "${var.resource_group_name}-plan"
  location = var.location
  resource_group_name = var.resource_group_name
  sku_name = var.plan_sku
  os_type = "Linux"
}

resource "azurerm_linux_web_app" "this" {
  name = "${var.clinic_name}-cms"
  resource_group_name = var.resource_group_name
  location = var.location
  service_plan_id = azurerm_service_plan.this.id

  site_config {
    application_stack {
      node_version = "18-lts"
    }
  }

  app_settings = {
    DATABASE_URL = var.db_connection_string
    STRAPI_ADMIN_EMAIL = var.admin_email
    STRAPI_ADMIN_PASSWORD = var.admin_password
    LINKED_STOREFRONT_URL = var.linked_storefront_url
    BACKEND_URL = var.backend_url
    BRAND_PRIMARY_COLOR = var.brand_primary_color
    BRAND_SECONDARY_COLOR = var.brand_secondary_color
    BRAND_LOGO_URL = var.brand_logo_url
    BRAND_FAVICON_URL = var.brand_favicon_url
    NODE_ENV = "production"
    WEBSITES_PORT = "1337"
  }

  https_only = true
}

# Configure source control so App Service pulls the repo (public repo OK).
# If the repo is private you must supply authentication or use a different deployment method.
resource "azurerm_app_service_source_control" "sc" {
  app_id = azurerm_linux_web_app.this.id
  repo_url = var.repo_url
  branch = var.repo_branch
}

output "cms_url" {
  value = azurerm_linux_web_app.this.default_hostname
}