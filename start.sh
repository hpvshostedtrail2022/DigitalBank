#!/bin/bash

echo "========== list ==========="
ps -ef

echo "========== service status =========="
systemctl status sshd

echo "start mongo db"
/usr/bin/mongod -f /etc/mongod.conf

