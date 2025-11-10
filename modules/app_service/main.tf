# modules/app_service/main.tf
resource "azurerm_service_plan" "app_plan" {
  name                = "${lower(var.clinic_name)}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name

  kind     = "Linux"
  reserved = true

  sku_name = var.azure_app_service_plan_sku
}

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
  service_plan_id     = azurerm_service_plan.app_plan.id

  site_config {
    always_on = true
  }

  app_settings = {
    WEBSITES_PORT = "1337"
  }
}

# outputs.tf
output "cms_url" {
  value = azurerm_linux_web_app.app_service.default_hostname
}

output "app_service_name" {
  value = azurerm_linux_web_app.app_service.name
}

output "acr_name" {
  value = azurerm_container_registry.acr.name
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}
