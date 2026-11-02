# This script is part of services/deprecated/telegram/tgo.
systemctl kill hiddify-telegram-proxy.service


ln -sf  $(pwd)/hiddify-telegram-proxy.service /etc/systemd/system/hiddify-telegram-proxy.service
systemctl enable hiddify-telegram-proxy.service
chmod 600 *toml*
systemctl restart hiddify-telegram-proxy.service

systemctl status hiddify-telegram-proxy --no-pager