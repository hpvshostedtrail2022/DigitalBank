#!/bin/bash

set

source /usr/bin/initHPVSoP.sh

export NGINX=/usr/local/nginx

cat /data/conf/nginx.conf

$NGINX/sbin/nginx -c /data/conf/nginx.conf
