environment = "prod"
rg_prefix   = "as-devops_primer-module2"
location    = "centralus"

service_plan_name     = "as-module2-asp01"
service_plan_os_type  = "Linux"
service_plan_sku_name = "S1"
app_name              = "as-module2-app01"
app_application_stack = ({
  java_server         = "JAVA"
  java_version        = "java17"
  java_server_version = "17"
})

key_Vault_name = "as-module2-kv01"

storage_account_name = "ascoredevopsprimerp001"