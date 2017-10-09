## Grafana

Installs [Grafana](https://grafana.com/), a time-series data analytics tool.

### Pillar

- `grafana.grafana_url`: URL of the Grafana server; required by Salt. Recommended value: `http://localuser:3000`
- `grafana.grafana_user`: Name of the Grafana admin user managed and required by Salt. Recommended value: `salt`.
- `grafana.grafana_password`: Password of the Grafana admin user managed and required by Salt.
- `grafana.datasources`: List of Grafana datasources to configure. Each element must be a dictionary containing the keys used by the `grafana4_datasource.present` function (except `orgname`). See [Salt documenation](https://docs.saltstack.com/en/latest/ref/states/all/salt.states.grafana4_datasource.html#salt.states.grafana4_datasource.present) for details.
- `grafana.open_port`: If `True`, the Grafana server port (3000/TCP) will be open. Intended for development use only.

## Reverse Proxy

In production, it is recommended to use the `nginx` state to configure the following Nginx virtual host:

```
nginx_virtual_hosts:
  grafana:
    names:
      - <grafana server fqdn>
    type: proxy
    proxy_addresses:
      - localhost:3000
```
