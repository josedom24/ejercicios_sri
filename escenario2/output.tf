output "e2-proxy" {
  value = {
    nombre = "e2-proxy"
    ip1    = try(libvirt_domain.e2-proxy.network_interface[0].addresses[0], "No disponible")
    ip2    = try(libvirt_domain.e2-proxy.network_interface[1].addresses[0], "No disponible")
  }
}

output "e2-backend" {
  value = {
    nombre = "e2-backend"
    ip1    = try(libvirt_domain.e2-backend.network_interface[0].addresses[0], "No disponible")
    ip2    = try(libvirt_domain.e2-backend.network_interface[1].addresses[0], "No disponible")
  }
}
