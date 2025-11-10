variable "clinic_name" {}
variable "clinic_environment" {}
variable "clinic_region" {}

variable "strapi_repo" {}
variable "strapi_branch" {}
variable "strapi_repo_subdir" {}
variable "strapi_admin_email" {}
variable "strapi_admin_password" {
  sensitive = true
}

variable "db_name" {}
variable "db_username" {}
variable "db_password" {
  sensitive = true
}

variable "azure_resource_group_prefix" {}
variable "azure_app_service_plan_sku" {
  type        = string
  description = "SKU name for the Azure App Service Plan"
  default     = "B1"
}

variable "linked_storefront_url" {}
variable "backend_url" {}

variable "github_token" {
  description = "GitHub personal access token used to clone private repositories"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "Central India"
}



#variable "github_token" {
#  description = "GitHub Personal Access Token"
#  sensitive   = true
#}


# branding
variable "brand_primary_color" {}
variable "brand_secondary_color" {}
variable "brand_logo_url" {}
variable "brand_favicon_url" {}
