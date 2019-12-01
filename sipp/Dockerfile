# vim:set ft=dockerfile:
FROM alpine

LABEL maintainer="Andrius Kairiukstis <k@andrius.mobi>"

RUN apk --update --no-cache add \
      sipp \
&& rm -rf /var/cache/apk/* \
          /tmp/* \
          /var/tmp/*

CMD ["sipp"]
