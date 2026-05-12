output "e3-balanceador" {
  value = {
    nombre = "e3-balanceador"
    ip1    = try(libvirt_domain.e3-balanceador.network_interface[0].addresses[0], "No disponible")
    ip2    = try(libvirt_domain.e3-balanceador.network_interface[1].addresses[0], "No disponible")
  }
}

output "e3-apache1" {
  value = {
    nombre = "e3-apache1"
    ip1    = try(libvirt_domain.e3-apache1.network_interface[0].addresses[0], "No disponible")
    ip2    = try(libvirt_domain.e3-apache1.network_interface[1].addresses[0], "No disponible")
  }
}

output "e3-apache2" {
  value = {
    nombre = "e3-apache2"
    ip1    = try(libvirt_domain.e3-apache2.network_interface[0].addresses[0], "No disponible")
    ip2    = try(libvirt_domain.e3-apache2.network_interface[1].addresses[0], "No disponible")
  }
}
