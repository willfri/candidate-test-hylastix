output "vm_public_ip_address" {
  value = azurerm_linux_virtual_machine.vm_candidate_test_001.public_ip_address
}

output "vm_password" {
  value     = azurerm_linux_virtual_machine.vm_candidate_test_001.admin_password
  sensitive = true
}
