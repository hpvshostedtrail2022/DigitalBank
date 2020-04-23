#!/bin/bash

#set
echo "Prepare start_nginx.sh">/usr/local/nginx/111

chmod 640 /usr/local/nginx/ssl/hpvsop.test.crt
chmod 600 /usr/local/nginx/ssl/hpvsop.test.key

#chmod +x /usr/local/nginx/gencert.sh
#/usr/local/nginx/gencert.sh

ldd $(which /usr/local/nginx/sbin/nginx)

#cp /usr/local/nginx/libssl.so.1.1 /lib/s390x-linux-gnu/libssl.so.1.1
#cp /usr/local/nginx/libcrypto.so.1.1 /lib/s390x-linux-gnu/libcrypto.so.1.1

cat /data/conf/nginx.conf

chmod +x /usr/local/nginx/sbin/nginx

/usr/local/nginx/sbin/nginx -c /data/conf/nginx.conf

echo "start_nginx.sh executed">/usr/local/nginx/222

source /usr/bin/initHPVSoP.sh
