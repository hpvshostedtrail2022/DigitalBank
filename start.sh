#!/bin/bash

echo "========== list ==========="
ps -ef
ls -l /bin
#/bin/systemctl status

whoami

#rm -r /etc/ssh/ssh*key
#dpkg-reconfigure openssh-server

#echo "========== service status =========="
#/etc/init.d/ssh status

#ls -al /etc/ssh/ssh*key

ls /usr/init.d -l

echo "start mongo db"
/usr/bin/mongod -f /etc/mongod.conf &

echo "stop mongo db"
/usr/bin/mongod -f /etc/mongod.conf --shutdown


#ls /etc/init.d
#/etc/init.d/mongod start

exec /sbin/init
