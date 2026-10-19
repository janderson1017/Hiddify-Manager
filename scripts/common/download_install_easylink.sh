#!/bin/sh
# This script is part of scripts/common.

export CREATE_EASYSETUP_LINK="true"
bash -c "$(curl -Lfo- https://raw.githubusercontent.com/hiddify/hiddify-manager/main/scripts/common/download_install.sh)"