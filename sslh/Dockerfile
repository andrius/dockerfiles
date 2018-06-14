FROM alpine

RUN apk --update --no-cache --allow-untrusted --repository http://dl-4.alpinelinux.org/alpine/edge/testing/ add \
      sslh \
&& rm -rf /var/cache/apk/* \
          /tmp/* \
          /var/tmp/*

ENV VERBOSE false
ENV TIMEOUT 5
ENV LISTEN_IP 0.0.0.0
ENV LISTEN_PORT 443
ENV HTTPS_HOST 127.0.0.1
ENV HTTPS_PORT 8443
ENV SSH_HOST 127.0.0.1
ENV SSH_PORT 22
ENV OPENVPN_HOST 127.0.0.1
ENV OPENVPN_PORT 1194
# Optional ENV parameters:
# TINC_HOST and TINC_PORT
# XMPP_HOST and XMPP_PORT
# ADB_HOST and ADB_PORT

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
