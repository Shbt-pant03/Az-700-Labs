# Create Private DNS Zone, named Shobhitbhai.com, and link it to Vnet1
resource "azurerm_private_dns_zone" "dns_zone" {
  name                = "shbtcool.com"
  resource_group_name = azurerm_resource_group.rg.name
} 

resource "azurerm_private_dns_zone_virtual_network_link" "dns_zone_vnet1_link" {
  name                  = "dns-zone-vnet1-link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet1.id
}

