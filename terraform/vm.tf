resource "random_password" "vm_password" {
  length      = 16
  min_lower   = 1
  min_upper   = 1
  min_special = 1
  min_numeric = 1
}

resource "azurerm_linux_virtual_machine" "vm_candidate_test_001" {
  name                = "vm-candidate-test-001"
  location            = azurerm_resource_group.rg_candidate_test_001.location
  resource_group_name = azurerm_resource_group.rg_candidate_test_001.name
  size                = "Standard_B1ms"

  admin_username                  = "azureuser"
  admin_password                  = random_password.vm_password.result
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nic_01_candidate_test_001.id,
  ]

  source_image_reference {
    publisher = "canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  os_disk {
    caching              = "None"
    storage_account_type = "Standard_LRS"
  }
}
