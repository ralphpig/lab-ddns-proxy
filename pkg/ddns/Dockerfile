FROM ruby:alpine as init
  RUN apk add --no-cache gettext
  RUN addgroup minidyndns
  RUN adduser -D minidyndns -G minidyndns

FROM init
  COPY . /srv
  WORKDIR /srv

  RUN cp config.yml minidyndns/config.yml
  RUN cp db.yml minidyndns/db.yml

  RUN chown -R minidyndns:minidyndns minidyndns/
  RUN chmod -R 770 minidyndns/

  WORKDIR minidyndns/
  CMD [ "ruby", "dns.rb" ]