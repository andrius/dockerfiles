#!/bin/sh

if [ "$1" = "" ]; then
  exec /noVNC/utils/launch.sh --vnc ${VNC_SERVER}:${VNC_PORT} --listen ${LISTEN_INTERFACE}:${LISTEN_PORT}
else
  exec "$@"
fi
