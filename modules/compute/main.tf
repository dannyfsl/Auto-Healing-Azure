resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = "${var.prefix}-vmss"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku                 = var.vm_size
  instances           = var.min_size
  zones               = ["1","2"]

  admin_username      = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = file(var.ssh_public_key_path)
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "${var.prefix}-nic"
    primary = true

    ip_configuration {
      name                                   = "${var.prefix}-ipcfg"
      primary                                = true
      subnet_id                              = var.subnet_id
      load_balancer_backend_address_pool_ids = [var.lb_backend_pool_id]
    }
  }

  # Self-healing: VMSS evaluates health using LB probe, and
  # automatic_instance_repair ensures unhealthy VMs are replaced.
  health_probe_id = var.lb_probe_id

  automatic_instance_repair {
    enabled      = true
    # must be between 10m and 1h30m; 10 minutes is reasonable
    grace_period = "PT10M"
  }

  upgrade_mode = "Automatic"

  custom_data = base64encode(templatefile("${path.module}/cloud-init-nginx.tpl", {}))

  tags = var.tags
}
