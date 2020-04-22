#!/bin/bash

#set
echo "start_nginx.sh executing">/usr/local/nginx/111
source /usr/bin/initHPVSoP.sh
chmod 640 /usr/local/nginx/ssl/hpvsop.test.crt
chmod 600 /usr/local/nginx/ssl/hpvsop.test.key
#export NGINX=/usr/local/nginx

#chmod +x /usr/local/nginx/gencert.sh

#/usr/local/nginx/gencert.sh
ldd $(which /usr/local/nginx/sbin/nginx)

#cp /usr/local/nginx/libssl.so.1.1 /lib/s390x-linux-gnu/libssl.so.1.1
#cp /usr/local/nginx/libcrypto.so.1.1 /lib/s390x-linux-gnu/libcrypto.so.1.1

#ldd $(which /usr/local/nginx/sbin/nginx)

cat /data/conf/nginx.conf

chmod +x /usr/local/nginx/sbin/nginx

echo "start_nginx.sh executed">/usr/local/nginx/222

/usr/local/nginx/sbin/nginx -c /data/conf/nginx.conf
