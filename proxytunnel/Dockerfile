FROM alpine as build

RUN apk --update add \
      git \
      build-base \
      libressl-dev \
&& mkdir -p /usr/src \
&& git clone https://github.com/proxytunnel/proxytunnel.git /usr/src/proxytunnel \
&& cd /usr/src/proxytunnel \
&& make

######################################################################################################
FROM alpine

# Copy Gemfile.lock from the previous stage
COPY --from=build /usr/src/proxytunnel/proxytunnel /usr/bin/proxytunnel

RUN apk --update --no-cache add libressl \
&& rm -rf /var/cache/apk/* \
          /usr/lib/ruby/gems/*/cache/* \
          /tmp/* \
          /var/tmp/*

