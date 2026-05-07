# Servicios y puertos

Fuente: [`inventory/proxmox/listening-ports.txt`](../inventory/proxmox/listening-ports.txt).

## Servicios nuevos

| Servicio systemd | Puerto | Bind | Funcion |
| --- | ---: | --- | --- |
| `portfolio.service` | 9023 | `127.0.0.1` | Portfolio Next.js para `iclexi.tech` |
| `cloudflared-portfolio.service` | N/A | Tunel | Expone `iclexi.tech` |
| `ppt-terror-proxy.service` | 1311 | `127.0.0.1` | Forward a VIP HA `192.168.200.30:1311` |
| `ppt-terror.service` | 1311 | VMs 201/202 | App PPT del Terror con login y dashboard |

## Servicios existentes destacados

| Puerto | Servicio | Notas |
| ---: | --- | --- |
| 8006 | Proxmox VE | UI/API |
| 5432 | PostgreSQL | Escucha en `127.0.0.1` y `192.168.200.1` |
| 5155 | RitmoHub forward | Servicio existente |
| 8080 | HA web forward | Servicio existente |
| 8096 | Jellyfin forward | Servicio existente |
| 9001 | Nextcloud forward | Servicio existente |
| 9444 | PBX HTTPS forward | Servicio existente |
| 25565 | Minecraft Java | Forward existente |
| 19132/udp | Minecraft Bedrock | Forward existente |

## PostgreSQL

Bases documentadas:

- `ritmohub_db` / `ritmohub_user`
- `cryptotoolbox_db` / `cryptotoolbox_user`
- `ppt_terror_db` / `ppt_terror_user`

La base `ppt_terror_db` fue creada separada para rankings del juego; no reutiliza ni modifica las bases anteriores.
