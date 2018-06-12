FROM alpine

RUN apk --update --no-cache add python git \
&& git clone https://github.com/ashinkarov/fbless.git /tmp/fbless \
&& cd /tmp/fbless/ \
&& sed -i "s/default_charset = locale.getdefaultlocale()\[1\]/default_charset = 'UTF-8'/g" ./fbless_lib/main.py \
&& cp fblessrc.example ~/.fblessrc \
&& python ./setup.py install \
&& cd ~ \
&& apk --purge del git \
&& rm -rf /var/cache/apk/* \
          /tmp/* \
          /var/tmp/*

ENTRYPOINT ["/usr/bin/fbless"]
CMD ["/book.fb2"]
