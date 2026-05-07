# Operaciones

## Ver estado rapido

```bash
qm list
pvesm status
systemctl status cloudflared cloudflared-portfolio portfolio ppt-terror-proxy
systemctl status cryptotoolbox-proxy
curl -I https://iclexi.tech
curl -I https://terror.iclexi.tech
curl -I https://cryptotoolbox.iclexi.tech
```

## Reiniciar portafolio

```bash
systemctl restart portfolio.service
systemctl restart cloudflared-portfolio.service
```

## Reiniciar PPT del Terror

En Proxmox:

```bash
systemctl restart ppt-terror-proxy.service
```

En VMs 201 y 202:

```bash
ssh -i /root/.ssh/autonomous_infra_ed25519 infra@192.168.200.21 'sudo systemctl restart ppt-terror.service'
ssh -i /root/.ssh/autonomous_infra_ed25519 infra@192.168.200.22 'sudo systemctl restart ppt-terror.service'
```

## Reiniciar CryptoToolbox

En Proxmox:

```bash
systemctl restart cryptotoolbox-proxy.service
```

En VMs 201 y 202:

```bash
ssh -i /root/.ssh/autonomous_infra_ed25519 infra@192.168.200.21 'sudo systemctl restart cryptotoolbox.service'
ssh -i /root/.ssh/autonomous_infra_ed25519 infra@192.168.200.22 'sudo systemctl restart cryptotoolbox.service'
```

## Recolectar documentacion actualizada

```bash
cd /root/Proxmox-docs-work
./scripts/collect-inventory.sh
git status
```

## Validar bases PostgreSQL

```bash
sudo -u postgres psql -c '\l'
sudo -u postgres psql -c '\du'
sudo -u postgres psql -d ppt_terror_db -c '\dt'
```
