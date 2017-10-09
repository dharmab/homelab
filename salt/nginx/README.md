# Nginx

Installs and configures [Nginx](https://nginx.org/en/), a high performance HTTP and reverse proxy server.

## States

- `nginx`: Install and configure Nginx.

## Pillar

- `nginx_virtual_hosts`: Dictionary containing virtual host configuration. The default is an empty dictionary. Each value in the dictionary must be a dictionary containing the following keys:
  - `type`: Type of virtual host to configure. For now, `proxy` is the only option.
  - `names`: List of names for this virtual host.
  - `proxy_scheme`: If `type` is `proxy`, the scheme to use with the servers defined in `proxy_addresses`. If `type` is not `proxy`, this has no effect. Options are `http` and `https`. The default is `http`.
  - `proxy_addresses`: If `type` is `proxy`, the list of upstream addresses and ports which the reverse proxy will forward requests to. If `type` is not `proxy`, this has no effect. The default is `['localhost:8080']`
  - `is_default`: If `True`, this virtual host will be the default server. Only one virtual host may have this set to `True`. The default is `False`
