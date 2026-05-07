# Revision de seguridad

## Controles aplicados

- `terror.iclexi.tech` usa login real con cookie `HttpOnly`, `Secure`, `SameSite=Lax`, rate limit y sesiones firmadas.
- La app de terror usa PostgreSQL con base y usuario dedicados.
- `iclexi.tech` escucha solo en `127.0.0.1:9023`; el acceso publico pasa por Cloudflare Tunnel.
- `ppt-terror-proxy.service` escucha solo en `127.0.0.1:1311`.
- `cryptotoolbox-proxy.service` escucha solo en `127.0.0.1:3000` y reenvia al VIP HA `192.168.200.30:3300`.
- Las paginas publicas principales usan CSP, HSTS, `X-Frame-Options: DENY` y `X-Content-Type-Options: nosniff`.
- El token del `cloudflared.service` principal fue movido a `/etc/cloudflared/token.env` con permisos `0600`.
- Repositorios generados no incluyen `.env`, tokens, claves privadas ni credenciales.
- `npm audit` limpio en dependencias de `Portfolio`, `PPT-Del-terror`, `RitmoHub` y `CryptoToolbox`.

## Hallazgos y recomendaciones

| Prioridad | Hallazgo | Recomendacion |
| --- | --- | --- |
| Alta | `local-lvm` esta alrededor de 89% de uso. | Liberar discos antiguos, revisar snapshots y crecer storage antes de superar 90-95%. |
| Alta | Proxmox UI esta publicada como `pve.iclexi.tech`. | Mantener Cloudflare Access/MFA obligatorio y restringir por identidad/IP si es posible. |
| Media | Varios forwards escuchan en `0.0.0.0`. | Revisar si deben limitarse a `127.0.0.1` o a la LAN, segun uso real. |
| Media | VMs 100 y 106 no reportan QEMU guest agent. | Instalar/habilitar guest agent si el sistema operativo lo permite. |
| Baja | Avahi/rpcbind escuchan en el host. | Deshabilitar si no son necesarios para el homelab. |

## Comandos utiles

```bash
systemctl status cloudflared cloudflared-portfolio portfolio ppt-terror-proxy cryptotoolbox-proxy
qm list
pvesm status
ss -tulpn
sudo -u postgres psql -c '\l'
```
