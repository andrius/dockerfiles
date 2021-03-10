# vim:set ft=dockerfile:
FROM alpine:3.13

LABEL maintainer="Andrius Kairiukstis <k@andrius.mobi>"

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
&&  echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
&&  echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN set -x \
&&  apk add --no-cache --purge -uU \
      libdaemon \
      eudev \
      alsa-lib \
      alsa-utils \
      aspell-en \
      avahi \
      bash \
      bluez \
      bluez-firmware \
      bluez-libs \
      ca-certificates \
      curl \
      dbus \
      dhcpcd \
      dhcpcd-dbus \
      dhcpcd-ui \
      expect \
      faenza-icon-theme \
      firefox \
      gnumeric \
      libconfig \
      libressl3.1-libcrypto \
      mc \
      mpg123 \
      openssh \
      paper-gtk-theme \
      paper-icon-theme \
      poppler \
      poppler-glib \
      popt \
      pulseaudio \
      pulseaudio-alsa \
      pulseaudio-bluez \
      pulseaudio-dev \
      pulseaudio-jack \
      pulseaudio-utils \
      pulseaudio-zeroconf \
      python3 \
      py3-pip \
      ristretto \
      setxkbmap \
      slim \
      soxr \
      sudo \
      supervisor \
      thunar-volman \
      ttf-freefont \
      util-linux \
      x11vnc \
      xauth \
      xf86-input-vmmouse \
      xf86-input-synaptics \
      xf86-video-dummy \
      xfce4 \
      xfce4-terminal \
      xfce4-xkb-plugin-lang \
      xorg-server \
      xrdp \
      xscreensaver \
      xvfb \
&&  pip install --upgrade setuptools \
&&  rm -rf /var/cache/apk/* \
           /tmp/*

RUN  curl -o /usr/local/bin/pulsemixer -jkSL \
             https://raw.githubusercontent.com/GeorgeFilipkin/pulsemixer/master/pulsemixer \
&&  chmod +x /usr/local/bin/pulsemixer

# add scripts/config
ADD etc /etc
ADD docker-entrypoint.sh /bin

# prepare user ak
RUN addgroup ak \
&& adduser  -G ak -s /bin/sh -D ak \
&& echo "ak:ak" | /usr/sbin/chpasswd \
&& echo "ak    ALL=(ALL) ALL" >> /etc/sudoers
ADD home /home/ak
RUN chown -R ak:ak /home/ak

# prepare xrdp key
RUN xrdp-keygen xrdp auto

EXPOSE 5900 3389 22
VOLUME ["/etc/ssh"]

SHELL ["bash", "-c"]
ENTRYPOINT ["/bin/docker-entrypoint.sh"]
CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]
