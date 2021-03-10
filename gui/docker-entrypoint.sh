#!/bin/sh

# Add the ssh config if needed
if [ ! -f "/etc/ssh/sshd_config" ]; then
  cp /ssh_orig/sshd_config /etc/ssh
fi

if [ ! -f "/etc/ssh/ssh_config" ]; then
  cp /ssh_orig/ssh_config /etc/ssh
fi

if [ ! -f "/etc/ssh/moduli" ]; then
  cp /ssh_orig/moduli /etc/ssh
fi

# generate fresh rsa key if needed
if [ ! -f "/etc/ssh/ssh_host_rsa_key" ]; then
  ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
fi

# generate fresh dsa key if needed
if [ ! -f "/etc/ssh/ssh_host_dsa_key" ]; then
  ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
fi

#prepare run dir
mkdir -p /var/run/sshd \
         /home/ak/.x11vnc

# update user password
LOGIN_PASSWORD=${LOGIN_PASSWORD:-vncpAssw0rd}
echo "Login user: ak, password: ${LOGIN_PASSWORD}"
echo "ak:${LOGIN_PASSWORD}" | /usr/sbin/chpasswd
/usr/bin/x11vnc -storepasswd ${LOGIN_PASSWORD} /home/ak/.x11vnc/passwd

#prepare xauth
touch /home/ak/.Xauthority

# generate machine-id
uuidgen > /etc/machine-id

# set keyboard for all sh users
echo "export QT_XKB_CONFIG_ROOT=/usr/share/X11/locale" >> /etc/profile


source /etc/profile

chown -R ak:ak /home/ak/

exec "$@"
