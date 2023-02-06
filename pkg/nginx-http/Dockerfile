FROM nginx:stable-alpine as init

ARG PROXY_DOMAIN=proxy.example.com

COPY . .

RUN envsubst '$PROXY_DOMAIN' < nginx.template.conf > /etc/nginx/nginx.conf

EXPOSE 80
