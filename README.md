# Ejercicios del módulo de SRI

Repositorio con los escenarios de infraestructura para las prácticas del módulo de **Servicios de Red e Internet (SRI)**.

## Estructura

### `escenario1/` — Servidor web y cliente

2 VMs Debian conectadas a una red NAT con DHCP (acceso exterior) y una red muy aislada (comunicación interna):

- **servidorweb** — IP interna estática 10.0.0.1. Servidor web para las prácticas de configuración de servidores HTTP.
- **cliente** — IP interna estática 10.0.0.2. Máquina cliente para realizar peticiones al servidor.

### `escenario2/` — Proxy inverso y backend

2 VMs Debian conectadas a una red NAT con DHCP (acceso exterior) y una red muy aislada (comunicación interna):

- **proxy** — IP interna estática 10.0.0.1. Actúa como proxy inverso (nginx/apache) hacia el backend.
- **backend** — IP interna estática 10.0.0.2. Servidor web interno al que el proxy redirige las peticiones.

### `escenario3/` — Balanceador de carga

3 VMs Debian conectadas a una red externa NAT sin DHCP (IPs estáticas con salida a internet, 192.168.10.0/24) y una red de datos aislada (192.168.100.0/24):

- **balanceador** — IP externa 192.168.10.10, IP interna 192.168.100.1. Distribuye el tráfico entre los dos backends.
- **apache1** — IP externa 192.168.10.11, IP interna 192.168.100.100. Primer servidor web backend.
- **apache2** — IP externa 192.168.10.12, IP interna 192.168.100.101. Segundo servidor web backend.
