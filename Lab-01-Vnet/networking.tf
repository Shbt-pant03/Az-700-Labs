# Create a Virtual Network Vnet - Hub
resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnet1_name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.1.0.0/16"]
  resource_group_name = azurerm_resource_group.rg.name
}

# Vnet1 - Subnet1
resource "azurerm_subnet" "vnet1_subnet1" {
  name                 = "snet-frontend"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.1.1.0/24"]
}

# Vnet1 - Subnet2
resource "azurerm_subnet" "vnet1_subnet2" {
  name                 = "snet-backend"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.1.2.0/24"]
}

#Create Network Security Group for Subnet1 of Vnet1
resource "azurerm_network_security_group" "nsg_vnet1_subnet1" {
  name                = "nsg-vnet1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Allow-RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-http"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}