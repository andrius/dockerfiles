# vim:set ft=dockerfile:
FROM alpine:edge

LABEL maintainer="Andrius Kairiukstis <k@andrius.mobi>"

# add packages
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk --update --no-cache add \
      bash \
      mc \
      xrdp \
      xvfb \
      xfce4 \
      xfce4-xkb-plugin-lang \
      thunar-volman \
      faenza-icon-theme \
      paper-gtk-theme \
      paper-icon-theme \
      slim \
      xf86-input-synaptics \
      xf86-input-mouse \
      xf86-input-keyboard \
      setxkbmap \
      openssh \
      util-linux \
      dbus \
      ttf-freefont \
      xauth \
      supervisor \
      x11vnc \
      sudo \
&& rm -rf /tmp/*

# RUN apk --update --no-cacke add
#       alpine-desktop \
# && rm -rf /tmp/* \

RUN apk --update --no-cache add \
      aspell-en \
      dhcpcd \
      dhcpcd-ui \
      dhcpcd-dbus \
      firefox \
      gnumeric \
      ristretto \
      xorg-server \
      xf86-video-dummy \
      xscreensaver \
      ca-certificates \
      poppler \
      poppler-glib \
&& rm -rf /tmp/*

# add scripts/config
ADD etc /etc
ADD docker-entrypoint.sh /bin

# prepare user alpine
RUN addgroup alpine \
&& adduser  -G alpine -s /bin/sh -D alpine \
&& echo "alpine:alpine" | /usr/sbin/chpasswd \
&& echo "alpine    ALL=(ALL) ALL" >> /etc/sudoers
ADD alpine /home/alpine
RUN chown -R alpine:alpine /home/alpine

# prepare xrdp key
RUN xrdp-keygen xrdp auto

EXPOSE 5900 3389 22
VOLUME ["/etc/ssh"]

SHELL ["bash", "-c"]
ENTRYPOINT ["/bin/docker-entrypoint.sh"]
CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]
