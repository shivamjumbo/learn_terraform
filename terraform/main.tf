terraform {
  backend "azurerm" {
    # sas_token and storage_account_name are sent via parameters
    container_name = "terraformstate"
    key            = "azure-devops-test-setup.tfstate"
  }
}

provider "azurerm" {
  # subscription_id needs to be specified as parameter or environment variable
  features {
    key_vault {}
  }
}