#!/bin/bash

set

source /usr/bin/initHPVSoP.sh

#export NGINX=/usr/local/nginx

chmod +x /usr/local/nginx/gencert.sh

/usr/local/nginx/gencert.sh

cat /data/conf/nginx.conf

chmod +x /usr/local/nginx/sbin/nginx

/usr/local/nginx/sbin/nginx -c /data/conf/nginx.conf
