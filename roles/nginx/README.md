# Nginx

Installs the Nginx web server and configures Nginx virtual hosts.

## Variables

- `nginx_virtual_hosts`: List of virtual hosts to configure. Each element of the list should be a dictionary that contains the following key-value pairs:
  - `type`: Type of virtual host to configure. For now, `proxy` is the only option.
  - `names`: List of names for this virtual host.
  - `proxy_scheme`: If `type` is `proxy`, the scheme to use with the servers defined in `proxy_addresses`. If `type` is not `proxy`, this has no effect. Options are `http` and `https`. The default is `http`.
  - `proxy_addresses`: If `type` is `proxy`, the list of upstream addresses and ports which the reverse proxy will forward requests to. If `type` is not `proxy`, this has no effect. The default is `['localhost:8080']`
  - `enable_https`: If `True`, HTTPS will be enabled and enforced with redirection and HSTS headers. Otherwise, HTTPS will not be enabled. The default is `False`, but it is *strongly* recommended to enable HTTPS if possible.

```yaml
nginx_virtual_hosts:
  - type: proxy
    proxy_scheme: http
    proxy_addresses:
      - localhost:8080
    enable_https: True
    key_file: /etc/ssl/foo.key
    certificate_file: /etc/ssl/foo.crt
```

