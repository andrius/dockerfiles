FROM alpine

RUN apk add --update --allow-untrusted --repository http://dl-4.alpinelinux.org/alpine/edge/testing/ \
      dante-server \
&& rm -rf /etc/sockd.conf \
&& rm -rf /var/cache/apk/* \
          /tmp/* \
          /var/tmp/*

COPY docker-entrypoint.sh  /
ENTRYPOINT ["/docker-entrypoint.sh"]

############################################################################################
#
# Configuration data and ENV variables
#
# SOCKS_LISTEN could be IP address (x.x.x.x) or network interface (eth0)
ENV SOCKS_LISTEN   0.0.0.0
ENV SOCKS_PORT     1080
ENV SOCKS_GATEWAY  eth0
# SOCKS_AUTH could be none or username
ENV SOCKS_AUTH     none
# if SOCKS_AUTH = username, credentials should be provided
ENV SOCKS_USERNAME s0cks_user
ENV SOCKS_PASSWORD socks_passw0rd
