FROM python:2-alpine

LABEL maintainer="Andrius Kairiukstis <k@andrius.mobi>"

RUN apk --update --no-cache add git \
&& git clone https://github.com/ashinkarov/fbless.git ./fbless \
&& cd ./fbless/ \
&& sed -i "s/default_charset = locale.getdefaultlocale()\[1\]/default_charset = 'UTF-8'/g" ./fbless_lib/main.py \
&& cp fblessrc.example ~/.fblessrc \
&& python ./setup.py install \
&& cd .. \
&& rm -rf fbless \
&& apk --purge del git \
&& rm -rf /var/cache/apk/* \
          /tmp/* \
          /var/tmp/*

ENTRYPOINT ["/usr/local/bin/fbless"]
CMD ["/book.fb2"]
