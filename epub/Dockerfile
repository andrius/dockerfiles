FROM alpine

RUN apk --update --no-cache add python \
      py-pip git build-base jpeg-dev zlib-dev python-dev ncurses-dev bash \
&& git clone https://github.com/rupa/epub.git /tmp/epub \
&& cd /tmp/epub/ \
&& pip install -r ./dependencies.txt; pip install Pillow BeautifulSoup4 fabulous readline \
&& cp epub.py /usr/bin/epub \
&& cd ~ \
&& apk --purge del py-pip git build-base jpeg-dev zlib-dev python-dev ncurses-dev \
&& rm -rf /var/cache/apk/* \
          /tmp/* \
          /var/tmp/*

ENTRYPOINT ["/usr/bin/epub"]
CMD ["-h"]
