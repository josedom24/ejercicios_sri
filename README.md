# Ejercicios del módulo de SRI

Repositorio con los escenarios de infraestructura para las tareas y prácticas del módulo de **Servicios de Red e Internet (SRI)**.

Los escenarios se crean con **OpenTofu + libvirt** y, cuando hace falta, se configuran con **Ansible**, igual que en el repositorio [ejercicios_pi](https://github.com/josedom24/ejercicios_pi) del módulo de Proyecto Intermodular.

## Antes de empezar

* Las imágenes base `debian13-base.qcow2` tienen que estar en el pool `default` (`/var/lib/libvirt/images`), redimensionadas y con el pool refrescado (`sudo virsh pool-refresh default`), como se explica en la tarea 4 de PI.
* En los ficheros `cloud-init/user-data-*.yaml` hay que **sustituir la línea de ejemplo** de `ssh-authorized-keys` por tu clave pública.
* El provider está fijado a `dmacvicar/libvirt` 0.8.3: no cambies la versión (desde la 0.9 el provider usa otra sintaxis).
* Los dominios usan `qemu_agent = true`: OpenTofu obtiene las IP (también las estáticas) del agente `qemu-guest-agent`, que instala cloud-init.
* Destruye cada escenario (`tofu destroy`) antes de crear otro.

## Cómo se usa un escenario

```
cd escenarioN
tofu init          # una sola vez
tofu apply         # crea el escenario (y, en los escenarios 2 y 3, el inventario ansible/hosts)
cd ansible
ansible-playbook site.yaml    # solo en los escenarios 2 y 3
```

## Estructura

### `escenario1/` — Servidor web y cliente

2 VMs Debian conectadas a una red NAT con DHCP (`e1-nat-dhcp`, 192.168.102.0/24) y a una red muy aislada (`e1-muy-aislada`):

- **servidorweb** — IP interna estática 10.0.0.1. Servidor web para la tarea de Apache y Nginx (el servidor web lo instala el alumno).
- **cliente** — IP interna estática 10.0.0.2. Máquina cliente para hacer peticiones al servidor.

### `escenario2/` — Proxy inverso y backend

2 VMs Debian conectadas a una red NAT con DHCP (`e2-nat-dhcp`, 192.168.101.0/24) y a una red muy aislada (`e2-muy-aislada`):

- **proxy** — IP interna estática 10.0.0.1. En ella se instala el proxy inverso (nginx/apache).
- **backend** — IP interna estática 10.0.0.2. Servidor web interno. Está conectado a la red NAT solo para poder configurarlo con Ansible.

La receta de `ansible/` instala apache2 en el **backend** y crea los virtual hosts de la variable `virtualhosts` de `ansible/group_vars/all`, cada uno con su página principal y el directorio `nuevodirectorio`. El inventario (`ansible/hosts`) lo genera OpenTofu con `inventario.tf` y la plantilla `inventario.tftpl`, a partir de la IP del backend en la red NAT.

### `escenario3/` — Balanceador de carga

3 VMs Debian conectadas a una red externa NAT sin DHCP (`e3-red-externa`, 192.168.10.0/24, IP estáticas con salida a internet) y a una red de datos muy aislada (`e3-red-datos`, 192.168.100.0/24):

- **balanceador** — IP externa 192.168.10.10, IP interna 192.168.100.1. En ella se instala el balanceador (HAProxy).
- **apache1** — IP externa 192.168.10.11, IP interna 192.168.100.100. Primer servidor web.
- **apache2** — IP externa 192.168.10.12, IP interna 192.168.100.101. Segundo servidor web.

La receta de `ansible/` instala apache2 con PHP en **apache1** y **apache2** y pone una página `index.php` que muestra el nombre del servidor que atiende la petición. El inventario (`ansible/hosts`) lo genera OpenTofu con las IP de la red externa.
