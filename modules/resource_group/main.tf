resource "azurerm_resource_group" "this" {
  name = "${var.name_prefix}-${var.environment}-rg" 
  location = var.location
}

output "name" {
  value = azurerm_resource_group.this.name  
}