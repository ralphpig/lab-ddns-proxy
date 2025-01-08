services:
    ddns:
        container_name: ddns
        build:
            context: pkg/ddns
        restart: unless-stopped
        expose:
            - 53 # DNS
            - 8000 # HTTP
        labels:
          - "traefik.http.routers.ddns.rule=Host(`${PROXY_HOST}`)"
          - "traefik.http.routers.ddns.entrypoints=websecure"
          - "traefik.http.routers.ddns.tls.certresolver=cloudflare"
          - "traefik.http.routers.ddns.middlewares=https_redirect"
          - "traefik.http.services.ddns.loadbalancer.server.port=8000"
        networks:
          traefik_bridge:
            ipv4_address: 172.74.0.10

    traefik:
        container_name: traefik
        image: traefik:v3
        container_name: traefik
        restart: unless-stopped
        depends_on:
            - ddns
        dns:
            - 172.74.0.10 # static ip of ddns
            - 1.1.1.1
            - 1.0.0.1
        labels:
          # @docker HTTPS Redirect Middleware
          - "traefik.http.middlewares.https_redirect.redirectscheme.scheme=https"
          - "traefik.http.middlewares.https_redirect.redirectscheme.permanent=true"
        ports:
          - "80:80"                                          # HTTP (used for automatic redirection)
          - "443:443"                                        # HTTPS
          - "34197:34197/udp"                                # factorio
          - "2456:2456/udp"                                  # valheim
          - "2457:2457/udp"                                  # valheim
        volumes:
          - "/var/run/docker.sock:/var/run/docker.sock:ro"   # Allow Traefik to interact with Docker
          - "/etc/letsencrypt:/letsencrypt"                  # Store SSL certificates
          - "./pkg/traefik:/etc/traefik"
        environment:
          - "CLOUDFLARE_ZONE_API_TOKEN=${CLOUDFLARE_API_TOKEN}"
          - "CLOUDFLARE_DNS_API_TOKEN=${CLOUDFLARE_API_TOKEN}"
        networks:
          - traefik_bridge
        # route to containers on network_mode=host
        # extra_hosts:
        # - host.docker.internal:host-gateway

networks:
  traefik_bridge:
    driver: bridge
    name: traefik_bridge
    ipam:
      driver: default
      config:
        - subnet: 172.74.0.1/16
