mkdir -p /opt/hiddify-manager/acme.sh/www/.well-known/acme-challenge
echo "location /.well-known/acme-challenge {root /opt/hiddify-manager/acme.sh/www/;}" >/opt/hiddify-manager/nginx/parts/acme.conf
chown -R nginx /opt/hiddify-manager/acme.sh/www/

systemctl restart hiddify-nginx