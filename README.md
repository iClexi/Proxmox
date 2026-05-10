<div align="center">

# Proxmox Homelab Infrastructure

### Documentación técnica, inventario operativo y arquitectura de servicios del entorno Proxmox `pve`

Infraestructura personal de virtualización orientada a ciberseguridad, redes, servidores Linux, servicios autoalojados, túneles Cloudflare, alta disponibilidad, monitoreo y despliegue de aplicaciones reales.

</div>

<div align="center">

![Proxmox](https://img.shields.io/badge/Proxmox-E57000?style=for-the-badge&logo=proxmox&logoColor=ffffff&labelColor=1f2937)
![Linux](https://img.shields.io/badge/Linux-facc15?style=for-the-badge&logo=linux&logoColor=111827&labelColor=020617)
![Debian](https://img.shields.io/badge/Debian-a81d33?style=for-the-badge&logo=debian&logoColor=ffffff&labelColor=2a0f18)
![Shell](https://img.shields.io/badge/Shell-22c55e?style=for-the-badge&logo=gnubash&logoColor=ffffff&labelColor=052e16)
![Cloudflare Tunnel](https://img.shields.io/badge/Cloudflare_Tunnel-f97316?style=for-the-badge&logo=cloudflare&logoColor=ffffff&labelColor=431407)
![Docker](https://img.shields.io/badge/Docker-0ea5e9?style=for-the-badge&logo=docker&logoColor=ffffff&labelColor=082f49)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-3b82f6?style=for-the-badge&logo=postgresql&logoColor=ffffff&labelColor=172554)
![pfSense](https://img.shields.io/badge/pfSense-2563eb?style=for-the-badge&logo=pfsense&logoColor=ffffff&labelColor=0f172a)
![TrueNAS](https://img.shields.io/badge/TrueNAS-0891b2?style=for-the-badge&logo=truenas&logoColor=ffffff&labelColor=083344)
![Wazuh](https://img.shields.io/badge/Wazuh-SIEM_&_XDR-005571?style=for-the-badge&logo=wazuh&logoColor=ffffff&labelColor=001E3C)
![SIEM](https://img.shields.io/badge/SIEM-Monitoring-6366f1?style=for-the-badge&logo=elasticstack&logoColor=ffffff&labelColor=1e1b4b)
![Networking](https://img.shields.io/badge/Networking-14b8a6?style=for-the-badge&logo=cisco&logoColor=ffffff&labelColor=042f2e)
![Security](https://img.shields.io/badge/Security_Documented-10b981?style=for-the-badge&logo=securityscorecard&logoColor=ffffff&labelColor=064e3b)
![Homelab](https://img.shields.io/badge/Homelab_Ready-8b5cf6?style=for-the-badge&logo=serverfault&logoColor=ffffff&labelColor=2e1065)

</div>

---

## Descripción

Este repositorio contiene la documentación operativa de mi homelab basado en Proxmox VE.

El objetivo principal es mantener un inventario técnico claro, reproducible y seguro del entorno `pve`, incluyendo máquinas virtuales, redes internas, servicios publicados, túneles Cloudflare, configuraciones saneadas, comandos de operación y revisiones de seguridad.

Este no es un repositorio de laboratorio vacío. Documenta una infraestructura real utilizada para practicar, desplegar y administrar servicios relacionados con ciberseguridad, redes, Linux, virtualización, almacenamiento, monitoreo y aplicaciones web.

---

## Objetivo del Repositorio

Este repositorio sirve como punto central para:

- Documentar el estado actual del nodo Proxmox.
- Mantener inventario de máquinas virtuales.
- Registrar redes, bridges, rutas y servicios publicados.
- Guardar configuraciones saneadas sin secretos.
- Documentar túneles Cloudflare y forwards internos.
- Mantener comandos de operación y recuperación.
- Registrar controles de seguridad aplicados.
- Facilitar auditoría, mantenimiento y crecimiento del homelab.

---

## Resumen de Infraestructura

| Área | Estado actual |
| --- | --- |
| Nodo principal | `pve` |
| Plataforma | Proxmox VE |
| Versión documentada | Proxmox VE 9.1.0 / pve-manager 9.1.9 |
| Kernel documentado | `6.17.13-4-pve` |
| Red LAN física | `192.168.68.112/22` |
| Red interna de VMs | `vmbr1` - `192.168.200.1/24` |
| Red NAT / laboratorio | `vmbr0` - `10.10.10.1/24` |
| Túneles principales | `pve-lab`, `portfolio-root` |
| Documentación | Inventario, red, servicios, seguridad y operaciones |
| Lenguaje principal | Shell |

---

## Arquitectura General

```text
Internet
   |
   | Cloudflare DNS / Tunnel
   |
Cloudflare Tunnel
   |
   |----------------------------|
   |                            |
portfolio-root              pve-lab
   |                            |
iclexi.tech                 pve.iclexi.tech
                             terror.iclexi.tech
                             ritmohub.iclexi.tech
                             jellyfin.iclexi.tech
                             pbx.iclexi.tech
   |
Proxmox Host `pve`
   |
   |-- vmbr0 10.10.10.1/24
   |-- vmbr1 192.168.200.1/24
   |
   |-- pfSense
   |-- TrueNAS
   |-- VPN / Tailscale
   |-- Wazuh
   |-- DNS interno
   |-- Proxy interno
   |-- Minecraft
   |-- HA Web Master
   |-- HA Web Backup
   |-- Jellyfin Docker
```

---

## Servicios Publicados

| Dominio | Origen interno | Función |
| --- | --- | --- |
| `iclexi.tech` | `127.0.0.1:9023` | Portfolio Next.js publicado por túnel `portfolio-root` |
| `terror.iclexi.tech` | `127.0.0.1:1311 -> 192.168.200.30:1311` | Juego PPT del Terror en entorno HA |
| `ritmohub.iclexi.tech` | `127.0.0.1:5155` | Aplicación RitmoHub |
| `jellyfin.iclexi.tech` | `127.0.0.1:8096` | Servidor multimedia Jellyfin |
| `pbx.iclexi.tech` | `127.0.0.1:9444` | Servicio PBX vía HTTPS interno |
| `pve.iclexi.tech` | `192.168.68.112:8006` | Consola Proxmox detrás de Cloudflare |

---

## Máquinas Virtuales Documentadas

| VMID | Nombre | Rol | Recursos |
| ---: | --- | --- | --- |
| 100 | `pfsense` | Firewall / router | 2 cores, 4096 MB RAM, 20 GB |
| 101 | `true-nas` | NAS / almacenamiento | 2 cores, 4096 MB RAM, 16 GB |
| 102 | `vpn` | VPN / Tailscale | 1 core, 2048 MB RAM, 25 GB |
| 103 | `wazuh` | SIEM / seguridad | 4 cores, 12288 MB RAM, 50 GB |
| 104 | `dns-01` | DNS interno | 1 core, 1024 MB RAM, 12 GB |
| 105 | `proxy-01` | Reverse proxy interno | 2 cores, 2048 MB RAM, 20 GB |
| 106 | `minecraft` | Minecraft Java / Bedrock | 1 core, 2048 MB RAM, 32 GB |
| 201 | `ha-web-master` | Web HA master | 1 core, 1024 MB RAM, 13 GB |
| 202 | `ha-web-backup` | Web HA backup | 1 core, 1024 MB RAM, 13 GB |
| 204 | `jellyfin-docker` | Jellyfin Docker | 1 core, 1024 MB RAM, 13 GB |

---

## Alta Disponibilidad Web

El entorno incluye un esquema de alta disponibilidad para servicios web usando dos máquinas virtuales:

```text
ha-web-master   -> 192.168.200.21
ha-web-backup   -> 192.168.200.22
VIP HA          -> 192.168.200.30
```

Servicios relacionados:

- Apache.
- Keepalived.
- RitmoHub.
- CryptoToolbox.
- PPT del Terror.
- Wazuh Agent.
- PostgreSQL como backend para aplicaciones específicas.

El tráfico público entra por Cloudflare Tunnel, llega al host Proxmox y luego se reenvía hacia la VIP interna de alta disponibilidad.

---

## Redes Documentadas

| Interfaz | IP | Uso |
| --- | --- | --- |
| `wlp0s20f3` | `192.168.68.112/22` | Red LAN física del host |
| `vmbr0` | `10.10.10.1/24` | Red NAT / laboratorio |
| `vmbr1` | `192.168.200.1/24` | Red interna de máquinas virtuales |

Rutas principales:

```text
iclexi.tech
  -> Cloudflare Tunnel portfolio-root
  -> 127.0.0.1:9023

terror.iclexi.tech
  -> Cloudflare Tunnel pve-lab
  -> 127.0.0.1:1311
  -> 192.168.200.30:1311

cryptotoolbox.iclexi.tech
  -> Cloudflare Tunnel pve-lab
  -> 127.0.0.1:3000
  -> 192.168.200.30:3300
```

---

## Servicios Internos Destacados

| Puerto | Servicio | Notas |
| ---: | --- | --- |
| 8006 | Proxmox VE | UI/API |
| 5432 | PostgreSQL | Bases de aplicaciones |
| 5155 | RitmoHub | Forward existente |
| 8096 | Jellyfin | Servicio multimedia |
| 9001 | Nextcloud | Forward existente |
| 9444 | PBX | HTTPS interno |
| 25565 | Minecraft Java | Forward existente |
| 19132/udp | Minecraft Bedrock | Forward existente |
| 1311 | PPT del Terror | Proxy hacia HA |
| 3000 | CryptoToolbox | Proxy hacia HA |

---

## Bases PostgreSQL Documentadas

| Base de datos | Usuario | Uso |
| --- | --- | --- |
| `ritmohub_db` | `ritmohub_user` | Aplicación RitmoHub |
| `cryptotoolbox_db` | `cryptotoolbox_user` | Aplicación CryptoToolbox |
| `ppt_terror_db` | `ppt_terror_user` | Rankings y datos del juego PPT del Terror |

Cada aplicación mantiene su propia base y usuario dedicado para separar responsabilidades y reducir impacto entre servicios.

---

## Estructura del Repositorio

```text
.
├── README.md
├── configs/
│   └── sanitized/
│       └── proxmox/
│           ├── cloudflared-configs.txt
│           └── systemd/
├── docs/
│   ├── network.md
│   ├── operations.md
│   ├── security-review.md
│   ├── services.md
│   └── vm-inventory.md
├── inventory/
│   ├── proxmox/
│   └── vms/
└── scripts/
    └── collect-inventory.sh
```

---

## Documentación Incluida

| Documento | Descripción |
| --- | --- |
| `docs/vm-inventory.md` | Inventario de máquinas virtuales, roles, IPs y recursos |
| `docs/network.md` | Interfaces, redes internas, túneles y rutas importantes |
| `docs/services.md` | Puertos, servicios systemd, forwards y bases PostgreSQL |
| `docs/security-review.md` | Controles aplicados, hallazgos y recomendaciones |
| `docs/operations.md` | Comandos de administración, validación y reinicio |

---

## Script de Inventario

El repositorio incluye un script para recolectar información técnica del nodo Proxmox:

```bash
./scripts/collect-inventory.sh
```

El script recopila información como:

- Versión de Proxmox.
- Lista de máquinas virtuales.
- Estado de almacenamiento.
- Interfaces de red.
- Rutas.
- Puertos en escucha.
- Bases y roles PostgreSQL.
- Túneles Cloudflare.
- Servicios systemd habilitados y en ejecución.
- Estado de HA.
- Configuración de VMs.
- IPs reportadas por QEMU Guest Agent cuando está disponible.

---

## Seguridad y Saneamiento

Este repositorio está diseñado para documentar sin exponer secretos.

No se versionan:

- Tokens.
- Contraseñas.
- Hashes sensibles.
- Claves privadas.
- Archivos `.env`.
- Credenciales de servicios.
- Llaves SSH privadas.

El script de recolección aplica redacción automática sobre valores sensibles antes de guardar salidas en `inventory/` y `configs/sanitized/`.

Ejemplos de elementos saneados:

```text
token=[REDACTED]
password=[REDACTED]
secret=[REDACTED]
api_key=[REDACTED]
private_key=[REDACTED]
sshkeys=[REDACTED_PUBLIC_KEY]
```

---

## Controles de Seguridad Aplicados

Medidas documentadas dentro del entorno:

- Servicios públicos detrás de Cloudflare Tunnel.
- Aplicaciones escuchando en `127.0.0.1` cuando corresponde.
- Uso de cookies `HttpOnly`, `Secure` y `SameSite=Lax` en aplicaciones sensibles.
- Rate limiting en aplicaciones web.
- Sesiones firmadas.
- Bases PostgreSQL separadas por aplicación.
- CSP, HSTS, `X-Frame-Options` y `X-Content-Type-Options` en páginas públicas.
- Tokens de Cloudflare movidos a archivos separados con permisos restrictivos.
- Repositorios sin `.env`, credenciales ni llaves privadas.

---

## Hallazgos Operativos

| Prioridad | Hallazgo | Recomendación |
| --- | --- | --- |
| Alta | `local-lvm` con uso elevado | Liberar discos antiguos, revisar snapshots y ampliar almacenamiento |
| Alta | Proxmox UI publicada vía dominio | Mantener Cloudflare Access, MFA y restricciones por identidad/IP |
| Media | Algunos forwards escuchan en `0.0.0.0` | Limitar a `127.0.0.1` o LAN cuando sea posible |
| Media | Algunas VMs no reportan QEMU Guest Agent | Instalar o habilitar guest agent cuando el sistema lo permita |
| Baja | Servicios como Avahi/rpcbind activos | Deshabilitar si no son necesarios |

---

## Comandos Operativos

### Estado rápido del nodo

```bash
qm list
pvesm status
systemctl --type=service --state=running --no-pager
```

### Estado de túneles y servicios principales

```bash
systemctl status cloudflared
systemctl status cloudflared-portfolio
systemctl status portfolio
systemctl status ppt-terror-proxy
systemctl status cryptotoolbox-proxy
```

### Validar servicios públicos

```bash
curl -I https://iclexi.tech
curl -I https://terror.iclexi.tech
curl -I https://cryptotoolbox.iclexi.tech
```

### Revisar puertos en escucha

```bash
ss -tulpn
```

### Validar PostgreSQL

```bash
sudo -u postgres psql -c '\l'
sudo -u postgres psql -c '\du'
sudo -u postgres psql -d ppt_terror_db -c '\dt'
```

---

## Reinicio de Servicios

### Reiniciar portfolio

```bash
systemctl restart portfolio.service
systemctl restart cloudflared-portfolio.service
```

### Reiniciar proxy de PPT del Terror

```bash
systemctl restart ppt-terror-proxy.service
```

### Reiniciar proxy de CryptoToolbox

```bash
systemctl restart cryptotoolbox-proxy.service
```

### Recolectar documentación actualizada

```bash
cd /root/Proxmox-docs-work
./scripts/collect-inventory.sh
git status
```

---

## Buenas Prácticas del Repositorio

Este repositorio sigue una estructura pensada para documentación técnica real:

- Separar documentación de inventario.
- Guardar configuraciones saneadas.
- No publicar secretos.
- Mantener comandos reproducibles.
- Documentar servicios con puerto, origen y función.
- Registrar hallazgos de seguridad.
- Mantener inventario por VM.
- Usar archivos separados para red, servicios, operaciones y seguridad.
- Evitar mezclar credenciales con documentación.

---

## Uso Recomendado

Este repositorio puede usarse como referencia para:

- Administrar un homelab basado en Proxmox.
- Documentar infraestructura personal.
- Practicar operación de servidores Linux.
- Implementar servicios con Cloudflare Tunnel.
- Organizar inventarios de VMs.
- Preparar auditorías internas.
- Mantener evidencia técnica para portafolio profesional.
- Documentar entornos de ciberseguridad, redes y DevOps.

---

## Perfil Técnico del Entorno

Este homelab está orientado a aprendizaje práctico y operación real. Combina virtualización, redes internas, publicación segura de servicios, SIEM, almacenamiento, DNS, proxies, aplicaciones web, bases de datos y automatización mediante scripts.

La infraestructura funciona como laboratorio personal para probar, romper, corregir, desplegar y documentar sistemas reales con enfoque profesional.

---

## Estado del Proyecto

Este repositorio está en evolución constante.

Se actualiza cuando se agregan nuevas VMs, servicios, túneles, rutas, aplicaciones, controles de seguridad o cambios importantes en la infraestructura.

---

## Autor

**Michael David Robles Fermin**  
**iClexi**

Repositorio creado como documentación técnica de infraestructura, homelab, virtualización, redes, servicios y seguridad.

---

<div align="center">

Proxmox Homelab Infrastructure  
Documentación real. Servicios reales. Operación real.

</div>
