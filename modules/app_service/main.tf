resource "azurerm_service_plan" "strapi" {
  name                = "${lower(var.clinic_name)}-plan"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  sku_name = var.azure_app_service_plan_sku
  os_type  = "Linux"
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
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  service_plan_id     = azurerm_service_plan.strapi.id

  site_config {
    always_on = true
  }

  app_settings = {
    WEBSITES_PORT = "1337"
  }
}

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
