##############################################
# balanceador — Debian
##############################################

resource "libvirt_volume" "e3-balanceador-disk" {
  name             = "e3-balanceador.qcow2"
  pool             = var.libvirt_pool_name
  base_volume_name = var.base_image_debian
  base_volume_pool = var.libvirt_pool_name
  format           = "qcow2"
}

resource "libvirt_cloudinit_disk" "e3-balanceador-cloudinit" {
  name           = "e3-balanceador-cloudinit.iso"
  pool           = var.libvirt_pool_name
  user_data      = file("${path.module}/cloud-init/user-data-balanceador.yaml")
  network_config = file("${path.module}/cloud-init/network-config-balanceador.yaml")
}

resource "libvirt_domain" "e3-balanceador" {
  name   = "e3-balanceador"
  memory = 1024
  vcpu   = 1

  # Red 1: externa NAT sin DHCP (IP estática 192.168.10.10, gateway 192.168.10.1)
  network_interface {
    network_id = libvirt_network.e3-red-externa.id
  }

  # Red 2: datos (IP estática 192.168.100.1)
  network_interface {
    network_id = libvirt_network.e3-red-datos.id
  }

  disk { volume_id = libvirt_volume.e3-balanceador-disk.id }
  cloudinit = libvirt_cloudinit_disk.e3-balanceador-cloudinit.id

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }
}

##############################################
# apache1 — Debian
##############################################

resource "libvirt_volume" "e3-apache1-disk" {
  name             = "e3-apache1.qcow2"
  pool             = var.libvirt_pool_name
  base_volume_name = var.base_image_debian
  base_volume_pool = var.libvirt_pool_name
  format           = "qcow2"
}

resource "libvirt_cloudinit_disk" "e3-apache1-cloudinit" {
  name           = "e3-apache1-cloudinit.iso"
  pool           = var.libvirt_pool_name
  user_data      = file("${path.module}/cloud-init/user-data-apache1.yaml")
  network_config = file("${path.module}/cloud-init/network-config-apache1.yaml")
}

resource "libvirt_domain" "e3-apache1" {
  name   = "e3-apache1"
  memory = 1024
  vcpu   = 1

  # Red 1: externa NAT sin DHCP (IP estática 192.168.10.11, gateway 192.168.10.1)
  network_interface {
    network_id = libvirt_network.e3-red-externa.id
  }

  # Red 2: datos (IP estática 192.168.100.100)
  network_interface {
    network_id = libvirt_network.e3-red-datos.id
  }

  disk { volume_id = libvirt_volume.e3-apache1-disk.id }
  cloudinit = libvirt_cloudinit_disk.e3-apache1-cloudinit.id

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }
}

##############################################
# apache2 — Debian
##############################################

resource "libvirt_volume" "e3-apache2-disk" {
  name             = "e3-apache2.qcow2"
  pool             = var.libvirt_pool_name
  base_volume_name = var.base_image_debian
  base_volume_pool = var.libvirt_pool_name
  format           = "qcow2"
}

resource "libvirt_cloudinit_disk" "e3-apache2-cloudinit" {
  name           = "e3-apache2-cloudinit.iso"
  pool           = var.libvirt_pool_name
  user_data      = file("${path.module}/cloud-init/user-data-apache2.yaml")
  network_config = file("${path.module}/cloud-init/network-config-apache2.yaml")
}

resource "libvirt_domain" "e3-apache2" {
  name   = "e3-apache2"
  memory = 1024
  vcpu   = 1

  # Red 1: externa NAT sin DHCP (IP estática 192.168.10.12, gateway 192.168.10.1)
  network_interface {
    network_id = libvirt_network.e3-red-externa.id
  }

  # Red 2: datos (IP estática 192.168.100.101)
  network_interface {
    network_id = libvirt_network.e3-red-datos.id
  }

  disk { volume_id = libvirt_volume.e3-apache2-disk.id }
  cloudinit = libvirt_cloudinit_disk.e3-apache2-cloudinit.id

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }
}
