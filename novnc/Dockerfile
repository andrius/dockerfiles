FROM alpine

ENV VNC_SERVER       127.0.0.1
ENV VNC_PORT         5900
ENV LISTEN_INTERFACE 0.0.0.0
ENV LISTEN_PORT      8080

RUN apk --update add \
      git \
      python \
      bash \
\
&& git clone --depth 1 https://github.com/novnc/noVNC.git      /noVNC \
&& git clone --depth 1 https://github.com/novnc/websockify.git /noVNC/utils/websockify \
&& sed -i -- "s/ps -p/ps -o pid | grep/g" /noVNC/utils/launch.sh \
\
&& rm -rf /noVNC/.git \
&& rm -rf /noVNC/utils/websockify/.git \
\
&& apk del git \
&& rm -rf /var/cache/apk/* \
          /tmp/* \
          /var/tmp/*

EXPOSE ${LISTEN_PORT}

ADD docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
