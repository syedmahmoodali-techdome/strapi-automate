output "cms_url" {
  description = "The default hostname (URL) of the Strapi CMS web app"
  value       = azurerm_linux_web_app.strapi.default_hostname
}

output "app_service_name" {
  value = azurerm_linux_web_app.strapi.name
}
