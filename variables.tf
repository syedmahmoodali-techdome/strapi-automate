variable "clinic_name" {}
variable "clinic_region" {}
variable "clinic_environment" {}
variable "azure_resource_group_prefix" {}
variable "azure_app_service_plan_sku" {}  # e.g., "B1"

variable "db_name" {}
variable "db_username" {}
variable "db_password" {}

variable "strapi_repo" {}
variable "strapi_branch" {}
variable "strapi_repo_subdir" {}
variable "strapi_admin_email" {}
variable "strapi_admin_password" {}

variable "linked_storefront_url" {}
variable "backend_url" {}

variable "brand_primary_color" {}
variable "brand_secondary_color" {}
variable "brand_logo_url" {}
variable "brand_favicon_url" {}

variable "github_token" {}
