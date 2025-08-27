output "backend_pool_id" {
  value = azurerm_lb_backend_address_pool.bepool.id
}

output "probe_id" {
  value = azurerm_lb_probe.http_probe.id
}

output "public_ip_address" {
  value = azurerm_public_ip.pip.ip_address
}
