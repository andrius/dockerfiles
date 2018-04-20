FROM alpine:edge

MAINTAINER Andrius Kairiukstis <andrius@kairiukstis.com>

ENV BUTTERFLY_USER     butterfly
ENV BUTTERFLY_PASSWORD b1u2t3t4e5r6f7l8y

WORKDIR /app

RUN echo \
&& echo \

&& apk --update add bash \
                    openssh-client \
                    python \
                    python2 \
                    build-base \
                    python2-dev \
                    py-setuptools \
                    libffi-dev \
                    libressl-dev \

&& easy_install-2.7 pip \
&& pip install butterfly \
               butterfly[themes] \
&& pip uninstall -y pip \

# Cleanup, removing unnnecessary packages to dry image
&& apk --purge del build-base \
                   py-setuptools \
                   python2-dev \
                   libffi-dev \
                   libressl-dev \

# cackes cleanup
&& rm -rf /var/cache/apk/* \
       /tmp/* \
       /var/tmp/* \
&& echo

EXPOSE 57575

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["butterfly.server.py", "--unsecure", "--host=0.0.0.0", "--port=57575", "--login"]
