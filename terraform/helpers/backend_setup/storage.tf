resource "random_string" "random_suffix" {
  length  = 17
  upper   = false
  special = false
}

resource "azurerm_storage_account" "tfstate" {
  name                            = "tfstate${random_string.random_suffix.result}"
  resource_group_name             = azurerm_resource_group.tfstate.name
  location                        = azurerm_resource_group.tfstate.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}
