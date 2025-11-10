  output "cms_url" {
    description = "URL of the deployed Strapi CMS"
    value       = module.app_service.cms_url
  } 
   
  output "cms_admin_email" {
    description = "email configured for Strapi"
    value       = var.strapi_admin_email
  }
  
  output "cms_admin_password" {
    description = "password for CMS login"
    value       = var.strapi_admin_password
    sensitive   = true
  }
  
  output "linked_storefront_url" {
    description = "Storefront URL integrated with CMS"
    value       = var.linked_storefront_url
  }
  
  output "resource_group" {
    description = "Azure resource group for deployment"
    value       = module.resource_group.name
  }
  
  output "resource_group_name" {
    value = module.resource_group.resource_group_name
  }
  
  output "environment" {
    description = "Environment type"
    value       = var.clinic_environment
  }
  
  output "app_service_name" {
    value = module.app_service.app_service_name
  }
  
  output "acr_name" {
    value = module.app_service.acr_name
  }
  
  output "acr_login_server" {
    value = module.app_service.acr_login_server
  }
  
  output "db_host" {
    description = "PostgreSQL FQDN"
    value       = module.database.db_fqdn
  }
  
  output "db_fqdn" {
    value = module.database.db_fqdn
  }
  
  output "db_username" {
    value = module.database.db_username
  }
  
  output "db_connection_string" {
    value = module.database.connection_string
    sensitive = true
  }
  
  output "db_name" {
    description = "Database name"
    value       = module.database.db_name
  }
  
  output "db_user" {
    description = "Database username"
    value       = module.database.db_username
  }
  
  output "db_password" {
    description = "Database password"
    value       = module.database.db_password
    sensitive   = true
  }
