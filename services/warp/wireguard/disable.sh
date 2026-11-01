# This script is part of services/warp/wireguard.
systemctl stop --now wg-quick@warp
systemctl disable wg-quick@warp