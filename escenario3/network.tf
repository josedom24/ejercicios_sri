# Red externa NAT sin DHCP: las VMs usan IPs estáticas con salida a internet via NAT
resource "libvirt_network" "e3-red-externa" {
  name      = "e3-red-externa"
  mode      = "nat"
  domain    = "example.com"
  addresses = ["192.168.10.0/24"]
  dhcp { enabled = false }
  dns { enabled = true }
  autostart = true
}

# Red de datos (mode=none): enlace directo entre el balanceador y los backends
resource "libvirt_network" "e3-red-datos" {
  name      = "e3-red-datos"
  mode      = "none"
  autostart = true
}
