FROM alpine

LABEL maintainer="Andrius Kairiukstis <k@andrius.mobi>"

RUN apk --update --nocache add npm && \
npm install -g wscat

CMD ["wscat"]
