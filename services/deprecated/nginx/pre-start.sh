#!/bin/bash
# This script is part of services/deprecated/nginx.
cd $( dirname -- "$0"; )
rm -rf run/*
touch  /run/hiddify-nginx.pid