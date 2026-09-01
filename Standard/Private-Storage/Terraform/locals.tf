locals {
  subnet_ids = { for s in azurerm_virtual_network.main.subnet : s.name => s.id }
}
