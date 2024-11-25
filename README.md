# Home Lab Proxy with DDNS
> nginx reverse proxy with dynamic dns to _hide_ home/lab wan ip

# Why
This was created to hide/obfuscate my home wan ip to users of servers on my home network.

# Design

### `pkg/traefik`

- Primary entrypoint that handles SSL via Cloudflare.
- This handles all proxies:
  - To the DDNS server
  - To the labs

### `pkg/ddns`
> [`minidyndns`](https://github.com/arkanis/minidyndns) dynamic dns server 

- This hosts a public, authenticated DDNS api.
- Traefik uses this as it's DNS server

# Environment Vars
> These should be runtime vars, but some are build time for now

`PROXY_DOMAIN`
  - Domain of the proxy `example.com`

`PROXY_HOST`
  - Host of the proxy `proxy.example.com`

`CLOUDFLARE_EMAIL`
  - Email used for cloudflare SSL

---

`DDNS_LAB1_PASS`
  - DDNS Password for update lab1 IP

`DDNS_LAB1_IP`
  - DDNS Initial IP for lab1
  - Will likely overwrite IP to an old IP. Will figure out later

`DDNS_LAB2_PASS`
  - DDNS Password for update lab2 IP

`DDNS_LAB2_IP`
  - DDNS Initial IP for lab2
  - Will likely overwrite IP to an old IP. Will figure out later

---

`PROXY_LAB1_DOMAIN`
  - Domain for HTTP routing to lab1
  - Not used right now

`PROXY_LAB2_DOMAIN`
  - Domain for HTTP routing to lab2
