#########################################
# Core Infrastructure Variables
#########################################

variable "service_plan_id" {
  description = "ID of the App Service plan"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resources are deployed"
  type        = string
}

variable "clinic_name" {
  description = "Name of the clinic or environment used for naming resources"
  type        = string
}

#########################################
# Container & Deployment Variables
#########################################

variable "image_name" {
  description = "Docker image name for Strapi"
  type        = string
}

variable "image_tag" {
  description = "Docker image tag for Strapi"
  type        = string
}

#########################################
# Database Configuration
#########################################

variable "db_host" {
  description = "Database host or FQDN"
  type        = string
}

variable "db_name" {
  description = "Database name for Strapi"
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

#########################################
# Strapi Admin & Secrets
#########################################

variable "strapi_admin_email" {
  description = "Email for Strapi admin user"
  type        = string
}

variable "strapi_admin_password" {
  description = "Password for Strapi admin user"
  type        = string
  sensitive   = true
}

variable "app_keys" {
  description = "APP_KEYS for Strapi"
  type        = string
}

variable "api_token_salt" {
  description = "API_TOKEN_SALT for Strapi"
  type        = string
}

variable "admin_jwt_secret" {
  description = "Admin JWT secret used by Strapi"
  type        = string
}

variable "transfer_token_salt" {
  description = "Transfer token salt for Strapi"
  type        = string
}

#########################################
# Branding & Frontend Integration
#########################################

variable "linked_storefront_url" {
  description = "Storefront URL linked with the Strapi CMS"
  type        = string
}

variable "brand_primary_color" {
  description = "Primary brand color used in CMS branding"
  type        = string
}

variable "brand_secondary_color" {
  description = "Secondary brand color used in CMS branding"
  type        = string
}

variable "brand_logo_url" {
  description = "Logo URL for CMS branding"
  type        = string
}

variable "brand_favicon_url" {
  description = "Favicon URL for CMS branding"
  type        = string
}

#########################################
# GitHub / Source Control
#########################################

variable "repo_url" {
  description = "Repository URL containing the Dockerfile or source"
  type        = string
}

variable "repo_branch" {
  description = "Repository branch to deploy"
  type        = string
}

variable "repo_subdir" {
  description = "Optional subdirectory for the Strapi app in repo"
  type        = string
  default     = ""
}

variable "github_token" {
  description = "GitHub token for accessing private repositories"
  type        = string
  sensitive   = true
}

#########################################
# Optional Environment Settings
#########################################

variable "backend_url" {
  description = "Backend API base URL"
  type        = string
}

variable "plan_sku" {
  description = "SKU tier of the App Service Plan"
  type        = string
}
