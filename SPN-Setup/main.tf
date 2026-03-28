# Terrafrom provider configuration for Azure
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
  }
}
  provider "azurerm" {
    features {}
  }

provider "azuread" {}

# Create Azure AD App Registration
resource "azuread_application" "spn_app" {
  display_name = var.spn_name
}

#Create Service Principal for the App Registration
resource "azuread_service_principal" "spn" {
  client_id = azuread_application.spn_app.client_id
}

#create a client secret for the Service Principal
resource "azuread_service_principal_password" "spn_secret" {
  service_principal_id = azuread_service_principal.spn.id
  end_date   = var.secret_expiry # 1 year
}

#Assign the "Contributor" role to the Service Principal at the subscription level
resource "azurerm_role_assignment" "spn_contributor" {
  scope                = "/subscriptions/${var.subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.spn.id
}