#!/usr/bin/env bash
# This script is part of .github.
previous_release=$(curl --silent "https://api.github.com/repos/hiddify/hiddify-manager/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')
current=$(cat VERSION)
#gitchangelog "${previous_release}..v$current"
