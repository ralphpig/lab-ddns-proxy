# Home Lab Proxy with DDNS
> nginx reverse proxy with dynamic dns to _hide_ home/lab wan ip

# Why
This was created to hide/obfuscate my home wan ip to users of servers on my home network.

# Design

### `pkg/ddns`
> [`minidyndns`](https://github.com/arkanis/minidyndns) dynamic dns server 

This hosts a public api to update an A record that can be used by a dynamic dns client.
Nginx uses this internally.

### `pkg/nginx`
> primary proxy. https routing for `pkg/ddns`. 

### `pkg/nginx_http`
> http redirect with routing for letsencrypt acme-challenge

# Environment Vars
> These should be runtime vars, but are build time for now

`DNS_TARGET_PASS`
  - DDNS API Password

`DNS_TARGET_IP`
  - Initial DDNS IP. Optional

> `pkg/ddns` generates the `db.yml` at build time using these. `db.yml` should really be in a volume

`ROOT_DOMAIN`
  - Root domain of proxy server
  - Used for `ddns`

`PROXY_DOMAIN`
  - Full domain that proxy is hosted at (both `ddns` and primary `nginx` proxy)
  - Also used for letsencrypt
  
`LETSENCRYPT_EMAIL`
  - LetsEncrypt notification email
