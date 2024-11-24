# The domain hosted by this DNS server. It will only reply to requests
# regarding subdomains of this domain. Everything is ignored completely.
domain: ${PROXY_DOMAIN}

# Time to live (TTL) of replies send by the DNS server. This is the time
# in seconds an reply stays valid. The higher the value the longer clients
# might take to figure out that an IP address has changed. Small values
# will force a DNS request on every page access. This is ok for seldomly
# used sites but a very bad idea for high traffic sites.
ttl: 60

# IP and port the DNS server runs on
dns:
    port: 53
    ip: 0.0.0.0
    # Set to true to log hex dumps of every incomming DNS packet (for debugging).
    #dump_packets: true

# IP and port the HTTP server runs on
# http: false
http:
    port: 8000
    ip: 0.0.0.0

https: false
# https:
#   port: 443
#   ip: 0.0.0.0
#   cert: server_cert.pem
#   priv_key: server_priv_key.key

trust_proxy: true

# Maximum number of seconds the server waits for clients to send
# the entire HTTP request (to kill requests from stupid routers that
# keep the connections open forever).
http_timeout: 5.0

# The server needs to be started as root to bind to privileged ports
# (everything below 1024). In that case it will drop privileges after
# startup and run under the user and group specified here.
# Make sure that this user can write the database file (default db.yml),
# otherwise the server can't update the database.
user: minidyndns
group: minidyndns

# Start of authority information. This is stuff others like to know about
# this DNS server. The serial is taken from the DB.
soa:
    # The domain name of our DNS server itself
    nameserver: ns.example.com
    # Mail address of the person responsible for the DNS server
    mail: dns.admin@example.com
    # Time to live in seconds of this SOA record. It won't change often so
    # it can be a rather large value (e.g. 86400 = 1 day).
    ttl: 86400
    # Stuff for secondary DNS servers. Since we're just a small DNS server
    # secondaries don't make sense. So just the default values.
    refresh_time: 86400
    retry_time: 7200
    expire_time: 3600000
    # Time not found responses (NXDOMAIN) can be cached. This is the maximum
    # time a newly added domain might need to be available world wide.
    negative_caching_ttl: 86400
