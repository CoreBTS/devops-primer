resource "azurerm_resource_group" "app_rg" {
  name     = "${var.rg_prefix}-${var.environment}-rg01"
  location = var.location
}

resource "azurerm_service_plan" "app_service_plan" {
  name                = var.service_plan_name
  resource_group_name = azurerm_resource_group.app_rg.name
  location            = azurerm_resource_group.app_rg.location
  os_type             = var.service_plan_os_type
  sku_name            = var.service_plan_sku_name
}

resource "azurerm_linux_web_app" "app" {
  depends_on = [
    azurerm_key_vault_secret.app_kv_secret
  ]
  name                = var.app_name
  resource_group_name = azurerm_resource_group.app_rg.name
  location            = azurerm_service_plan.app_service_plan.location
  service_plan_id     = azurerm_service_plan.app_service_plan.id
  app_settings = {
    KEY_VAULT_SETTING = "@Microsoft.KeyVault(SecretUri=${local.app_kv_secret_url})"
  }

  site_config {
    application_stack {
      java_server         = "JAVA"
      java_version        = "java17"
      java_server_version = "17"
    }
  }

  identity {
    type = "SystemAssigned"
  }
}

data "azurerm_linux_web_app" "data_app" {
  name                = azurerm_linux_web_app.app.name
  resource_group_name = azurerm_resource_group.app_rg.name
}
output "app_url" {
  value = "https://${data.azurerm_linux_web_app.data_app.default_hostname}"
}

data "azurerm_client_config" "current" {}

resource "random_password" "app_kv_secret" {
  length  = 12
  special = true
}

resource "azurerm_key_vault" "app_kv" {
  name                = var.key_Vault_name
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name                        = "standard"
  enabled_for_template_deployment = true
}

resource "azurerm_key_vault_access_policy" "client_access_policy" {
  key_vault_id = azurerm_key_vault.app_kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get",
    "Set"
  ]
}

resource "azurerm_key_vault_access_policy" "app_access_policy" {
  key_vault_id = azurerm_key_vault.app_kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_linux_web_app.data_app.identity[0].principal_id

  secret_permissions = [
    "Get"
  ]
}

resource "azurerm_key_vault_secret" "app_kv_secret" {
  name         = var.app_name
  value        = random_password.app_kv_secret.result
  key_vault_id = azurerm_key_vault.app_kv.id
  depends_on = [
    azurerm_key_vault_access_policy.client_access_policy
  ]
}