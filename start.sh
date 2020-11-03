#!/bin/bash

echo "========== list ==========="
ps -ef
ls -l /bin
#/bin/systemctl status

echo "========== service status =========="
/etc/init.d/ssh status
ll /etc/ssh/
whoami
echo "========== service start =========="
/etc/init.d/ssh start
echo "========== service status =========="
/etc/init.d/ssh status


rm -r /etc/ssh/ssh*key
dpkg-reconfigure openssh-server

echo "========== service status =========="
/etc/init.d/ssh status

ls -al /etc/ssh/ssh*key

echo "start mongo db"
/usr/bin/mongod -f /etc/mongod.conf

