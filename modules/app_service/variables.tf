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

# Database
variable "db_host" {
  type        = string
  description = "Database host"
}

variable "db_port" {
  type        = number
  description =
