#!/bin/bash
source /opt/hiddify-manager/scripts/common/utils.sh

for proto in dnstt slipstream masterdns; do
    while IFS= read -r unit; do
        [[ -n "$unit" ]] || continue
        systemctl disable --now "$unit" >/dev/null 2>&1 || true
    done < <(systemctl list-unit-files --no-legend "hiddify-${proto}@*.service" 2>/dev/null | awk '{print $1}' || true)
done

systemctl disable --now hiddify-dnstm-router.service >/dev/null 2>&1 || true
