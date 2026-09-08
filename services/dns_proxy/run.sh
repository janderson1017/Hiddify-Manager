#!/bin/bash
# Enable/disable per-domain DNS tunnel units from generated/dns_proxy/{proto}/.
set -euo pipefail
source /opt/hiddify-manager/scripts/common/utils.sh

BASE="$(cd "$(dirname "$0")" && pwd)"
GEN="${HIDDIFY_GENERATED}/dns_proxy"
PROTOS=(dnstt slipstream masterdns)

sync_proto_instances() {
    local proto="$1"
    local unit="hiddify-${proto}@"
    local dir="${GEN}/${proto}"
    local desired=()
    local instance path

    if [[ -d "$dir" ]]; then
        while IFS= read -r -d '' path; do
            instance="$(basename "$(dirname "$path")")"
            [[ -n "$instance" && "$instance" != "." ]] || continue
            desired+=("$instance")
        done < <(find "$dir" -mindepth 2 -maxdepth 2 \( -name 'args' -o -name 'config.json' -o -name 'server_config.toml' \) -print0 2>/dev/null || true)
    fi

    # Disable instances that are no longer generated.
    local unit_file
    while IFS= read -r unit_file; do
        [[ -n "$unit_file" ]] || continue
        instance="${unit_file#${unit}}"
        instance="${instance%.service}"
        local keep=0
        for d in "${desired[@]+"${desired[@]}"}"; do
            if [[ "$d" == "$instance" ]]; then
                keep=1
                break
            fi
        done
        if [[ $keep -eq 0 ]]; then
            systemctl disable --now "${unit}${instance}.service" >/dev/null 2>&1 || true
        fi
    done < <(systemctl list-unit-files --no-legend "${unit}*.service" 2>/dev/null | awk '{print $1}' || true)

    for instance in "${desired[@]+"${desired[@]}"}"; do
        systemctl enable --now "${unit}${instance}.service" >/dev/null 2>&1 || systemctl restart "${unit}${instance}.service" || true
    done
}

mkdir -p "$GEN"/{dnstt,slipstream,masterdns}
chown -R dns_proxy:dns_proxy "$GEN" 2>/dev/null || true
# dnstm.json lives at generated/ (not under dns_proxy/)
chown dns_proxy:dns_proxy "${HIDDIFY_GENERATED}/dnstm.json" 2>/dev/null || true

for proto in "${PROTOS[@]}"; do
    sync_proto_instances "$proto"
done

# DNSTM multi-tunnel router on :53
DNSTM_CFG="${HIDDIFY_GENERATED}/dnstm.json"
if [[ -f "$DNSTM_CFG" ]] && grep -q '"domain"' "$DNSTM_CFG" 2>/dev/null; then
    ln -sfn "$BASE/hiddify-dnstm-router.service" /etc/systemd/system/hiddify-dnstm-router.service
    systemctl daemon-reload
    systemctl enable --now hiddify-dnstm-router.service || systemctl restart hiddify-dnstm-router.service || true
else
    systemctl disable --now hiddify-dnstm-router.service >/dev/null 2>&1 || true
fi
