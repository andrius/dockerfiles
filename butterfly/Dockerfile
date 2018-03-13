FROM alpine

MAINTAINER Andrius Kairiukstis <andrius@kairiukstis.com>

WORKDIR /app

RUN echo \
&& echo \

&& apk --update add openssh-client \
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

#CMD ["butterfly.server.py", "--unsecure", "--host=0.0.0.0", "--port=57575", "--login"]
CMD ["butterfly.server.py", "--unsecure", "--host=0.0.0.0", "--port=57575"]
