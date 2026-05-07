# Red y tuneles

## Interfaces del nodo

| Interfaz | IP | Uso |
| --- | --- | --- |
| `wlp0s20f3` | `192.168.68.112/22` | Red LAN fisica del host |
| `vmbr0` | `10.10.10.1/24` | Red NAT/lab |
| `vmbr1` | `192.168.200.1/24` | Red interna de VMs |

Ver captura completa: [`inventory/proxmox/ip-addresses.txt`](../inventory/proxmox/ip-addresses.txt).

## Tunneles Cloudflare

| Tunel | UUID | Uso |
| --- | --- | --- |
| `pve-lab` | `2f746be5-af85-4e6d-bf07-72ef09bdd4f9` | Servicios existentes y `terror.iclexi.tech` |
| `portfolio-root` | `ef12e405-3e22-4d74-80c9-3c26f7235e98` | Dominio raiz `iclexi.tech` |

Configuraciones saneadas:

- [`configs/sanitized/proxmox/cloudflared-configs.txt`](../configs/sanitized/proxmox/cloudflared-configs.txt)
- [`configs/sanitized/proxmox/systemd/cloudflared.service.txt`](../configs/sanitized/proxmox/systemd/cloudflared.service.txt)
- [`configs/sanitized/proxmox/systemd/cloudflared-portfolio.service.txt`](../configs/sanitized/proxmox/systemd/cloudflared-portfolio.service.txt)

## Rutas importantes

- `iclexi.tech` -> tunel `portfolio-root` -> `127.0.0.1:9023`
- `terror.iclexi.tech` -> tunel `pve-lab` -> `127.0.0.1:1311` -> `192.168.200.30:1311`
- `web.iclexi.tech` queda documentado como ruta existente; no se uso para el portafolio.
