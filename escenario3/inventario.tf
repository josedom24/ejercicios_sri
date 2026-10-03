# Genera el inventario de Ansible (ansible/hosts) con las IP de los servidores web
resource "local_file" "inventario" {
  filename        = "${path.module}/ansible/hosts"
  file_permission = "0644"
  content = templatefile("${path.module}/inventario.tftpl", {
    # Ansible configura los servidores web por la red externa. Las IP son
    # estáticas: están en cloud-init/network-config-apache1.yaml y -apache2.yaml
    ip_apache1 = "192.168.10.11"
    ip_apache2 = "192.168.10.12"
  })
}
