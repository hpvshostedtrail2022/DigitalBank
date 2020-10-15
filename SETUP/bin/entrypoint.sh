#!bin/bash

if [ -z "$DB2INST1_PASSWORD" ]; then
  echo ""
  echo >&2 'error: DB2INST1_PASSWORD not set'
  echo >&2 'Did you forget to add -e DB2INST1_PASSWORD=... ?'
  exit 1
else
  echo -e "$DB2INST1_PASSWORD\n$DB2INST1_PASSWORD" | passwd db2inst1
fi


function start {
  /bin/su -c "db2level" - db2inst1
  /bin/su -c "db2sampl" - db2inst1
  /bin/su -c "/home/db2inst1/sqllib/adm/db2start" -c db2inst1
}

# function start {
#   trap stop SIGTERM
#   echo "Attempting to stop any DB2 instances"
#   /bin/su -c "db2stop force" - db2inst1
#   echo "Attempting to clean up IP resources"
#   /bin/su -c "ipclean" - db2inst1
#   echo "Attempting to start DB2 instance"
#   /bin/su -c "db2start" - db2inst1
#   echo DB2 started on `date`
#   tail -F /home/db2inst1/sqllib/db2dump/db2diag.log &
#   LOG_PID=$!
#   wait $LOG_PID
# }

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

"$@"