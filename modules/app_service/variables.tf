variable "clinic_name" {
  description = "Clinic name"
  type        = string
}

variable "resource_group_name" {
  description = "Azure resource group name"
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

variable "strapi_admin_email" {
  description = "Admin email for Strapi"
  type        = string
}

variable "strapi_admin_password" {
  description = "Admin password for Strapi"
  type        = string
  sensitive   = true
}

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

variable "brand_primary_color" {
  description = "Primary brand color"
  type        = string
  default     = "#000000"
}

variable "brand_secondary_color" {
  description = "Secondary brand color"
  type        = string
  default     = "#FFFFFF"
}

variable "brand_logo_url" {
  description = "Brand logo URL"
  type        = string
  default     = ""
}

variable "brand_favicon_url" {
  description = "Brand favicon URL"
  type        = string
  default     = ""
}
