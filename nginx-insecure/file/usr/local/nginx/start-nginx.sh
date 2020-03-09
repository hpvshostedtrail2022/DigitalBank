#!/bin/bash

set

source /usr/bin/initHPVSoP.sh

export NGINX=/usr/local/nginx

cat $NGINX/conf/nginx.conf

$NGINX/sbin/nginx -c $NGINX/conf/nginx.conf