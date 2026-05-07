# Revision de seguridad

## Controles aplicados

- `terror.iclexi.tech` usa login real con cookie `HttpOnly`, `Secure`, `SameSite=Lax`, rate limit y sesiones firmadas.
- La app de terror usa PostgreSQL con base y usuario dedicados.
- `iclexi.tech` escucha solo en `127.0.0.1:9023`; el acceso publico pasa por Cloudflare Tunnel.
- `ppt-terror-proxy.service` escucha solo en `127.0.0.1:1311`.
- Repositorios generados no incluyen `.env`, tokens, claves privadas ni credenciales.
- `npm audit` limpio en dependencias de produccion de `PPT-Del-terror` y completo en `Portfolio`.

## Hallazgos y recomendaciones

| Prioridad | Hallazgo | Recomendacion |
| --- | --- | --- |
| Alta | `local-lvm` esta alrededor de 89% de uso. | Liberar discos antiguos, revisar snapshots y crecer storage antes de superar 90-95%. |
| Alta | Proxmox UI esta publicada como `pve.iclexi.tech`. | Mantener Cloudflare Access/MFA obligatorio y restringir por identidad/IP si es posible. |
| Media | `cloudflared.service` principal guarda token inline en systemd. | Mover el token a `EnvironmentFile` con permisos `0600` y usar `--token $TUNNEL_TOKEN`. |
| Media | Varios forwards escuchan en `0.0.0.0`. | Revisar si deben limitarse a `127.0.0.1` o a la LAN, segun uso real. |
| Media | VMs 100 y 106 no reportan QEMU guest agent. | Instalar/habilitar guest agent si el sistema operativo lo permite. |
| Baja | Avahi/rpcbind escuchan en el host. | Deshabilitar si no son necesarios para el homelab. |

## Comandos utiles

```bash
systemctl status cloudflared cloudflared-portfolio portfolio ppt-terror-proxy
qm list
pvesm status
ss -tulpn
sudo -u postgres psql -c '\l'
```
