#!/bin/sh

kill_sockd() {
  killall -9 sockd >/dev/null 2>&1
  sleep 2
  killall -9 sockd >/dev/null 2>&1
}

onexit() {
  echo 'Terminating sockd process by signal (SIGINT, SIGTERM, SIGKILL, EXIT)' 2>&1
  kill_sockd
  echo 'sockd proces terminated' 2>&1
  exit 0
}
trap onexit SIGINT SIGTERM SIGKILL EXIT

# Print message to the stderr if ENV variable DEBUG set to 'true'
debug() {
  local MESSAGE=$1
  echo -e ${MESSAGE} 2>&1
}

## Creating dante socks server config in /etc/sockd.conf
create_dante_config() {
debug "Generating dante config in /etc/sockd.conf"
cat >/etc/sockd.conf <<EOL
logoutput: stderr

internal: ${SOCKS_LISTEN} port = ${SOCKS_PORT}
external: ${SOCKS_GATEWAY}

# auth with user login, passwd
socksmethod: ${SOCKS_AUTH}

client pass {
  from: 0.0.0.0/0 to: 0.0.0.0/0
  log: error # connect disconnect iooperation
}

socks pass {
  from: 0.0.0.0/0 to: 0.0.0.0/0
  command: bind connect udpassociate
  log: error # connect disconnect iooperation
}

# generic pass statement for incoming connections/packets
# because something about no support for auth with bindreply udpreply ?
socks pass {
  from: 0.0.0.0/0 to: 0.0.0.0/0
  command: bindreply udpreply
  log: error # connect disconnect iooperation
}
EOL
}


create_dante_config

# if SOCKS_AUTH is 'username' and both SOCKS_USER and SOCKS_PASSWORD defined, create that user
if [[ "${SOCKS_AUTH}" == "username" && "${SOCKS_USERNAME}" != "" && "${SOCKS_PASSWORD}" != "" ]]; then
  adduser -D -s /bin/false ${SOCKS_USERNAME}
  echo "${SOCKS_USERNAME}:${SOCKS_PASSWORD}" | chpasswd
fi

if [ "$@" != "" ]; then
  exec "$@"
else
  while true
  do
    sockd -f /etc/sockd.conf
    debug 'Some issue with sockd, restarting'
    kill_sockd
  done
fi
