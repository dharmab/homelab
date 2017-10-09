# Prometheus

Configures [Prometheus](https://prometheus.io/), an open-source systems monitoring and alerting toolkit.

## States

- `prometheus.server`: Installs and configures Prometheus
- `prometheus.cadvisor`: Install [cAdvisor](https://github.com/google/cadvisor), an agent which provides container metrics.
- `prometheus.node_exporter`: Install [node exporter](https://github.com/prometheus/node_exporter), an agent which provides host metrics.

## Pillar

### prometheus.server

- `prometheus.server_config`: Literal content of `prometheus.yml`. See [Prometheus documentation](https://prometheus.io/docs/operating/configuration/)
- `prometheus.open_server_port`: If `True`, the Prometheus server port (9090/TCP) will be open. Intended for development use only.

## Service Discovery

`prometheus.yml` must be configured with a service discovery configuration in order to know where to gather metrics. In a lab environment, either [static_config](https://prometheus.io/docs/operating/configuration/#<static_config>) or [dns_sd_config](https://prometheus.io/docs/operating/configuration/#<dns_sd_config>) may be used.

## Reverse Proxy

In production, it is recommended to use the `nginx` state to configure the following Nginx virtual host:

```
nginx_virtual_hosts:
  prometheus_server:
    names:
      - <prometheus server fqdn>
    type: proxy
    proxy_addresses:
      - localhost:9090
```
