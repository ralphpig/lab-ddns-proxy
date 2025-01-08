http:
  routers:
    proxy_ombi:
      rule: Host(`ombi.${PROXY_LAB2_DOMAIN}`)
      service: proxy_ombi
      entrypoints:
        - websecure
      middlewares:
        - https_redirect
      tls:
        certResolver: cloudflare
  services:
    proxy_ombi:
      loadBalancer:
        servers:
          - url: http://lab2.${PROXY_DOMAIN}:5000

udp:
  routers:
    proxy_factorio:
      service: proxy_factorio
      entrypoints:
        - udp_factorio
    proxy_valheim_1:
      service: proxy_valheim_1
      entrypoints:
        - udp_valheim_1
    proxy_valheim_2:
      service: proxy_valheim_2
      entrypoints:
        - udp_valheim_2
  services:
    proxy_factorio:
      loadBalancer:
        servers:
          - address: lab1.${PROXY_DOMAIN}:34197
    proxy_valheim_1:
      loadBalancer:
        servers:
          - address: lab1.${PROXY_DOMAIN}:2456
    proxy_valheim_2:
      loadBalancer:
        servers:
          - address: lab1.${PROXY_DOMAIN}:2457
