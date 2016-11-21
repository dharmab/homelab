# Network

Configures a CentOS 7 server's basic network settings (gateway, DNS, etc.)

## Variables

- `network_gateway`: Gateway address. If `None`, the default gateway is not set. The default is `None`.
- `network_primary_nameserver`: Primary nameserver address. The default is `8.8.8.8`
- `network_secondary_nameserver`: Primary nameserver address. The default is `8.8.4.4`

