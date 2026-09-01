resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "logic_app" {
  name                          = var.storage_account_name
  resource_group_name           = azurerm_resource_group.main.name
  location                      = azurerm_resource_group.main.location
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  public_network_access_enabled = false
  https_traffic_only_enabled    = true

  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
  }
}

resource "azurerm_storage_share" "logic_app_content" {
  name               = var.file_share_name
  storage_account_id = azurerm_storage_account.logic_app.id
  quota              = 50
}

resource "azurerm_virtual_network" "main" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  subnet {
    name             = "logic-app-integration-subnet"
    address_prefixes = ["10.0.1.0/24"]

    delegation {
      name = "delegation"
      service_delegation {
        name = "Microsoft.Web/serverFarms"
      }
    }
  }

  subnet {
    name             = "logic-app-pe-subnet"
    address_prefixes = ["10.0.2.0/24"]
  }

  subnet {
    name             = "storage-subnet"
    address_prefixes = ["10.0.3.0/24"]
  }
}



resource "azurerm_private_dns_zone" "file" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "file" {
  name                = "file_link"
  private_dns_zone_id = azurerm_private_dns_zone.file.id
  virtual_network_id  = azurerm_virtual_network.main.id
}

resource "azurerm_private_endpoint" "file" {
  depends_on          = [azurerm_storage_account.logic_app]
  name                = "${var.storage_account_name}-file"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_id           = local.subnet_ids["storage-subnet"]

  private_service_connection {
    name                           = "${var.storage_account_name}-file"
    private_connection_resource_id = azurerm_storage_account.logic_app.id
    is_manual_connection           = false
    subresource_names              = ["file"]
  }
}

resource "azurerm_private_dns_a_record" "file" {
  name                = azurerm_storage_account.logic_app.name
  private_dns_zone_id = azurerm_private_dns_zone.file.id
  ttl                 = 300
  records             = [azurerm_private_endpoint.file.private_service_connection.0.private_ip_address]
}

resource "azurerm_private_dns_zone" "blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob" {
  name                = "blob_link"
  private_dns_zone_id = azurerm_private_dns_zone.blob.id
  virtual_network_id  = azurerm_virtual_network.main.id
}

resource "azurerm_private_endpoint" "blob" {
  depends_on          = [azurerm_storage_account.logic_app]
  name                = "${var.storage_account_name}-blob"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_id           = local.subnet_ids["storage-subnet"]

  private_service_connection {
    name                           = "${var.storage_account_name}-blob"
    private_connection_resource_id = azurerm_storage_account.logic_app.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }
}

resource "azurerm_private_dns_a_record" "blob" {
  name                = azurerm_storage_account.logic_app.name
  private_dns_zone_id = azurerm_private_dns_zone.blob.id
  ttl                 = 300
  records             = [azurerm_private_endpoint.blob.private_service_connection.0.private_ip_address]
}

resource "azurerm_private_dns_zone" "table" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "table" {
  name                = "table_link"
  private_dns_zone_id = azurerm_private_dns_zone.table.id
  virtual_network_id  = azurerm_virtual_network.main.id
}

resource "azurerm_private_endpoint" "table" {
  depends_on          = [azurerm_storage_account.logic_app]
  name                = "${var.storage_account_name}-table"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_id           = local.subnet_ids["storage-subnet"]

  private_service_connection {
    name                           = "${var.storage_account_name}-table"
    private_connection_resource_id = azurerm_storage_account.logic_app.id
    is_manual_connection           = false
    subresource_names              = ["table"]
  }
}

resource "azurerm_private_dns_a_record" "table" {
  name                = azurerm_storage_account.logic_app.name
  private_dns_zone_id = azurerm_private_dns_zone.table.id
  ttl                 = 300
  records             = [azurerm_private_endpoint.table.private_service_connection.0.private_ip_address]
}

resource "azurerm_private_dns_zone" "queue" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "queue" {
  name                = "queue_link"
  private_dns_zone_id = azurerm_private_dns_zone.queue.id
  virtual_network_id  = azurerm_virtual_network.main.id
}

resource "azurerm_private_endpoint" "queue" {
  depends_on          = [azurerm_storage_account.logic_app]
  name                = "${var.storage_account_name}-queue"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_id           = local.subnet_ids["storage-subnet"]

  private_service_connection {
    name                           = "${var.storage_account_name}-queue"
    private_connection_resource_id = azurerm_storage_account.logic_app.id
    is_manual_connection           = false
    subresource_names              = ["queue"]
  }
}

resource "azurerm_private_dns_a_record" "queue" {
  name                = azurerm_storage_account.logic_app.name
  private_dns_zone_id = azurerm_private_dns_zone.queue.id
  ttl                 = 300
  records             = [azurerm_private_endpoint.queue.private_service_connection.0.private_ip_address]
}

resource "azurerm_service_plan" "logic_app" {
  name                = var.app_service_plan_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Windows"
  sku_name            = "WS1"
}

resource "azurerm_logic_app_standard" "main" {
  name                       = var.logic_app_name
  resource_group_name        = azurerm_resource_group.main.name
  location                   = azurerm_resource_group.main.location
  app_service_plan_id        = azurerm_service_plan.logic_app.id
  storage_account_name       = azurerm_storage_account.logic_app.name
  storage_account_share_name = azurerm_storage_share.logic_app_content.name
  storage_account_access_key = azurerm_storage_account.logic_app.primary_access_key
  virtual_network_subnet_id  = local.subnet_ids["logic-app-integration-subnet"]
  version                    = "~4"
  vnet_content_share_enabled = true
  https_only                 = true

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"      = "dotnet",
    "WEBSITE_NODE_DEFAULT_VERSION"  = "~22",
    "FUNCTIONS_INPROC_NET8_ENABLED" = "1",
    "LOGIC_APPS_POWERSHELL_VERSION" = "7.4"
  }

  site_config {
    always_on                        = true
    vnet_route_all_enabled           = true
    use_32_bit_worker_process        = false
    runtime_scale_monitoring_enabled = true
  }

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_private_endpoint.blob,
    azurerm_private_endpoint.file,
    azurerm_private_endpoint.table,
    azurerm_private_endpoint.queue,
  ]
}
