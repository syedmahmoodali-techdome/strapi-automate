###########################################
# app_service Module Variables
###########################################

# Basic info
variable "clinic_name" {
  description = "Clinic name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "service_plan_id" {
  description = "App Service Plan ID"
  type        = string
}

# Container image
variable "image_name" {
  description = "Docker image name for Strapi"
  type        = string
}

variable "image_tag" {
  description = "Docker image tag for Strapi"
  type        = string
}

# Database configuration
variable "db_host" {
  description = "Database host"
  type        = string
}

variable "db_port" {
  description = "Database port"
  type        = number
  default     = 5432
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_user" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

# Strapi admin
variable "strapi_admin_email" {
  description = "Admin email for Strapi CMS"
  type        = string
}

variable "strapi_admin_password" {
  description = "Admin password for Strapi CMS"
  type        = string
  sensitive   = true
}

# Secrets
variable "app_keys" {
  description = "Strapi APP_KEYS"
  type        = string
  sensitive   = true
}

variable "api_token_salt" {
  description = "Strapi API_TOKEN_SALT"
  type        = string
  sensitive   = true
}

variable "admin_jwt_secret" {
  description = "Strapi ADMIN_JWT_SECRET"
  type        = string
  sensitive   = true
}

variable "transfer_token_salt" {
  description = "Strapi TRANSFER_TOKEN_SALT"
  type        = string
  sensitive   = true
}

# Optional integrations
variable "linked_storefront_url" {
  description = "Linked storefront URL"
  type        = string
  default     = ""
}

variable "backend_url" {
  description = "Backend URL"
  type        = string
  default     = ""
}

variable "github_token" {
  description = "GitHub PAT for deployment"
  type        = string
  sensitive   = true
  default     = ""
}

# Branding
variable "brand_primary_color" {
  type        = string
  description = "Primary brand color"
  default     = ""
}

variable "brand_secondary_color" {
  type        = string
  description = "Secondary brand color"
  default     = ""
}

variable "brand_logo_url" {
  type        = string
  description = "Logo URL"
  default     = ""
}

variable "brand_favicon_url" {
  type        = string
  description = "Favicon URL"
  default     = ""
}

# Metadata
variable "plan_sku" {
  description = "Azure App Service Plan SKU"
  type        = string
}

variable "repo_url" {
  description = "Strapi repository URL"
  type        = string
}

variable "repo_branch" {
  description = "Branch to deploy from"
  type        = string
}

variable "repo_subdir" {
  description = "Subdirectory within repo"
  type        = string
  default     = ""
}
