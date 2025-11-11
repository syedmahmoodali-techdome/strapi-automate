variable "name_prefix" {
  type        = string
  description = "prefix to use in resource group name"
}

variable "environment" {
  type        = string
  description = "environment name (staging/prod)"
}

variable "location" {
  type        = string
  description = "Azure region"
}

resource "azurerm_resource_group" "this" {
  name     = "${var.name_prefix}-${var.environment}-strapi-cms-rg"
  location = var.location
}

output "name" {
  value = azurerm_resource_group.this.name
}

output "resource_group_name" {
  value = azurerm_resource_group.this.name
}
