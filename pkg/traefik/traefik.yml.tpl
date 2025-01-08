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
  udp_valheim_1:
    address: ":2456/udp"
  udp_valheim_2:
    address: ":2457/udp"

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