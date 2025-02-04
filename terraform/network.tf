resource "azurerm_virtual_network" "vnet_shared_westeu_001" {
  name                = "vnet-shared-westeu-001"
  location            = azurerm_resource_group.rg_candidate_test_001.location
  resource_group_name = azurerm_resource_group.rg_candidate_test_001.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "snet_shared_westeu_001" {
  name                 = "snet-shared-westeu-001"
  resource_group_name  = azurerm_resource_group.rg_candidate_test_001.name
  virtual_network_name = azurerm_virtual_network.vnet_shared_westeu_001.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "pip_candidate_test_westeu_001" {
  name                = "pip-candidate-test-westeu-001"
  location            = azurerm_resource_group.rg_candidate_test_001.location
  resource_group_name = azurerm_resource_group.rg_candidate_test_001.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic_01_candidate_test_001" {
  name                = "nic-01-candidate-test-001"
  location            = azurerm_resource_group.rg_candidate_test_001.location
  resource_group_name = azurerm_resource_group.rg_candidate_test_001.name

  ip_configuration {
    name                          = "primary"
    subnet_id                     = azurerm_subnet.snet_shared_westeu_001.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip_candidate_test_westeu_001.id
  }
}

resource "azurerm_network_security_group" "nsg_candidate_test_001" {
  name                = "nsg-candidate-test-001"
  location            = azurerm_resource_group.rg_candidate_test_001.location
  resource_group_name = azurerm_resource_group.rg_candidate_test_001.name

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowSSH"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_association_candidate_test_001" {
  network_interface_id      = azurerm_network_interface.nic_01_candidate_test_001.id
  network_security_group_id = azurerm_network_security_group.nsg_candidate_test_001.id
}
