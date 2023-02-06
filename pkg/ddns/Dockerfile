FROM ruby:alpine as init
  RUN apk add --no-cache gettext
  RUN addgroup minidyndns
  RUN adduser -D minidyndns -G minidyndns

  ARG ROOT_DOMAIN=example.com
  ARG DNS_TARGET_PASS=pass
  ARG DNS_TARGET_IP=

FROM init
  COPY . /srv
  WORKDIR /srv

  RUN envsubst < config.template.yml > minidyndns/config.yml
  RUN envsubst < db.template.yml > minidyndns/db.yml

  RUN chown -R minidyndns:minidyndns minidyndns/
  RUN chmod -R 770 minidyndns/

  WORKDIR minidyndns/
  CMD [ "ruby", "dns.rb" ]