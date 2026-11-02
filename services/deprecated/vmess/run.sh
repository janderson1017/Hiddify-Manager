# This script is part of services/deprecated/vmess.
systemctl kill v2ray
rm /usr/local/etc/v2ray/config.json
ln -sf $(pwd)/config.json /usr/local/etc/v2ray/config.json

systemctl enable v2ray
systemctl restart v2ray