resource "azurerm_resource_group" "this" {
  name = "${var.name_prefix}-${var.environment}-rg-ali" 
  location = var.location
}

output "name" {
  value = azurerm_resource_group.this.name  
}
