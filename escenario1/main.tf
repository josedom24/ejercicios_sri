##############################################
# servidorweb — Debian
##############################################

# Clon ligero sobre la imagen base: solo almacena los cambios diferenciales
resource "libvirt_volume" "e1-servidorweb-disk" {
  name             = "e1-servidorweb.qcow2"
  pool             = var.libvirt_pool_name
  base_volume_name = var.base_image_debian
  base_volume_pool = var.libvirt_pool_name
  format           = "qcow2"
}

# ISO cloud-init con la configuración inicial de la máquina
resource "libvirt_cloudinit_disk" "e1-servidorweb-cloudinit" {
  name           = "e1-servidorweb-cloudinit.iso"
  pool           = var.libvirt_pool_name
  user_data      = file("${path.module}/cloud-init/user-data-servidorweb.yaml")
  network_config = file("${path.module}/cloud-init/network-config-servidorweb.yaml")
}

# Definición del dominio (máquina virtual)
resource "libvirt_domain" "e1-servidorweb" {
  name   = "e1-servidorweb"
  memory = 1024
  vcpu   = 1

  # Pide las IP al agente de QEMU (qemu-guest-agent): así se conocen también las estáticas
  qemu_agent = true

  # Red 1: NAT con DHCP (acceso exterior)
  network_interface {
    network_id     = libvirt_network.e1-nat-dhcp.id
    wait_for_lease = true
  }

  # Red 2: muy aislada (IP estática 10.0.0.1)
  network_interface {
    network_id = libvirt_network.e1-muy-aislada.id
  }

  disk { volume_id = libvirt_volume.e1-servidorweb-disk.id }
  cloudinit = libvirt_cloudinit_disk.e1-servidorweb-cloudinit.id

  # Consola serie: las imágenes cloud la esperan (sin ella, algunas, como
  # Ubuntu, no terminan de arrancar) y permite entrar con "virsh console"
  # aunque falle la red
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }
}

##############################################
# cliente — Debian
##############################################

# Clon ligero sobre la imagen base: solo almacena los cambios diferenciales
resource "libvirt_volume" "e1-cliente-disk" {
  name             = "e1-cliente.qcow2"
  pool             = var.libvirt_pool_name
  base_volume_name = var.base_image_debian
  base_volume_pool = var.libvirt_pool_name
  format           = "qcow2"
}

# ISO cloud-init con la configuración inicial de la máquina
resource "libvirt_cloudinit_disk" "e1-cliente-cloudinit" {
  name           = "e1-cliente-cloudinit.iso"
  pool           = var.libvirt_pool_name
  user_data      = file("${path.module}/cloud-init/user-data-cliente.yaml")
  network_config = file("${path.module}/cloud-init/network-config-cliente.yaml")
}

# Definición del dominio (máquina virtual)
resource "libvirt_domain" "e1-cliente" {
  name   = "e1-cliente"
  memory = 1024
  vcpu   = 1

  # Pide las IP al agente de QEMU (qemu-guest-agent): así se conocen también las estáticas
  qemu_agent = true

  # Red 1: NAT con DHCP (acceso exterior)
  network_interface {
    network_id     = libvirt_network.e1-nat-dhcp.id
    wait_for_lease = true
  }

  # Red 2: muy aislada (IP estática 10.0.0.2)
  network_interface {
    network_id = libvirt_network.e1-muy-aislada.id
  }

  disk { volume_id = libvirt_volume.e1-cliente-disk.id }
  cloudinit = libvirt_cloudinit_disk.e1-cliente-cloudinit.id

  # Consola serie: las imágenes cloud la esperan (sin ella, algunas, como
  # Ubuntu, no terminan de arrancar) y permite entrar con "virsh console"
  # aunque falle la red
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }
}
