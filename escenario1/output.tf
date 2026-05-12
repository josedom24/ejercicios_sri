output "e1-servidorweb" {
  value = {
    nombre = "e1-servidorweb"
    ip1    = try(libvirt_domain.e1-servidorweb.network_interface[0].addresses[0], "No disponible")
    ip2    = try(libvirt_domain.e1-servidorweb.network_interface[1].addresses[0], "No disponible")
  }
}

output "e1-cliente" {
  value = {
    nombre = "e1-cliente"
    ip1    = try(libvirt_domain.e1-cliente.network_interface[0].addresses[0], "No disponible")
    ip2    = try(libvirt_domain.e1-cliente.network_interface[1].addresses[0], "No disponible")
  }
}
