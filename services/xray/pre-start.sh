#!/bin/bash
# This script is part of services/xray.
cd $( dirname -- "$0"; )
rm -rf run/*
rm -rf /dev/shm/hiddify-xtls-main.sock