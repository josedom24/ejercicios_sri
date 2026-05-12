# Red NAT con DHCP: proporciona conectividad exterior a las VMs
resource "libvirt_network" "e1-nat-dhcp" {
  name      = "e1-nat-dhcp"
  mode      = "nat"
  domain    = "example.com"
  addresses = ["192.168.100.0/24"]
  dhcp { enabled = true }
  dns { enabled = true }
  autostart = true
}

# Red muy aislada (mode=none): comunicación directa entre VMs sin acceso exterior
resource "libvirt_network" "e1-muy-aislada" {
  name      = "e1-muy-aislada"
  mode      = "none"
  autostart = true
}
