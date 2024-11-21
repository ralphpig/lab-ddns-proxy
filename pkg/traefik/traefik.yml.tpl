api:
  dashboard: false
  insecure: false

providers:
  docker: true
  file:
    directory: /etc/traefik/config
    watch: false

entryPoints:
  web:
    address: ":80/tcp"
  websecure:
    address: ":443/tcp"
  udp_factorio:
    address: ":34197/udp"

certificatesResolvers:
  cloudflare:
    acme:
      email: ${CLOUDFLARE_EMAIL}
      storage: /letsencrypt/acme.json
      dnsChallenge:
        provider: cloudflare

log:
  level: INFO
accessLog: {}