# BIND

Configures [BIND](https://www.isc.org/downloads/bind/), a Domain Name System (DNS) server.

## States

- `bind`: Installs and configures BIND as a master or slave DNS server.

## Pillar

- `bind.forwarders`: List of addresses of upstream DNS servers which will be used as forwarders. If this is is empty, the nameserver will not forward queries. The default is an empty list.
- `bind.allowed_clients`: List of IP addresses and/or subnets which will be allowed to query the nameserver. If this is not defined, any address will be permitted to query the nameserver. **It is strongly recommended that this be defined to restrict queries**. The default is undefined.
- `bind.allowed_slaves`: List of IP addresses and/or subnets which will be allowed to transfer zone data. If this is not defined, any address will be permitted to transfer the zone. While zone data is not secret, limiting zone transfers is recommended to limit Denial of Service attacks. The default is undefined.
- `bind.zones`: Dictionary of zones that this nameserver will serve. The default is an empty dictionary. Each key in the dictionary is the domain name of the zone, such as `example.com` or `staging.example.com`. Each value is a dictionary which contains the following keys: 
  - `type`: Either `master` for a master zone or `slave` for a slave zone. The default is undefined.
  - `nameserver`: If type is `master`, the authoritative master nameserver for the zone. Example: `ns.example.com`. The default is undefined.
  - `masters`: If `type` is `slave`, the list of addresses of master nameservers for this zone. The default is undefined.
  - `ttl`: The default TTL for the zone, in seconds. The default is `3600`, which is one hour.
  - `email`: If type is `master`, the contact email address for the zone. Example: `root@example.com`. The default is undefined.
  - `records`: If type is `master`, the list of records contained in the zone. The default is undefined. Each element must be a dictionary which contains the configuration of the record. The records will appear in the zone in the same order they are listed here and that order must conform to BIND9 requirements (e.g. NS records must appear first). Each dictionary contains the following keys:
    - `type`: The type of record: one of `A`, `CNAME`, `MX`, `NS` or `SRV`. The default is undefined.
    - `name`: If `type` is `A`, `CNAME` or `SRV`, the record name. If the name is fully qualified, then this record is fully qualified. If the name is not fully qualified, the name of the zone will be appended to this name. Examples: `www`, `www.example.com.` The default is undefined.
    - `resource`: The resource that the record names. The default is undefined.
      - If `type` is `A`, the IP address the A record should point to. Example: `203.0.113.54`
      - If `type` is `CNAME`, the name of the CNAME or A record the CNAME should point to. Examples: 'support', `support.example.com.`
      - If `type` is `NS`, the name of the nameserver the NS record should point to. Example: `ns1.example.com`
      - If `type` is `MX` the priority and name of the mail server separated by whitespace. Example: `30 mail1.example.com`
      - If `type` is `SRV`, the priority, weight, port and name of the service separated by whitespace. Example: `10 10 5432 postgresql1.example.com`

