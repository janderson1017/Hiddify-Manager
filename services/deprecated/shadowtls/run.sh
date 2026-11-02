# This script is part of services/deprecated/shadowtls.
for req in ./shadowtls;do
    which $req
    if [[ "$?" != 0 ]];then
            bash install.sh
            break
    fi
done

systemctl daemon-reload
systemctl restart shadowtls