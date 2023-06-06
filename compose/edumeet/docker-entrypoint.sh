#!/bin/bash 

echo "Container starting up..." 
set -e 

#echo ${BASEDIR}/${EDUMEET}
cd ${BASEDIR}/${EDUMEET}/server
node ${BASEDIR}/${EDUMEET}/server/server.js
exec "$@"