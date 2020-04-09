#!/bin/sh
# create self-signed server certificate:
DOMAIN="hpvsop.test"
echo "Create server key..."
openssl genrsa -out $DOMAIN.key 1024
echo "Create server certificate signing request..."
SUBJECT="/C=US/ST=Mars/L=iTranswarp/O=iTranswarp/OU=iTranswarp/CN=$DOMAIN"
openssl req -new -subj $SUBJECT -key $DOMAIN.key -out $DOMAIN.csr
echo "Remove password..."
mv $DOMAIN.key $DOMAIN.origin.key
openssl rsa -in $DOMAIN.origin.key -out $DOMAIN.key
echo "Sign SSL certificate..."
openssl x509 -req -days 3650 -in $DOMAIN.csr -signkey $DOMAIN.key -out $DOMAIN.crt
mkdir /usr/local/nginx/ssl
echo "Copy $DOMAIN.crt to /usr/local/nginx/ssl/$DOMAIN.crt"
cp $DOMAIN.crt /usr/local/nginx/ssl/$DOMAIN.crt
echo "Copy $DOMAIN.key to /usr/local/nginx/ssl/$DOMAIN.key"
cp $DOMAIN.key /usr/local/nginx/ssl/$DOMAIN.key
