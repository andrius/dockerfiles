FROM alpine:3

ENV SSH_USERNAME            my-username
ENV SSH_PASSWORD            good-try-dude
ENV SSH_HOST                10.0.129.12
ENV SSH_OPTIONS             ''
ENV SSH_PORT                22
ENV SOCKS_PROXY             docker.for.mac.host.internal:1080

# you may need --auto-nets option too
# -x excludes networks
ENV SSHUTTLE_OPTIONS        '--dns --disable-ipv6 -x 127.0.0.1/24'

# -v or -vvv in EXTRA options just add verbosity
ENV SSHUTTLE_EXTRA_OPTIONS  ''

ENV SSHUTTLE_NETWORKS       0/0

RUN echo \
# curl to test IP address;
# dante - dante client provide socksify command;
# connect.c - classic solution to ssh through proxy (socks and http) with authentication capabilities;
# nc (netcat) and socat - same but with no proxy authentication;
# sshuttle - "vpn" solution, route TCP traffic through ssh connection;
# sshpass - ssh password authentication (octopus does not accept ssh keys)
&& apk add --update --allow-untrusted --repository http://dl-4.alpinelinux.org/alpine/edge/testing/ \
            curl \
            openssh-client \
            netcat-openbsd \
            socat \
            sshpass \
            iptables \
            python \
            py-setuptools \
            mercurial \
            build-base \

# building connect.c
&& hg clone https://bitbucket.org/gotoh/connect /usr/src/connect \
&& cd /usr/src/connect \
&& hg up 1.105 \
&& make \
&& cp connect /usr/bin \
&& cd / \
&& rm -rf /usr/src/connect \

# installing sshuttle
&& easy_install-2.7 pip \
&& pip install sshuttle \
&& pip uninstall -y pip \

# Cleanup, removing unnnecessary packages to dry image
&& apk del --purge \
           mercurial \
           build-base \
           py-setuptools \

# cackes cleanup
&& rm -rf /var/cache/apk/* \
          /tmp/* \
          /var/tmp/*

COPY ssh /root/.ssh
RUN chown -R root:root /root/.ssh \
&& chmod 0600 /root/.ssh/* \
&& mv /etc/ssh/ssh_config /etc/ssh/ssh_config-default \
&& ln -s /root/ssh/ssh_config /etc/ssh/ssh_config

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
