FROM golang:alpine

RUN apk --update add git \
                     wget \
&& go get github.com/mpolden/ipd/... \
&& wget -O /index.html https://raw.githubusercontent.com/mpolden/ipd/master/index.html

FROM alpine:latest
# RUN apk --no-cache add ca-certificates \

COPY --from=0 /go/bin/ipd /bin/ipd
COPY --from=0 /index.html /etc/ipd/index.html

EXPOSE 8080

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["ipd", "--reverse-lookup", "--template=/etc/ipd/index.html"]
