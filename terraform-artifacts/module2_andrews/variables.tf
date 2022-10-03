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