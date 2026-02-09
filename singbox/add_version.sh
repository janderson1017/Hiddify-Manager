latest=$1
source ../common/package_manager.sh
add_package singbox $latest arm64 https://github.com/hiddify/hiddify-sing-box/releases/download/v$latest/sing-box-$latest-linux-arm64.tar.gz
add_package singbox $latest arm64 https://github.com/hiddify/hiddify-sing-box/releases/download/v$latest/sing-box-$latest-linux-amd64.tar.gz