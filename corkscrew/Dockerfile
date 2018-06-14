FROM alpine

RUN apk --update --no-cache --allow-untrusted --repository http://dl-4.alpinelinux.org/alpine/edge/testing/ add \
      corkscrew \
&& rm -rf /var/cache/apk/* \
          /tmp/* \
          /var/tmp/*
