variable "resource_group_name" {}
variable "location" {}
variable "plan_sku" {}
variable "clinic_name" {}
variable "repo_branch" {}
variable "repo_subdir" {}
variable "admin_email" {}
variable "admin_password" {
  sensitive = true
}
variable "db_connection_string" {
  sensitive = true
}
variable "linked_storefront_url" {}
variable "backend_url" {}
variable "brand_primary_color" {}
variable "brand_secondary_color" {}
variable "brand_logo_url" {}
variable "brand_favicon_url" {}

variable "github_token" {
  description = "GitHub Personal Access Token"
  sensitive   = true
}

variable "repo_url" {
  description = "GitHub repository URL for the Strapi source"
  type        = string
}

variable "branch" {
  description = "Branch name for deployment"
  type        = string
  default     = "main"
}

variable "service_plan_id" {
  description = "The ID of the Azure App Service plan where the app will be deployed"
  type        = string
}

variable "azure_app_service_plan_sku" {
  type        = string
  description = "SKU name for the Azure App Service Plan, e.g., B1, B2"
  default     = "B1" # Optional default
}
