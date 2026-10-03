# Genera el inventario de Ansible (ansible/hosts) a partir de la IP del backend
resource "local_file" "inventario" {
  filename        = "${path.module}/ansible/hosts"
  file_permission = "0644"
  content = templatefile("${path.module}/inventario.tftpl", {
    # Ansible configura el backend por la red NAT
    ip_backend = try(libvirt_domain.e2-backend.network_interface[0].addresses[0], "")
  })
}
