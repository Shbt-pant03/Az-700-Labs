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

# Create Network Security Group for Subnet2 of Vnet1
resource "azurerm_network_security_group" "nsg_vnet1_subnet2" {
  name                = "nsg-vnet1-subnet2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
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

#Associate NSG with Subnet 2 of Vnet1
resource "azurerm_subnet_network_security_group_association" "nsg_assoc_vnet1_subnet2" {
  subnet_id                 = azurerm_subnet.vnet1_subnet2.id
  network_security_group_id = azurerm_network_security_group.nsg_vnet1_subnet2.id
} 

# Create a NAT Gateway and Public IP for NAT Gateway and associate with Subnet2 of Vnet1
resource "azurerm_public_ip" "pip_natgw1" {
  name                = "pip-natgw1-lab01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "natgw1" {
  name                = "natgw1-lab01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "Standard"

}
# Associate Public IP with NAT Gateway
resource "azurerm_nat_gateway_public_ip_association" "natgw_pip_assoc" {
  nat_gateway_id = azurerm_nat_gateway.natgw1.id
  public_ip_address_id   = azurerm_public_ip.pip_natgw1.id
}



resource "azurerm_subnet_nat_gateway_association" "natgw_assoc_vnet1_subnet2" {
  subnet_id      = azurerm_subnet.vnet1_subnet2.id
  nat_gateway_id = azurerm_nat_gateway.natgw1.id
}



