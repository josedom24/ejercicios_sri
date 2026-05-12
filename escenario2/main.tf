##############################################
# proxy — Debian
##############################################

resource "libvirt_volume" "e2-proxy-disk" {
  name             = "e2-proxy.qcow2"
  pool             = var.libvirt_pool_name
  base_volume_name = var.base_image_debian
  base_volume_pool = var.libvirt_pool_name
  format           = "qcow2"
}

resource "libvirt_cloudinit_disk" "e2-proxy-cloudinit" {
  name           = "e2-proxy-cloudinit.iso"
  pool           = var.libvirt_pool_name
  user_data      = file("${path.module}/cloud-init/user-data-proxy.yaml")
  network_config = file("${path.module}/cloud-init/network-config-proxy.yaml")
}

resource "libvirt_domain" "e2-proxy" {
  name   = "e2-proxy"
  memory = 1024
  vcpu   = 1

  # Red 1: NAT con DHCP (acceso exterior)
  network_interface {
    network_id     = libvirt_network.e2-nat-dhcp.id
    wait_for_lease = true
  }

  # Red 2: muy aislada (IP estática 10.0.0.1)
  network_interface {
    network_id = libvirt_network.e2-muy-aislada.id
  }

  disk { volume_id = libvirt_volume.e2-proxy-disk.id }
  cloudinit = libvirt_cloudinit_disk.e2-proxy-cloudinit.id

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }
}

##############################################
# backend — Debian
##############################################

resource "libvirt_volume" "e2-backend-disk" {
  name             = "e2-backend.qcow2"
  pool             = var.libvirt_pool_name
  base_volume_name = var.base_image_debian
  base_volume_pool = var.libvirt_pool_name
  format           = "qcow2"
}

resource "libvirt_cloudinit_disk" "e2-backend-cloudinit" {
  name           = "e2-backend-cloudinit.iso"
  pool           = var.libvirt_pool_name
  user_data      = file("${path.module}/cloud-init/user-data-backend.yaml")
  network_config = file("${path.module}/cloud-init/network-config-backend.yaml")
}

resource "libvirt_domain" "e2-backend" {
  name   = "e2-backend"
  memory = 1024
  vcpu   = 1

  # Red 1: NAT con DHCP (acceso exterior)
  network_interface {
    network_id     = libvirt_network.e2-nat-dhcp.id
    wait_for_lease = true
  }

  # Red 2: muy aislada (IP estática 10.0.0.2)
  network_interface {
    network_id = libvirt_network.e2-muy-aislada.id
  }

  disk { volume_id = libvirt_volume.e2-backend-disk.id }
  cloudinit = libvirt_cloudinit_disk.e2-backend-cloudinit.id

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }
}
