# Red NAT con DHCP: proporciona conectividad exterior a las VMs
resource "libvirt_network" "e2-nat-dhcp" {
  name      = "e2-nat-dhcp"
  mode      = "nat"
  domain    = "example.com"
  addresses = ["192.168.101.0/24"]
  dhcp { enabled = true }
  dns { enabled = true }
  autostart = true
}

# Red muy aislada (mode=none): comunicación directa entre VMs sin acceso exterior
resource "libvirt_network" "e2-muy-aislada" {
  name      = "e2-muy-aislada"
  mode      = "none"
  autostart = true
}
