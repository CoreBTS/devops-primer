variable "environment" {
  type = string
}
variable "rg_prefix" {
  type = string
}

variable "location" {
  type = string
}

variable "service_plan_name" {
  type = string
}

variable "service_plan_os_type" {
  type = string
}

variable "service_plan_sku_name" {
  type = string
}

variable "app_name" {
  type = string
}

variable "app_application_stack" {
  type = object({
    java_server         = string
    java_version        = string
    java_server_version = string
  })
}

variable "key_Vault_name" {
  type = string
}

variable "storage_account_name" {
  type = string
  validation {
    condition     = (
      can(regex("^[0-9A-Za-z]+$", var.storage_account_name)) &&
      length(var.storage_account_name) >= 3 &&
      length(var.storage_account_name) <= 24
    )
    error_message = "The storage account name must be between 3 and 24 alphanumeric characters"
  }
}