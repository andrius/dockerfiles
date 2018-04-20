#!/bin/sh

onexit() {
  echo '=> Terminating process by signal (SIGINT, SIGTERM, SIGKILL, EXIT)'
  killall -9 sshuttle ssh sshpass
  iptables --flush
  sleep 2
  iptables --flush
  sleep 1
  echo '=> Bye!'
  exit 0
}
trap onexit SIGINT SIGTERM SIGKILL EXIT

MAC_IP=`ping -c 1 docker.for.mac.host.internal 2>/dev/null | grep ' from ' | awk -F ' \|:' '{print $4}'`
if [ "${MAC_IP}" != "" ]; then
  # we have to add record to the /etc/hosts, because after first sshuttle run,
  # host docker.for.mac.host.internal will be unavailable
  grep -q -F 'docker.for.mac.host.internal' /etc/hosts || echo "${MAC_IP} docker.for.mac.host.internal" >> /etc/hosts
  EXCLUDE_MAC_IP="-x ${MAC_IP}/32"
else
  EXCLUDE_MAC_IP=''
fi

DOCKER_IP=`ip -o -f inet addr show | awk '/scope global/ {print $2,$4}' | grep docker | awk '{print $2}'`
if [ "${DOCKER_IP}" != "" ]; then
  EXCLUDE_DOCKER_IP="-x ${DOCKER_IP}"
else
  EXCLUDE_DOCKER_IP=''
fi

if [ "${SOCKS_PROXY}" != "" ]; then
  # SSH_PROXY="-o 'ProxyCommand nc -x ${SOCKS_PROXY} %h %p'"
  SSH_PROXY="-o 'ProxyCommand connect -S ${SOCKS_PROXY} %h %p'"
else
  SSH_PROXY=''
fi

mkdir -p /tmp/ssh

if [ "$1" = "" ]; then
	while true
	do
    echo "=> Setting up sshuttle connection to the ${SSH_USERNAME}@${SSH_HOST}:${SSH_PORT}"
    [ "${SOCKS_PROXY}" != "" ] && echo "   with SSH_PROXY option ${SSH_PROXY}"
    sshpass -p ${SSH_PASSWORD} \
      sshuttle --listen 0.0.0.0 --ssh-cmd "ssh -o StrictHostKeyChecking=no ${SSH_OPTIONS} ${SSH_PROXY}" \
        --remote ${SSH_USERNAME}@${SSH_HOST}:${SSH_PORT} \
        ${SSHUTTLE_OPTIONS} ${SSHUTTLE_EXTRA_OPTIONS} \
        ${EXCLUDE_MAC_IP} ${EXCLUDE_DOCKER_IP} \
        ${SSHUTTLE_NETWORKS}
    echo "=> SSH link down or sshuttle connection failed!"
    echo "=> Wait 5 seconds to reconnect"
    iptables --flush
    sleep 5
    iptables --flush
    echo "=> Reconnecting..."
	done
else
  exec "$@"
fi
