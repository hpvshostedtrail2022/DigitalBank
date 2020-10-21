#!bin/bash

# if [ -z "$DB2INST1_PASSWORD" ]; then
#   echo ""
#   echo >&2 'error: DB2INST1_PASSWORD not set'
#   echo >&2 'Did you forget to add -e DB2INST1_PASSWORD=... ?'
#   exit 1
# else
#   echo -e "$DB2INST1_PASSWORD\n$DB2INST1_PASSWORD" | passwd db2inst1
# fi

# function start {
#   mount -o remount, exec /tmp && \
#   /SETUP/tmp/DB2INSTALLER/server_dec/db2_install -b /opt/ibm/db2/V11.5 -n -y -p SERVER
#   rm -r /SETUP/tmp
#   /opt/ibm/db2/V11.5/instance/db2icrt -u db2inst1 db2inst1
#   /bin/su -c "db2level" - db2inst1
#   /bin/su -c "db2sampl" - db2inst1
#   /bin/su -c "/home/db2inst1/sqllib/adm/db2start" - db2inst1
# }

function cfghost {
  mount -o remount, exec /tmp
  cat /etc/hosts
  cat /home/db2inst1/sqllib/db2nodes.cfg 
  VMNAME=$(cat /etc/hosts | tail -n 1 | awk '{print $2}')
  echo "0 $VMNAME 0" > /home/db2inst1/sqllib/db2nodes.cfg 
  cat /home/db2inst1/sqllib/db2nodes.cfg
  ls /home/db2inst1/sqllib
}

# function test {
#   /bin/su -c "db2level" - db2inst1
#   /bin/su -c "db2sampl" - db2inst1
# }

function start {
  #db2iupdt db2inst1 
  /bin/su -c "db2licm -l" - db2inst1
  /bin/su -c "db2level" - db2inst1
  /bin/su -c "db2sampl" - db2inst1
  trap stop SIGTERM
  # echo "Attempting to stop any DB2 instances"
  # /bin/su -c "db2stop force" - db2inst1
  # echo "Attempting to clean up IP resources"
  # /bin/su -c "ipclean" - db2inst1
  echo "Attempting to start DB2 instance"
  /bin/su -c "db2start" - db2inst1
  echo DB2 started on `date`
  tail -F /home/db2inst1/sqllib/db2dump/db2diag.log &
  LOG_PID=$!
  wait $LOG_PID
}

function stop {
  echo "Attempting to stop DB2"
  /bin/su -c "db2stop force" - db2inst1
  /bin/su -c "ipclean" - db2inst1
  echo DB2 stopped on `date`
  exit
}

function run {
  # Execute all commands as the DB admin
  /bin/su -c "$*" - db2inst1
}

cfghost

"$@"

exec " /sbin/init & "