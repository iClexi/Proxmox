#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STAMP="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

redact() {
  sed -E \
    -e 's/(--token )[A-Za-z0-9._=-]+/\1[REDACTED]/g' \
    -e 's/(token: )[A-Za-z0-9._=-]+/\1[REDACTED]/g' \
    -e 's/(Tunnel token: )[A-Za-z0-9._=-]+/\1[REDACTED]/g' \
    -e 's/(password|passwd|secret|api[_-]?key|token|credential|private[_-]?key)([=: ][ ]*)[^[:space:]]+/\1\2[REDACTED]/Ig' \
    -e 's/(sshkeys: ).*/\1[REDACTED_PUBLIC_KEY]/g'
}

capture() {
  local output="$1"
  shift
  mkdir -p "$(dirname "$ROOT_DIR/$output")"
  {
    printf '# Captured: %s\n' "$STAMP"
    printf '# Command:'
    printf ' %q' "$@"
    printf '\n\n'
    "$@" 2>&1 | redact
  } > "$ROOT_DIR/$output"
}

capture_shell() {
  local output="$1"
  local command="$2"
  mkdir -p "$(dirname "$ROOT_DIR/$output")"
  {
    printf '# Captured: %s\n' "$STAMP"
    printf '# Command: %s\n\n' "$command"
    bash --noprofile --norc -lc "$command" 2>&1 | redact
  } > "$ROOT_DIR/$output"
}

mkdir -p "$ROOT_DIR/inventory/proxmox" "$ROOT_DIR/inventory/vms" "$ROOT_DIR/configs/sanitized/proxmox/systemd"

capture inventory/proxmox/pveversion.txt pveversion -v
capture inventory/proxmox/qm-list.txt qm list
capture inventory/proxmox/pct-list.txt pct list
capture inventory/proxmox/storage-status.txt pvesm status
capture inventory/proxmox/network-interfaces.txt sed -n 1,220p /etc/network/interfaces
capture inventory/proxmox/ip-addresses.txt ip -br addr
capture inventory/proxmox/routes.txt ip route
capture inventory/proxmox/listening-ports.txt ss -tulpn
capture inventory/proxmox/postgresql-databases.txt sudo -u postgres psql -c "\\l"
capture inventory/proxmox/postgresql-roles.txt sudo -u postgres psql -c "\\du"
capture inventory/proxmox/cloudflared-tunnels.txt cloudflared tunnel list
capture inventory/proxmox/system-services-running.txt systemctl --type=service --state=running --no-pager
capture inventory/proxmox/system-services-enabled.txt systemctl list-unit-files --state=enabled --no-pager
capture inventory/proxmox/ha-status.txt ha-manager status

for service in \
  cloudflared.service \
  cloudflared-portfolio.service \
  portfolio.service \
  ppt-terror-proxy.service \
  ha-web-proxy.service \
  ritmohub-proxy.service \
  minecraft-socat.service \
  minecraft-bedrock-socat.service \
  nextcloud-9001-forward.service \
  proxy-http-forward.service \
  proxy-https-forward.service \
  jellyfin-proxy.service \
  pfsense-proxy.service \
  wazuh-dashboard-forward.service \
  wazuh-api-forward.service \
  wazuh-agent-forward.service \
  wazuh-enrollment-forward.service; do
  if systemctl list-unit-files "$service" --no-pager | grep -q "$service"; then
    capture "configs/sanitized/proxmox/systemd/$service.txt" systemctl cat "$service"
  fi
done

if [ -d /etc/cloudflared ]; then
  capture_shell configs/sanitized/proxmox/cloudflared-configs.txt "find /etc/cloudflared -maxdepth 1 -type f -name '*.yml' -o -name '*.yaml' | sort | while read -r f; do printf '## %s\n' \"\$f\"; sed -n '1,220p' \"\$f\"; done"
fi

while read -r vmid name status _rest; do
  [ "$vmid" = "VMID" ] && continue
  vm_dir="$ROOT_DIR/inventory/vms/${vmid}-${name}"
  mkdir -p "$vm_dir"
  capture "inventory/vms/${vmid}-${name}/qm-config.txt" qm config "$vmid"
  if qm agent "$vmid" ping >/dev/null 2>&1; then
    capture "inventory/vms/${vmid}-${name}/guest-hostname.txt" qm guest exec "$vmid" -- hostname
    capture "inventory/vms/${vmid}-${name}/guest-ipv4.txt" qm guest exec "$vmid" -- ip -4 addr show
  else
    printf '# Captured: %s\n# QEMU guest agent unavailable or disabled.\n' "$STAMP" > "$vm_dir/guest-agent.txt"
  fi
done < <(qm list)

printf 'Inventory captured at %s\n' "$STAMP"
