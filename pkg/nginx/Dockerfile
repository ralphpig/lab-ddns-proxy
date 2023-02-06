FROM nginx:stable-alpine as init

ARG ROOT_DOMAIN=example.com
ARG PROXY_DOMAIN=proxy.example.com

COPY . .

RUN envsubst '$ROOT_DOMAIN,$PROXY_DOMAIN' < nginx.template.conf > /etc/nginx/nginx.conf

# ddns
EXPOSE 443

# factorio
EXPOSE 34197

# project zomboid
EXPOSE 16261
