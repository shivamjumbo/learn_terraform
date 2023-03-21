locals {
  common_tags = {
    "ApplicationName"  = "AzDevOpsTestSetup",
    "Environment"      = var.environment,
    "TeamName"         = "APSLM",
    "TeamContactMail"  = "apslastmile@jumbo.com",
    "Project_Change"   = "APSLM-917",
    "TerraformManaged" = "true",
    "Description"      = "Testing Azure DevOps pipelines and setup"
  }
}

resource "azurerm_resource_group" "azure_devops_test_setup" {
  name     = "servicebus-dev-aps-rg"
  location = "westeurope"

  tags = local.common_tags
}

resource "azurerm_servicebus_namespace" "test_service_bus_namespace" {
  name                = "sap-adapter-orders-${var.environment}"
  location            = azurerm_resource_group.azure_devops_test_setup.location
  resource_group_name = azurerm_resource_group.azure_devops_test_setup.name
  sku                 = "Standard"

  tags = local.common_tags
}

resource "azurerm_servicebus_queue" "service_bus_queue" {
  name         = "sap-adapter-orders-${var.environment}-sbq-tos"
  namespace_id = azurerm_servicebus_namespace.test_service_bus_namespace.id

  enable_partitioning = true
}

# resource "azurerm_resource_group" "azure_devops_test_setup" {
#   name     = "azure-devops-test-setup"
#   location = "westeurope"

#   tags = local.common_tags
# }


# resource "azurerm_storage_account" "test_setup_storage" {
#   name                            = "azdevopstestsetup${var.environment}abc"
#   resource_group_name             = azurerm_resource_group.azure_devops_test_setup.name
#   location                        = azurerm_resource_group.azure_devops_test_setup.location
#   account_tier                    = "Standard"
#   account_replication_type        = "LRS"
#   allow_nested_items_to_be_public = false # policy

#   tags = local.common_tags # policy
# }


# this will fail, but goal is to see if its accessible
# module "az_function" {
#   source              = "git::https://github.com/jumbo-supermarkten/terraform-module-az-function.git?ref=development"
#   name                = "azure-devops-test-setup-func"
#   resource_group_name = azurerm_resource_group.azure_devops_test_setup.name
#   # create_package      = true
#   # package_directory   = "${path.root}/../function"

#   function_extension_version = "~4"
#   tags                       = local.common_tags
#   app_settings = {
#     "ENV"                 = "Azure"
#   }

#   # depends_on = [data.external.create_func_archive]
# }
