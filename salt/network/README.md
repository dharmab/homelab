# Network

Configures basic networking.

## States

- `network`: Configures DNS resolvers and search domain.

## Pillar

- `network.resolvers`: List of DNS resolvers to use. Up to three resolvers may be defined. The default is the Google DNS server list: `['8.8.8.8', '8.8.4.4']`
- `network.search_domain`: DNS search domain to use. The default is to use the `domain` grain.
