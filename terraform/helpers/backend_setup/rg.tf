resource "azurerm_resource_group" "tfstate" {
  name     = "tfstate"
  location = var.location
}
