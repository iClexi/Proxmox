# Inventario de VMs

Fuente principal: [`inventory/proxmox/qm-list.txt`](../inventory/proxmox/qm-list.txt) y `qm config` por VM.

| VMID | Nombre | IP conocida | Rol | Recursos |
| --- | --- | --- | --- | --- |
| 100 | `pfsense` | No reporta guest agent | Firewall/router | 2 cores, 4096 MB, 20 GB |
| 101 | `true-nas` | `192.168.200.12` | NAS / almacenamiento | 2 cores, 4096 MB, 16 GB |
| 102 | `vpn` | `192.168.200.13`, `100.116.230.21` | VPN / Tailscale | 1 core, 2048 MB, 25 GB |
| 103 | `wazuh` | `192.168.200.14` | SIEM / seguridad | 4 cores, 12288 MB, 50 GB |
| 104 | `dns-01` | `192.168.200.10` | DNS interno | 1 core, 1024 MB, 12 GB |
| 105 | `proxy-01` | `192.168.200.20` | Proxy interno | 2 cores, 2048 MB, 20 GB |
| 106 | `minecraft` | No reporta guest agent | Minecraft | 1 core, 2048 MB, 32 GB |
| 201 | `ha-web-master` | `192.168.200.21`, VIP `192.168.200.30` | Web HA master | 1 core, 1024 MB, 13 GB |
| 202 | `ha-web-backup` | `192.168.200.22` | Web HA backup | 1 core, 1024 MB, 13 GB |
| 204 | `jellyfin-docker` | `192.168.200.24` | Jellyfin Docker | 1 core, 1024 MB, 13 GB |

## HA web 201/202

- Ambas VMs corren Apache, RitmoHub, CryptoToolbox, Wazuh agent y `ppt-terror.service`.
- Keepalived mantiene la VIP `192.168.200.30/24`.
- `terror.iclexi.tech` entra por Cloudflare a `127.0.0.1:1311` en Proxmox y de ahi se reenvia a `192.168.200.30:1311`.
- Base nueva aislada: `ppt_terror_db` con rol `ppt_terror_user`.

## Archivos relevantes

Cada VM tiene:

- `inventory/vms/<vmid>-<name>/qm-config.txt`
- `inventory/vms/<vmid>-<name>/guest-ipv4.txt` si QEMU guest agent responde
- `inventory/vms/<vmid>-<name>/guest-hostname.txt` si QEMU guest agent responde
