locals {
  app_kv_secret_url = "${azurerm_key_vault.app_kv.vault_uri}secrets/${azurerm_key_vault_secret.app_kv_secret.name}/${azurerm_key_vault_secret.app_kv_secret.version}"
}