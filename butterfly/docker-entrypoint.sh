#!/bin/sh

adduser -D -s  /bin/bash ${BUTTERFLY_USER}
echo "${BUTTERFLY_USER}:${BUTTERFLY_PASSWORD}" | chpasswd 2>/dev/null
# exec su - ${BUTTERFLY_USER} -c "butterfly.server.py --unsecure --host=0.0.0.0 --port=57575 --login"

# if command starts with an option, prepend the default command and options
if [ "${1:0:1}" = '-' ]; then
  set -- butterfly.server.py --unsecure --host=0.0.0.0 --port=${BUTTERFLY_PORT:-57575} "$@"
elif [ "$1" = 'butterfly.server.py' ]; then
  shift
  set -- butterfly.server.py --unsecure --host=0.0.0.0 --port=${BUTTERFLY_PORT:-57575} "$@"
fi

# Set password
echo "root:${BUTTERFLY_PASSWORD:-password}" | chpasswd

exec "$@"
