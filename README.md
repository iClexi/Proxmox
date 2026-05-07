# Proxmox Homelab Documentation

Documentacion operativa del servidor Proxmox `pve` y sus maquinas virtuales. Este repositorio guarda inventario, configuraciones saneadas, servicios publicados y comandos para volver a recolectar el estado del entorno.

> Seguridad: no se suben tokens, contrasenas, hashes, claves privadas ni archivos `.env`. Las salidas en `inventory/` y `configs/sanitized/` pasan por redaccion automatica.

## Resumen rapido

| Area | Estado actual |
| --- | --- |
| Nodo | `pve` |
| Version | Proxmox VE 9.1.0 / pve-manager 9.1.9 |
| Kernel | `6.17.13-4-pve` |
| Red LAN | `192.168.68.112/22` |
| Red VMs | `vmbr1` - `192.168.200.1/24` |
| Red NAT/lab | `vmbr0` - `10.10.10.1/24` |
| Almacenamiento | `local` 29%, `local-lvm` 89% |
| Tunneles | `pve-lab`, `portfolio-root` |
| Apps nuevas | `terror.iclexi.tech` en VMs 201/202, `iclexi.tech` en host puerto 9023 |

## Estructura

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

## Servicios publicados

| Dominio | Origen interno | Notas |
| --- | --- | --- |
| `iclexi.tech` | `127.0.0.1:9023` | Portafolio Next.js por tunel `portfolio-root`. |
| `terror.iclexi.tech` | `127.0.0.1:1311 -> 192.168.200.30:1311` | Juego PPT del Terror en HA web 201/202. |
| `ritmohub.iclexi.tech` | `127.0.0.1:5155` | App Next.js existente. |
| `jellyfin.iclexi.tech` | `127.0.0.1:8096` | Forward existente. |
| `pbx.iclexi.tech` | `127.0.0.1:9444` | HTTPS interno con `noTLSVerify`. |
| `pve.iclexi.tech` | `192.168.68.112:8006` | Consola Proxmox detras de Cloudflare. |

## Maquinas virtuales

| VMID | Nombre | Rol | RAM | Disco |
| --- | --- | --- | ---: | ---: |
| 100 | `pfsense` | Firewall/router | 4096 MB | 20 GB |
| 101 | `true-nas` | NAS / almacenamiento | 4096 MB | 16 GB |
| 102 | `vpn` | VPN / Tailscale | 2048 MB | 25 GB |
| 103 | `wazuh` | SIEM / seguridad | 12288 MB | 50 GB |
| 104 | `dns-01` | DNS interno | 1024 MB | 12 GB |
| 105 | `proxy-01` | Reverse proxy interno | 2048 MB | 20 GB |
| 106 | `minecraft` | Minecraft Java/Bedrock | 2048 MB | 32 GB |
| 201 | `ha-web-master` | Web HA master | 1024 MB | 13 GB |
| 202 | `ha-web-backup` | Web HA backup | 1024 MB | 13 GB |
| 204 | `jellyfin-docker` | Jellyfin Docker | 1024 MB | 13 GB |

Detalles por VM: [`docs/vm-inventory.md`](docs/vm-inventory.md).

## Recolectar inventario

Ejecutar en el nodo Proxmox:

```bash
./scripts/collect-inventory.sh
```

El script actualiza `inventory/` y `configs/sanitized/` con salidas redaccionadas.

## Documentos

- [Inventario de VMs](docs/vm-inventory.md)
- [Red y tuneles](docs/network.md)
- [Servicios y puertos](docs/services.md)
- [Revision de seguridad](docs/security-review.md)
- [Operaciones](docs/operations.md)
