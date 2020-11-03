#!/bin/bash

echo "========== list ==========="
ps -ef
ls -l /bin
/bin/systemctl status

echo "========== service status =========="
/etc/init.d/ssh status

echo "========== service start =========="
/etc/init.d/ssh start

echo "start mongo db"
/usr/bin/mongod -f /etc/mongod.conf

