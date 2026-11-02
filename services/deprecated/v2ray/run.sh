# This script is part of services/deprecated/v2ray.
systemctl kill ss-v2ray.service

ln -sf $(pwd)/ss-v2ray.service /etc/systemd/system/ss-v2ray.service

systemctl enable ss-v2ray.service
chmod 600 *json*

systemctl restart ss-v2ray.service
