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

ls /etc/init.d -l

echo "start mongo db"
/usr/bin/mongod -f /etc/mongod.conf --fork

#sed -i "s/#security/security/" /etc/mongod.conf
#sed -i "s/#  auth/  auth/" /etc/mongod.conf

echo "add mongodb user"

mongo admin --eval "db.createUser({user:\"admin\", pwd:\"Passw0rd\", roles:[{role:\"userAdminAnyDatabase\", db:\"admin\"}]})"
mongo test --eval "db.createUser({user:\"test\", pwd:\"Passw0rd\", roles:[{role:\"readWrite\", db:\"test\"}]})"

echo "stop mongo db"
/usr/bin/mongod -f /etc/mongod.conf --shutdown

sed -i "s/#security/security/" /etc/mongod.conf
sed -i "s/#  authorization/  authorization/" /etc/mongod.conf

#ls /etc/init.d
#/etc/init.d/mongod start

# /sbin/init will automatically start mongodb (/etc/rc.local) 
exec /sbin/init
