#!/bin/bash

echo "start mongo db"
/usr/bin/mongod -f /etc/mongod.conf &

echo "======================= list ======================"
pgrep mongo -l

#echo ""
