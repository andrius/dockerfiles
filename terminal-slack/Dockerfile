FROM node:21.2-alpine3.18

# To get token, visit
# https://api.slack.com/custom-integrations/legacy-tokens

# Then:
# export SLACK_TOKEN=?
# docker run --rm -it -e SLACK_TOKEN andrius/terminal-slack
# (or specify it through .env or environment with docker-compose

ENV SLACK_TOKEN 12345

WORKDIR /app

RUN apk --no-cache add --virtual build-dependencies git \
&& git clone https://github.com/evanyeung/terminal-slack.git /app \
&& npm install \
&& apk del build-dependencies \
&& rm -rf /var/cache/apk/* \
          /tmp/* \
          /var/tmp/*

ENTRYPOINT ["node"]
CMD ["main.js"]
