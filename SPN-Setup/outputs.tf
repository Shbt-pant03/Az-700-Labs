output "client_id" {
  value = azuread_application.spn_app.client_id
    description = "SPN Client ID - needed for authentication"
}

output "client_secret" {
  value = azuread_service_principal_password.spn_secret.value
    description = "SPN Client Secret - needed for authentication"
    sensitive = true
}

output "tenant_id" {
  value = azuread_service_principal.spn.application_tenant_id       
    description = "Azure Tenant ID"
}