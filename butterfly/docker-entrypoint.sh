#!/bin/bash -e

# create user and set password
adduser -D -s /bin/bash ${BUTTERFLY_USER:-root}
echo "${BUTTERFLY_USER:-root}:${BUTTERFLY_PASSWORD:-password}" | chpasswd 2>/dev/null

# if command starts with an option, prepend the default command and options
if [ "${1:0:1}" = '-' ]; then
  set -- butterfly.server.py --unsecure --host=0.0.0.0 --port=${BUTTERFLY_PORT:-57575} "$@"
elif [ "$1" = 'butterfly.server.py' ]; then
  shift
  set -- butterfly.server.py --unsecure --host=0.0.0.0 --port=${BUTTERFLY_PORT:-57575} "$@"
fi
echo "env"
env

echo "set"
set

echo "Command line:"
echo "$@"

# exec su - ${BUTTERFLY_USER:-root} -c /run.sh -- "$@"


exec  "$@"
